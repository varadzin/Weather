//
//  WTCell.swift
//  Weather
//
//  Created by Frantisek Varadzin on 03/11/2020.
//

import UIKit

class WTCell: UICollectionViewCell {
    static let identifier = "WTCell"
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "01d.png")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Tokio"
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(weatherImage)
        contentView.addSubview(cityLabel)
        contentView.clipsToBounds = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
        weatherImage.frame = CGRect(x: 5, y:0,
                                    width: contentView.frame.size.width-10,
                                    height: contentView.frame.size.height-50)
    }
    
}

