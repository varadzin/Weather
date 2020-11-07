//
//  WTCell.swift
//  Weather
//
//  Created by Frantisek Varadzin on 03/11/2020.
//

import UIKit

class WTCell: UICollectionViewCell {
    static let reuseID = "WTCell"
    
    var WTImage = UIImageView()
 var cityLabel = UILabel()
  var tempLabel = UILabel()
    var cityTestName: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWTCell(with cityLabel: String) {
        cityTestName.text = cityLabel
        
    }
    
    private func configure() {
addSubview(WTImage)
        addSubview(cityLabel)
        addSubview(tempLabel)
        
        WTImage.image = UIImage(named:"01d.png")
        cityLabel.text = "Monday"
        tempLabel.text = "24C"
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
       WTImage.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false

        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
        
            
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            WTImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: padding),
            WTImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            WTImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            WTImage.heightAnchor.constraint(equalToConstant: 50),
            WTImage.widthAnchor.constraint(equalToConstant: 50),
            
            tempLabel.topAnchor.constraint(equalTo: WTImage.bottomAnchor, constant: 10),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tempLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
        
    }
    
    
    
}
