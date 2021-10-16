//
//  SearchFilterView.swift
//  DNS-SHOP
//
//  Created by Timur Isaev on 14.10.2021.
//

import UIKit

class SearchFilterView: UIView {

    private var pressCallBack: ((String) -> ())?
    
    private lazy var buttonSearch: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(ListImages.Filter.magnifier, for: .normal)
        button.addTarget(self, action: #selector(pressButtonNow), for: .touchUpInside)
        return button
    }()
    
    private lazy var textSearch: UITextField =  {
        let text = UITextField(frame: .zero)
        text.font = OurFonts.fontPTSansRegular14
        text.tintColor = PaletteApp.black
        text.placeholder = Tx.Filter.searchOnCategory
        text.delegate = self
        return text
    }()
    
    init(frame: CGRect, _ callback: @escaping ((String) -> ())) {
        super.init(frame: frame)

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
        
        self.addSubview(buttonSearch)
        buttonSearch.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        self.addSubview(textSearch)
        textSearch.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(8)
            make.right.equalTo(buttonSearch.snp.left).inset(-8)
        }
    }

    @objc func pressButtonNow() {
        pressCallBack!(textSearch.text ?? "")
    }
}

// MARK: Protocol: UITextFieldDelegate
extension SearchFilterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        pressCallBack!(textField.text ?? "")
        
        return true
    }
}
