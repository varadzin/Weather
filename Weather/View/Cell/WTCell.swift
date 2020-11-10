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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .label
        
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        var tempLabel = UILabel()
        
        tempLabel.textAlignment = .center
        tempLabel.tintColor = .label
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        return tempLabel
    }()
    
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(weatherImage)
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        weatherImage.frame = CGRect(x: 5,
                                    y:0,
                                    width: contentView.frame.size.width-10,
                                    height: contentView.frame.size.height-50)
        
        cityLabel.frame = CGRect(x: 5,
                                 y: contentView.frame.size.height-60,
                                 width: contentView.frame.size.width-10,
                                 height: 50)
        
        temperatureLabel.frame = CGRect(x: 5,
                                        y: contentView.frame.size.height-45,
                                        width: contentView.frame.size.width-10,
                                        height: 50)
    }
    
    public func configureCellLabel(label: String) {
        cityLabel.text = label
    }
    
    public func configureTempLabel(tempLabel: String) {
        temperatureLabel.text = tempLabel
    }
    
    public func configureWeatherImage(imageView: UIImage) {
        weatherImage.image = imageView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.text = nil
        temperatureLabel.text = nil
        weatherImage.image = nil
    }
}

