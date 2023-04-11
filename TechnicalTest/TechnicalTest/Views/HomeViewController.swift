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
        homeViewModel.getData().sink {_ in} receiveValue: { datas in
            self.applySnapshot(datas)
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
    
    private func applySnapshot(_ data: [HomeCellData]) {
      var snapshot = Snapshot()
      snapshot.appendSections([0])
      snapshot.appendItems(data)
      dataSource.apply(snapshot, animatingDifferences: true)
    }
}
