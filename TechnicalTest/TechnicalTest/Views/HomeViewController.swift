//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Marouene on 07/04/2023.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, HomeCellData>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, HomeCellData>

    var collectionView: UICollectionView!
    let cellId = "AdvertisementCell"
    let homeViewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var dataSource = makeDataSource()

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 120)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.register(AdvertisementCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        homeViewModel.getData()
            .receive(on: DispatchQueue.main)
            .sink {_ in} receiveValue: { datas in
            self.applySnapshot(datas)
        }.store(in: &cancellables)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "sort", style: .plain, target: self, action: #selector(sortTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterTapped))

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
    
    private func applySnapshot(_ data: [HomeCellData]) {
      var snapshot = Snapshot()
      snapshot.appendSections([0])
      snapshot.appendItems(data)
      dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func filterTapped(sender: UIBarButtonItem) {
        homeViewModel.getCategories()
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] categories in
                guard let self else { return}
                let alertController = UIAlertController(title: nil, message: "Catégorie", preferredStyle: .actionSheet)
                
                // show action sheet
                alertController.popoverPresentationController?.barButtonItem = sender
                alertController.popoverPresentationController?.sourceView = self.view
                let categoryAction = UIAlertAction(title: "Toutes les catégories", style: .default, handler: {
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
                let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: { _ in})
                
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }.store(in: &cancellables)
    }
    
    @objc func sortTapped(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Date de création", preferredStyle: .actionSheet)
        
        // show action sheet
        alertController.popoverPresentationController?.barButtonItem = sender
        alertController.popoverPresentationController?.sourceView = self.view
      
        let ascendantAction = UIAlertAction(title: "Du plus ancien", style: .default, handler: { _ in
            self.homeViewModel.sortByDateAscendant.send(true)
            self.dismiss(animated: true)
        })
        let descendantAction = UIAlertAction(title: "Du plus récent", style: .default, handler: { _ in
            self.homeViewModel.sortByDateAscendant.send(false)
            self.dismiss(animated: true)

        })
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: { _ in})
        
        alertController.addAction(ascendantAction)
        alertController.addAction(descendantAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
