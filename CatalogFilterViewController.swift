//
//  CatalogFilterViewController.swift
//  DNS-SHOP
//
//  Created by Timur Isaev on 12.10.2021.
//  
//

import UIKit

// MARK: CatalogFilterPresenterToViewProtocol (Presenter -> View)
protocol CatalogFilterPresenterToViewProtocol: AnyObject {
    func popViewController()
    func updateUIFilter(receipts: [CatalogProductsModel.Receipt])
}

// MARK: CatalogFilterRouterToViewProtocol (Router -> View)
protocol CatalogFilterRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

// MARK: CatalogFilterDelegate (Delegate)
protocol CatalogFilterDelegate {
    func didFinishSelectedReceipt(_ receipt: CatalogProductsModel.Receipt)
}

class CatalogFilterViewController: UIViewController {
    
    // MARK: - Property
    var presenter: CatalogFilterViewToPresenterProtocol!
    var delegate: CatalogFilterDelegate?
    
    private lazy var navigationView: CustomNavigationView = {
        let navigation = CustomNavigationView(frame: .zero)
        navigation.title = Tx.Filter.title
        
        let leftButton = UIButton(frame: .zero)
        leftButton.setImage(UIImage(named: "back"), for: .normal)
        leftButton.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        navigation.leftButton = leftButton
        leftButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(4)
        }
        
        let rightButton = UIButton(frame: .zero)
        rightButton.setTitle(Tx.Filter.resetAll, for: .normal)
        rightButton.titleLabel?.font = OurFonts.fontPTSansRegular14
        rightButton.setTitleColor(PaletteApp.deepBlue, for: .normal)
        rightButton.addTarget(self, action: #selector(pressResetAllButton), for: .touchUpInside)
        navigation.rightButton = rightButton
        rightButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        return navigation
    }()
    
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = PaletteApp.homeScreenBackgoundGrey
        
        return view
    }()
    
    private lazy var receiptFilterView: ReceiptFilterView = {
        let view = ReceiptFilterView(frame: .zero)
        view.delegate = self
        
        return view
    }()
    
    private let contentFilterView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = PaletteApp.homeScreenBackgoundGrey
        
        return view
    }()
    
    private let leftView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = PaletteApp.gray
        
        return view
    }()
    
    private let rightView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = PaletteApp.white
        
        return view
    }()
    
    private var widthLeftView: CGFloat {
        let width = UIScreen.main.bounds.width
        return width * 40 / 100
    }
    
    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        view.backgroundColor = PaletteApp.white
        
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(view)
            make.height.equalTo(58)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(navigationView.snp.bottom)
        }
        
        contentView.addSubview(receiptFilterView)
        receiptFilterView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationView.snp.bottom).inset(-1)
            make.height.equalTo(60)
        }

        contentView.addSubview(contentFilterView)
        contentFilterView.snp.makeConstraints { make in
            make.top.equalTo(receiptFilterView.snp.bottom).inset(-1)
            make.left.right.bottom.equalToSuperview()
        }
        
        contentFilterView.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(widthLeftView)
        }
        
        contentFilterView.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(leftView.snp.right)
        }
    }
    
    // MARK: - Objective-C
    @objc private func pressBackButton(_ sender: UIButton) {
        presenter.backButtonPressed()
    }
    
    @objc private func pressResetAllButton(_ sender: UIButton) {
    
    }
}

// MARK: CatalogFilterPresenterToViewProtocol 
extension CatalogFilterViewController: CatalogFilterPresenterToViewProtocol{
    func updateUIFilter(receipts: [CatalogProductsModel.Receipt]) {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        receiptFilterView.updateUIFilter(receipts: receipts)
    }
    
    func popViewController() {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: CatalogFilterRouterToViewProtocol
extension CatalogFilterViewController: CatalogFilterRouterToViewProtocol{
    func presentView(view: UIViewController) {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.debugMessage("\(#fileID) -> \(#function)")
        
        navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: Extension: ReceiptFilterDelegate
extension CatalogFilterViewController: ReceiptFilterDelegate {
    func didFinishEntering(_ searchString: String) {
        presenter.pressSearchButton(withSearchText: searchString)
    }
    
    func didFinishSelected(_ receipt: CatalogProductsModel.Receipt) {
        delegate?.didFinishSelectedReceipt(receipt)
        popViewController()
    }
}
