//
//  CatalogFilterRouter.swift
//  DNS-SHOP
//
//  Created by Timur Isaev on 12.10.2021.
//  
//

import Foundation

// MARK: CatalogFilterPresenterToRouterProtocol (Presenter -> Router)
protocol CatalogFilterPresenterToRouterProtocol: AnyObject {

}

class CatalogFilterRouter {

    // MARK: Properties
    weak var view: CatalogFilterRouterToViewProtocol!
}

// MARK: CatalogFilterPresenterToRouterProtocol
extension CatalogFilterRouter: CatalogFilterPresenterToRouterProtocol {
    
}