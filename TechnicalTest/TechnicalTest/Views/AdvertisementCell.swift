//
//  AdvertisementCell.swift
//  TechnicalTest
//
//  Created by Marouene on 11/04/2023.
//

import UIKit

class AdvertisementCell: UICollectionViewCell {
    
    override var reuseIdentifier: String {
        "AdvertisementCell"
    }
    
    private let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Theme.Color.backgroundColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Theme.Layout.cornerRadius
        imageView.layer.borderWidth = Theme.Layout.borderWidth
        imageView.layer.borderColor = Theme.Color.quaternaryColor.cgColor
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 2
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categorieLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let globalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Theme.Layout.interItemVerticalSpacing
        return stackView
    }()
    
    private let textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    private func addViews(){
        globalStackView.addArrangedSubview(adImageView)
        textsStackView.addArrangedSubview(titleLabel)
        textsStackView.addArrangedSubview(priceLabel)
        textsStackView.addArrangedSubview(categorieLabel)
        globalStackView.addArrangedSubview(textsStackView)
        addSubview(globalStackView)
        adImageView.heightAnchor.constraint(equalToConstant: Theme.Layout.listImageHeight).isActive = true
        adImageView.widthAnchor.constraint(equalToConstant: Theme.Layout.listImageWidth).isActive = true
        globalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Layout.generalVerticalMargin).isActive = true
        globalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: Theme.Layout.generalHorizontalMargin).isActive = true
        globalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Theme.Layout.generalHorizontalMargin).isActive = true
        globalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.Layout.generalVerticalMargin).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ ad: RichAdvertisement) {
        categorieLabel.text = ad.category.name
        titleLabel.text = ad.title
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedValue = formatter.string(from: .init(floatLiteral: ad.price))
        priceLabel.text = formattedValue
        let placeHolderImage = UIImage(systemName: "photo")?.withTintColor(.lightGray)
        if let url = ad.imagesURL.thumb {
            adImageView.loadImage(url, placeHolder: placeHolderImage)
        } else {
            adImageView.image = placeHolderImage
        }
        backgroundColor = ad.isUrgent ? Theme.Color.urgentColor : Theme.Color.backgroundColor
    }
}
