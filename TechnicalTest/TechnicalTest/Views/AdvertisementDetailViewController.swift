//
//  AdvertisementDetailViewController.swift
//  TechnicalTest
//
//  Created by Marouene on 12/04/2023.
//

import UIKit

class AdvertisementDetailViewController: UIViewController {
    private let viewModel: AdvertisementDetailViewModelProtocol
    
    private let scrollView = UIScrollView()
    
    private let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Theme.Color.backgroundColor
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Theme.Layout.cornerRadius
        imageView.layer.borderWidth = Theme.Layout.borderWidth
        imageView.layer.borderColor = Theme.Color.quaternaryColor.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = Theme.Color.quaternaryColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let siretLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = Theme.Color.quaternaryColor
        label.numberOfLines = 0
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
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let globalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Theme.Layout.interItemVerticalSpacing
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Theme.Layout.interItemVerticalSpacing
        return stackView
    }()
    
    init(viewModel: AdvertisementDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWith(viewModel.advertisement)
    }
    
    func setupWith(_ ad: RichAdvertisement) {
        categorieLabel.text = ad.category.name
        titleLabel.text = ad.title
        descriptionLabel.text = ad.description
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
        view.backgroundColor = ad.isUrgent ? Theme.Color.urgentColor : Theme.Color.backgroundColor
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
        creationDateLabel.text = ["detail.creation.date.label".localized(), dateFormatter.string(from: ad.creationDate)]
            .compactMap({ $0 })
            .joined(separator: " ")
        
        if let siret = ad.siret {
            siretLabel.isHidden = false
            siretLabel.text = ["siret".localized(), siret]
                .compactMap({ $0 })
                .joined(separator: " ")

        } else {
            siretLabel.isHidden = true
        }
    }
    
    private func setupView(){
        view.backgroundColor = Theme.Color.backgroundColor
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.fit(view)

        adImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        adImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        globalStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(globalStackView)
        globalStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        globalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(2 * Theme.Layout.generalHorizontalMargin)).isActive = true
        globalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Theme.Layout.generalVerticalMargin).isActive = true
        globalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Theme.Layout.generalVerticalMargin).isActive = true
        titleStackView.addArrangedSubview(titleLabel)
        globalStackView.addArrangedSubview(titleStackView)
        let clearView = UIView()
        
        clearView.backgroundColor = .clear
        clearView.addSubview(adImageView)
        clearView.topAnchor.constraint(equalTo: adImageView.topAnchor).isActive = true
        clearView.heightAnchor.constraint(equalTo: adImageView.heightAnchor).isActive = true
        clearView.centerXAnchor.constraint(equalTo: adImageView.centerXAnchor).isActive = true
        imageStackView.addArrangedSubview(clearView)
        globalStackView.addArrangedSubview(imageStackView)
        clearView.widthAnchor.constraint(equalTo: globalStackView.widthAnchor).isActive = true

        detailsStackView.addArrangedSubview(priceLabel)
        detailsStackView.addArrangedSubview(categorieLabel)
        detailsStackView.addArrangedSubview(creationDateLabel)
        detailsStackView.addArrangedSubview(siretLabel)
        detailsStackView.addArrangedSubview(descriptionLabel)
        globalStackView.addArrangedSubview(detailsStackView)
    }
    
}
