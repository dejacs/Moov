//
//  Network.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation
import UIKit

public protocol Networking {
    func fetchData<T: Decodable>(
        with endpoint: EndpointProtocol,
        resultType: T.Type,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy,
        completion: @escaping (Result<T, ApiError>) -> Void
    )
    func fetchImage(
        with endpoint: EndpointProtocol,
        completion: @escaping (Result<UIImage, ApiError>) -> Void
    )
}

public final class Network: Networking {
    private let session: SessionProtocol
    private let queue: DispatchQueueProtocol
    
    public init(session: SessionProtocol = URLSession.shared, queue: DispatchQueueProtocol = DispatchQueue.main) {
        self.session = session
        self.queue = queue
    }
    
    public func fetchData<T: Decodable>(
        with endpoint: EndpointProtocol,
        resultType: T.Type,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy,
        completion: @escaping (Result<T, ApiError>) -> Void
    ) {
        guard let url = URL(string: endpoint.urlText) else {
            completion(.failure(.urlParse))
            return
        }
        
        session.makeRequest(with: url) { data, response, error in
            self.queue.callAsync {
                if let hasError = self.verifyError(data: data, response: response, error: error) {
                    completion(.failure(hasError))
                    return
                }
                guard let jsonData = data else {
                    completion(.failure(.nilData))
                    return
                }
                let decodedData: T? = self.decodeData(data: jsonData, decodingStrategy: decodingStrategy)
                guard let unwrappedDecodedData = decodedData else {
                    completion(.failure(.jsonParse))
                    return
                }
                completion(.success(unwrappedDecodedData))
            }
        }
    }
    
    public func fetchImage(
        with endpoint: EndpointProtocol,
        completion: @escaping (Result<UIImage, ApiError>) -> Void
    ) {
        guard let url = URL(string: endpoint.urlText) else {
            completion(.failure(.urlParse))
            return
        }
        
        session.makeRequest(with: url) { data, response, error in
            self.queue.callAsync {
                if let hasError = self.verifyError(data: data, response: response, error: error) {
                    completion(.failure(hasError))
                    return
                }
                guard let jsonData = data else {
                    completion(.failure(.nilData))
                    return
                }
                guard let parsedImage = UIImage(data: jsonData) else {
                    completion(.failure(.imageParse))
                    return
                }
                completion(.success(parsedImage))
            }
        }
    }
}
    
private extension Network {
    func decodeData<T: Decodable>(data: Data?, decodingStrategy: JSONDecoder.KeyDecodingStrategy) -> T? {
        guard let unwrappedData = data else { return nil }
        return try? JSONDecoder(keyDecodingStrategy: decodingStrategy).decode(T.self, from: unwrappedData)
    }
    
    func verifyError(data: Data?, response: URLResponse?, error: Error?) -> ApiError? {
        if let error = error {
            return .server(error: error)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return .nilResponse
        }
        let statusCode = StatusCode.getType(code: httpResponse.statusCode)
        return statusCode != .success ? .statusCode(code: statusCode) : nil
    }
}
