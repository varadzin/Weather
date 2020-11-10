//
//  WTSearchTF.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTSearchTF: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray3.cgColor
        autocorrectionType = .no
        autocapitalizationType = .words
        textColor = .label
        textAlignment = .center
        tintColor = .label
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        returnKeyType = .search
        keyboardType = .default
        placeholder = "Enter city"
        
    }
}
