//
//  CatalogFilterConfigurator.swift
//  DNS-SHOP
//
//  Created by Timur Isaev on 12.10.2021.
//  
//

import UIKit

class CatalogFilterConfigurator {
    func configure(withReceipts receipts: [CatalogProductsModel.Receipt]) -> CatalogFilterViewController {
        let view = CatalogFilterViewController()
        let presenter = CatalogFilterPresenter()
        let router = CatalogFilterRouter()
        let interactor = CatalogFilterInteractor(withReceipts: receipts)
        
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
