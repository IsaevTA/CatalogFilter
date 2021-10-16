//
//  ReceiptFilterView.swift
//  DNS-SHOP
//
//  Created by Тимур Исаев on 15.10.2021.
//

import UIKit

protocol ReceiptFilterDelegate {
    func didFinishEntering(_ searchString: String)
    func didFinishSelected(_ receipt: CatalogProductsModel.Receipt)
}

class ReceiptFilterView: UIView {
    var delegate: ReceiptFilterDelegate?
    
    private let filtersSlider: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = PaletteApp.white
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private let filtersSliderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    var arrayViews: [UIView] = [] {
        didSet {
            filtersSliderStack.removeAll()
            arrayViews.forEach { item in
                filtersSliderStack.addArrangedSubview(item)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }

    private func commonInit() {
        addSubview(filtersSlider)
        filtersSlider.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        
        filtersSlider.addSubview(filtersSliderStack)
        filtersSliderStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
            make.left.right.equalToSuperview().inset(12)
        }
    }
    
    func updateUIFilter(receipts: [CatalogProductsModel.Receipt]) {
        let searchView = SearchFilterView(frame: .zero) { [self] searchString in
            delegate?.didFinishEntering(searchString)
        }
        arrayViews.append(searchView)
        
        receipts.forEach { receipt in
            let button = ReceiptFilterButton(frame: .zero, receipt: receipt) { [self] currentReceipt in
                delegate?.didFinishSelected(currentReceipt)
            }
            arrayViews.append(button)
        }
    }
}
