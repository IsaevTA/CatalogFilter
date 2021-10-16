//
//  CatalogFilterInteractor.swift
//  DNS-SHOP
//
//  Created by Timur Isaev on 12.10.2021.
//  
//

import Foundation

// MARK: CatalogFilterPresenterToInteractorProtocol (Presenter -> Interactor)
protocol CatalogFilterPresenterToInteractorProtocol: AnyObject {
    var currentReceipts: [CatalogProductsModel.Receipt] { get }
}

class CatalogFilterInteractor {

    // MARK: Properties
    weak var presenter: CatalogFilterInteractorToPresenterProtocol!

    private var receipts: [CatalogProductsModel.Receipt]
    
    init(withReceipts receipts: [CatalogProductsModel.Receipt]) {
        self.receipts = receipts
    }
}

// MARK: CatalogFilterPresenterToInteractorProtocol
extension CatalogFilterInteractor: CatalogFilterPresenterToInteractorProtocol {
    var currentReceipts: [CatalogProductsModel.Receipt] {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        return receipts
    }
    
    
}
