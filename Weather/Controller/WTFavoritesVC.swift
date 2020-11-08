//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTFavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
 
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

    }
    
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        view.backgroundColor = .white
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
       
        
        
        
        
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(WTCell.self, forCellWithReuseIdentifier: WTCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.identifier, for: indexPath)
    
        return cell
    }
    
   
}
    
   



















//    let dataSource: [String] = ["Kosice", "Tokio", "Paris", "Toronto", "Revuca"]
//
//    var collectionView: UICollectionView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        configureCollectionView()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//
//    func configureCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
//        view.addSubview(collectionView)
//        collectionView.backgroundColor = .systemPink
//        collectionView.register(WTCell.self, forCellWithReuseIdentifier: WTCell.reuseID)
//    }
//
//
//    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
//        let width                       = view.bounds.width
//        let padding: CGFloat            = 12
//        let minimumItemSpacing: CGFloat = 10
//        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
//        let itemWidth                   = availableWidth / 3
//
//        let flowLayout                  = UICollectionViewFlowLayout()
//        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
//
//        return flowLayout
//    }
//
//
//
//}
//
//








//    enum Section {
//        case main
//
//    }
//    var cityName: String!
//    var followers: [Follower] = []
//
//    var collectionView: UICollectionView!
//    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       configureCollectionView()
//        configureDataSource()
//
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//    }
//
//    func configureCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
//        view.addSubview(collectionView)
//        collectionView.backgroundColor = .systemPink
//        collectionView.register(WTCell.self, forCellWithReuseIdentifier: WTCell.reuseID)
//
//    }
//
//
//    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
//        let width = view.bounds.width
//        let padding: CGFloat = 12
//        let minimumItemSpacing: CGFloat = 10
//        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
//        let itemWidth = availableWidth / 3
//
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
//
//        return flowLayout
//    }
//
//
//    func getFollowers() {
//        WTManager.fetchWeather(cityName: "Tokio", page: 1 ) { result in
//
//            switch result {
//            case .success(let followers):
//                self.followers = followers
//                self.updateData()
//
//            case .failure: print("error")
//
//            }
//        }
//    }
//
//
//    func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.reuseID, for: indexPath) as! WTCell
//            cell.set(follower: follower)
//            return cell
//
//
//        })
//
//
//
//    }
//
//func updateData() {
//    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
//    snapshot.appendSections([.main])
//    snapshot.appendItems([.init(weatherIcon: "10d", favoriteCitys: "Tokio")])
//    DispatchQueue.main.async {
//        self.dataSource.apply(snapshot, animatingDifferences: true)
//    }
//
//
//
//
//
//
//
//}

