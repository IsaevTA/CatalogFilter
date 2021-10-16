//
//  SeeAllSwitch.swift
//  DNS-SHOP
//
//  Created by Тимур Исаев on 15.10.2021.
//

import UIKit

class SeeAllSwitch: UIView {
    private var pressCallBack: (() -> ())?
    
    init(frame: CGRect, _ callback: @escaping (() -> ())) {
        super.init(frame: frame)
        
        commonInit()
        pressCallBack = callback
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .clear
        
        let currentSwitch = UISwitch(frame: .zero)
        
    }


}
