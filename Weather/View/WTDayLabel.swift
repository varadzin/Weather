//
//  WTDayLabel.swift
//  Weather
//
//  Created by Frantisek Varadzin on 02/11/2020.
//

import UIKit

class WTDayLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init (text: String) {
        super.init(frame: .zero)
        self.text = text
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
      
        font = UIFont.preferredFont(forTextStyle: .subheadline)
        tintColor = .label
    }
}
