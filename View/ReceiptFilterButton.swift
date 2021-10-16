//
//  ReceiptFilterButton.swift
//  DNS-SHOP
//
//  Created by Timur Isaev on 13.10.2021.
//

import UIKit

class ReceiptFilterButton: UIView {
    private var pressCallBack: ((CatalogProductsModel.Receipt) -> ())?
    private var receipt: CatalogProductsModel.Receipt!
    
    init(frame: CGRect, receipt: CatalogProductsModel.Receipt, _ callback: @escaping ((CatalogProductsModel.Receipt) -> ())) {
        super.init(frame: frame)
        
        self.receipt = receipt
        commonInit()
        pressCallBack = callback
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = PaletteApp.gray
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        let label = UILabel(frame: .zero)
        label.textColor = PaletteApp.black
        label.text = receipt.title
        label.font = OurFonts.fontPTSansRegular14
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(8)
        }
        
        
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(pressButtonNow), for: .touchUpInside)
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    @objc func pressButtonNow() {
        pressCallBack!(receipt)
    }
}
