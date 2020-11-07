//
//  WTSearchBTN.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit


class WTSearchBTN: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String, titleColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        configure()
        
        
    }
    
    
    private func configure() {
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 0.5
//        setTitle("search", for: .normal)
//        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        
    }
    
    
}
