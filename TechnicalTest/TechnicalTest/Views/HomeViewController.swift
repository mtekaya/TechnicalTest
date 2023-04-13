//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Marouene on 07/04/2023.
//

import UIKit
import Combine

protocol HomeViewProtocol: AnyObject {
    func homeView(viewController: HomeViewController, didSelect advertisement: RichAdvertisement)
}

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, RichAdvertisement>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, RichAdvertisement>
    
    weak var delegate: HomeViewProtocol?
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Theme.Color.backgroundColor
        return collectionView

    }()
    private let cellId = "AdvertisementCell"
    private let homeViewModel: HomeViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private let activityIndicator = UIActivityIndicatorView.init(style: .large)
    
    private lazy var dataSource = makeDataSource()
    
    init(homeViewModel: HomeViewModelProtocol) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.itemSize = getItemSize()
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    private func setupView() {
        view.backgroundColor = Theme.Color.backgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "home.sort".localized(), style: .plain, target: self, action: #selector(sortTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "home.filter".localized(), style: .plain, target: self, action: #selector(filterTapped))
        // setup collectionView
        collectionView.register(AdvertisementCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.fit(view)
        // setup activityIndicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true


    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        homeViewModel.getData()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.activityIndicator.stopAnimating()

            } receiveValue: {[weak self] datas in
                self?.activityIndicator.stopAnimating()
                self?.applySnapshot(datas)
            }.store(in: &cancellables)
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, advertissement) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "AdvertisementCell",
                    for: indexPath) as? AdvertisementCell
                cell?.setupWith(advertissement)
                return cell
            })
        return dataSource
    }
    
    private func applySnapshot(_ data: [RichAdvertisement]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func filterTapped(sender: UIBarButtonItem) {
        homeViewModel.getCategories()
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] categories in
                guard let self else { return}
                let alertController = UIAlertController(title: nil, message: "home.category.label".localized(), preferredStyle: .actionSheet)
                alertController.popoverPresentationController?.barButtonItem = sender
                alertController.popoverPresentationController?.sourceView = self.view
                let categoryAction = UIAlertAction(title: "home.category.all".localized(), style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.homeViewModel.setcategory(selectedCategory: nil)
                    self.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(categoryAction)
                for category in categories {
                    let categoryAction = UIAlertAction(title: category.name, style: .default, handler: {
                        (alert: UIAlertAction!) -> Void in
                        self.homeViewModel.setcategory(selectedCategory: category.id)
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(categoryAction)
                }
                let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: { _ in})
                
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }.store(in: &cancellables)
    }
    
    @objc private func sortTapped(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "home.creation.date".localized(), preferredStyle: .actionSheet)
        
        // show action sheet
        alertController.popoverPresentationController?.barButtonItem = sender
        alertController.popoverPresentationController?.sourceView = self.view
        
        let ascendantAction = UIAlertAction(title: "home.sort.oldest".localized(), style: .default, handler: { _ in
            self.homeViewModel.setSortByDateAscendant(ascendant: true)
            self.dismiss(animated: true)
        })
        let descendantAction = UIAlertAction(title: "home.sort.newest".localized(), style: .default, handler: { _ in
            self.homeViewModel.setSortByDateAscendant(ascendant: false)
            self.dismiss(animated: true)
            
        })
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: { _ in})
        
        alertController.addAction(ascendantAction)
        alertController.addAction(descendantAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func getItemSize() -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let minWidth: CGFloat = 300
        let margin: CGFloat = 16
        let minItemWidthwithMargin = minWidth + margin * 2
        let numberOfItem = Int(width / minItemWidthwithMargin)
        let totalMargin: CGFloat = CGFloat(numberOfItem) * margin * 2
        let calculatedWidth: CGFloat = (width - totalMargin) / CGFloat(numberOfItem)
        return CGSizeMake(calculatedWidth, 120)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let advertisement = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        delegate?.homeView(viewController: self, didSelect: advertisement)
    }
}
