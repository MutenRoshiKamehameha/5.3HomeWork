//
//  ViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 10/2/23.
//

import UIKit
import SnapKit
import Kingfisher


class MenuViewController: UIViewController {
    
    private var isSearching = false
    
    private var filtredProductArray = [Drinks](){
        didSet{
        menuCollectionView.reloadData()
    }
}
    
     var productArray = [Drinks](){
        didSet{
            menuCollectionView.reloadData()
        }
    }
    
    
    private var mainTitlleLabel : UILabel = {
        let label = UILabel()
        label.text = "Main Dishes"
        label.font = UIFont(name: "Avenir Heavy", size: 32)
        label.textColor = .white
        return label
    }()
    
    
    private var commomTitlleLabel : UILabel = {
        let label = UILabel()
        label.text = "Find the best selling dishes. All meals are preparred fresh."
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    private var searchMenuSearchBar : UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.placeholder = "      Search Menu"
        searchbar.clipsToBounds = true
        searchbar.layer.cornerRadius = 18
        return searchbar
    }()
    
    
    private var backGroundView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        view.backgroundColor = UIColor(cgColor: CGColor(red: 251/265,
                                                      green: 237/265,
                                                      blue: 234/265,
                                                      alpha: 1))
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.init(red: 265/265,
                                               green: 50/265,
                                               blue: 50/265,
                                              alpha: 0.5).cgColor
         return view
    }()
    
    
    private var menuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 140, height: 230)
        flowLayout.minimumLineSpacing = 13
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(cgColor: CGColor(red: 251/265,
                                                                green: 237/265,
                                                                blue: 234/265,
                                                                alpha: 1))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.cornerRadius = 5
        return collectionView
    }()
    
    
    private func setupCollectionView() {
       
        self.menuCollectionView.delegate = self
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.register(MenuCollectionViewCell.self,
                                         forCellWithReuseIdentifier: MenuCollectionViewCell.reuseID)
    }
    
    
    private let borderLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 206/265,
                                                        green: 206/265,
                                                        blue: 265/265,
                                                        alpha: 0.85))
        view.layer.cornerRadius = 3
        return view
    }()
    
    
    private func fetchCoctailsData(){
        Task {
            productArray = try await NetworkLayer.shared.fetchData().drinks
        }
    }
    
    
    private func setupMenuUI(){
        view.backgroundColor = UIColor(cgColor: CGColor(red: 255/265,
                                                        green: 95/265,
                                                        blue: 80/265,
                                                        alpha: 1))
        
        view.addSubview(mainTitlleLabel)
        mainTitlleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(commomTitlleLabel)
        commomTitlleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitlleLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(searchMenuSearchBar)
        searchMenuSearchBar.snp.makeConstraints { make in
            make.top.equalTo(commomTitlleLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().offset(-170)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(backGroundView)
            backGroundView.snp.makeConstraints { make in
            make.top.equalTo(searchMenuSearchBar.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(30)
        }
        
        view.addSubview(menuCollectionView)
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(backGroundView.snp.top).offset(2)
            make.width.equalToSuperview().offset(-55)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
                
        view.addSubview(borderLineView)
        borderLineView.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.bottom.equalToSuperview().inset(95)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
        }
        
}
    
    override func loadView() {
        super.loadView()
        setupMenuUI()
        setupCollectionView()
        fetchCoctailsData()
        self.searchMenuSearchBar.delegate = self
        navigationItem.hidesBackButton = true
        print( UsDef.shared.savedUsersArray)
    }
  
    
}



extension MenuViewController:  UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearching {
             return filtredProductArray.count
       }else{
             return productArray.count
   }
        
}
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = menuCollectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.reuseID,
            for: indexPath
        ) as? MenuCollectionViewCell else{ fatalError() }

        if isSearching{
            let product = filtredProductArray[indexPath.row]
            cell.displayInfo(product: product)
        }else{
            let product = productArray[indexPath.row]
            cell.displayInfo(product: product)
        }
        tabBarController?.tabBar.isHidden = false
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isSearching{
            let selectedCoctailVC = SelectProductViewController(dish: filtredProductArray[indexPath.row])
            navigationController?.pushViewController(selectedCoctailVC, animated: true)
        }else{
            let selectedCoctailVC = SelectProductViewController(dish: productArray[indexPath.row])
            navigationController?.pushViewController(selectedCoctailVC, animated: true)
        }
    }
}


extension MenuViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filtredProductArray.removeAll()
        
         filtredProductArray = productArray.filter {$0.strDrink.lowercased().contains(searchText.lowercased())}
        
        if searchBar.text == ""{
            isSearching = false
            menuCollectionView.reloadData()
        }else{
            isSearching = true
            menuCollectionView.reloadData()
        }
    }
}



