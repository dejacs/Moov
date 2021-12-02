//
//  DispatchQueueProtocol.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation

protocol DispatchQueueProtocol {
    func callAsync(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping () -> Void)
}

extension DispatchQueueProtocol {
    func callAsync(
        group: DispatchGroup? = nil,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = [],
        execute work: @escaping () -> Void) {
        callAsync(group: group, qos: qos, flags: flags, execute: work)
    }
}
