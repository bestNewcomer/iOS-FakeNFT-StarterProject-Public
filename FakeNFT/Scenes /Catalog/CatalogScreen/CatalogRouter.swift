//
//  CatalogRouter.swift
//  FakeNFT
//
//  Created by Леонид Турко on 18.04.2024.
//

import Foundation

import UIKit

protocol CatalogRouterProtocol {
    func presentViewController(_ viewControllerToPresent: UIViewController)
}

class CatalogRouter {
    weak var viewController: UIViewController?
}

extension CatalogRouter: CatalogRouterProtocol {
    func presentViewController(_ viewControllerToPresent: UIViewController) {
        viewController?.present(viewControllerToPresent, animated: true)
    }
}
