//
//  AdvertisementCell.swift
//  TechnicalTest
//
//  Created by compte temporaire on 11/04/2023.
//

import UIKit

class AdvertisementCell: UICollectionViewCell {

    override var reuseIdentifier: String {
        "AdvertisementCell"
    }
    
    let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = .init(systemName: "light.beacon.max.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categorieLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let isUrgentFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = .init(systemName: "light.beacon.max.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .red
        return imageView
    }()

    let globalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    let textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    func addViews(){
        globalStackView.addArrangedSubview(adImageView)
        textsStackView.addArrangedSubview(titleLabel)
        textsStackView.addArrangedSubview(priceLabel)
        textsStackView.addArrangedSubview(categorieLabel)
        textsStackView.addArrangedSubview(isUrgentFlag)
        globalStackView.addArrangedSubview(textsStackView)
        addSubview(globalStackView)
        adImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        adImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        globalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        globalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        globalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        globalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ ad: HomeCellData) {
        categorieLabel.text = ad.category.name
        titleLabel.text = ad.title
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedValue = formatter.string(from: .init(floatLiteral: ad.price))
        priceLabel.text = formattedValue
        let placeHolderImage = UIImage(systemName: "photo")?.withTintColor(.lightGray)
        if let url = ad.imagesURL.small {
            adImageView.loadImage(url, placeHolder: placeHolderImage)
        } else {
            adImageView.image = placeHolderImage
        }
        isUrgentFlag.isHidden = !ad.isUrgent
    }
}
