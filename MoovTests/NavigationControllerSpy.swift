//
//  NavigationControllerSpy.swift
//  MoovTests
//
//  Created by Jade Silveira on 03/12/21.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    private(set) var pushViewControllerCallsCount: Int = 0
    private(set) var pushViewControllerReceivedInvocations = [UIViewController]()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCallsCount += 1
        pushViewControllerReceivedInvocations.append(viewController)
    }
}
