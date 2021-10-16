//
//  CatalogFilterPresenter.swift
//  DNS-SHOP
//
//  Created by Timur Isaev on 12.10.2021.
//  
//

import Foundation

// MARK: CatalogFilterViewToPresenterProtocol (View -> Presenter)
protocol CatalogFilterViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func backButtonPressed()
    func pressSearchButton(withSearchText searctText: String)
}

// MARK: CatalogFilterInteractorToPresenterProtocol (Interactor -> Presenter)
protocol CatalogFilterInteractorToPresenterProtocol: AnyObject {

}

class CatalogFilterPresenter {

    // MARK: Properties
    var router: CatalogFilterPresenterToRouterProtocol!
    var interactor: CatalogFilterPresenterToInteractorProtocol!
    weak var view: CatalogFilterPresenterToViewProtocol!
}

// MARK: CatalogFilterViewToPresenterProtocol
extension CatalogFilterPresenter: CatalogFilterViewToPresenterProtocol {
    func pressSearchButton(withSearchText searctText: String) {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        logger.debugMessage(searctText)
    }
    
    func backButtonPressed() {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        view.popViewController()
    }
    
    func viewDidLoad() {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        view.updateUIFilter(receipts: interactor.currentReceipts)
    }
}

// MARK: CatalogFilterInteractorToPresenterProtocol
extension CatalogFilterPresenter: CatalogFilterInteractorToPresenterProtocol {
    
}
