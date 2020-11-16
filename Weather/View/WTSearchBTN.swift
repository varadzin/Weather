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
        layer.borderWidth = 1
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        setTitleColor(.white, for: .highlighted)
        
        setBackgroundColor(color: .systemBlue, forState: .highlighted)
        
    }
    
}

extension WTSearchBTN {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
