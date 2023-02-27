//
//  BasketViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 17/2/23.
//

import UIKit
import SnapKit

class BasketViewController: UIViewController{
    
    
    private var totPrice = 0{
        didSet{
            totalPriceLabel.text = "\(totPrice)"
        }
    }
    
    private let topBorderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 206/265,
                                                        green: 206/265,
                                                        blue: 265/265,
                                                        alpha: 0.85))
        view.layer.cornerRadius = 3
        return view
    }()
    
    
    private let basketTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Basket"
        label.font = UIFont(name: "Avenir Heavy", size: 33)
        label.textAlignment = .left
        return label
    }()
    
    
    private let bottomBorderLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 206/265,
                                                        green: 206/265,
                                                        blue: 265/265,
                                                        alpha: 0.85))
        view.layer.cornerRadius = 3
        return view
    }()
    
    
    private let isEmtyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = " Nothing was added to basket..."
        label.textColor = .gray
        label.font = UIFont(name: "Avenir", size: 17)
        label.textAlignment = .center
        return label
    }()
    
    
    private let basketTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor =  UIColor(cgColor: CGColor(red: 251/265,
                                                          green: 237/265,
                                                          blue: 234/265,
                                                          alpha: 0.85))
        table.rowHeight = 140
        return table
    }()
    
    
    private let orderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 265/265,
                                                        green: 100/265,
                                                        blue: 71/265,
                                                        alpha: 1))
        view.layer.cornerRadius = 23
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 5)
        view.layer.shadowOpacity = 0.4
        return view
    }()
   
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Text", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.textColor = .white
        label.font = UIFont(name: "Avenir Heavy", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    private func setupTableView(){
        basketTableView.delegate = self
        basketTableView.dataSource = self
        basketTableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.reuseID)
    }
    
    
    func setupBasketUI(){
        
        view.backgroundColor =  UIColor(cgColor: CGColor(red: 251/265,
                                                         green: 237/265,
                                                         blue: 234/265,
                                                         alpha: 1))
        
        view.addSubview(topBorderLineView)
        topBorderLineView.snp.makeConstraints{ make in
            make.height.equalTo(5)
            make.top.equalToSuperview().offset(150)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        
        view.addSubview(basketTableView)
        basketTableView.snp.makeConstraints { make in
            make.top.equalTo(topBorderLineView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        
        view.addSubview(bottomBorderLineView)
        bottomBorderLineView.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.bottom.equalToSuperview().inset(95)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(isEmtyTitleLabel)
        isEmtyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(topBorderLineView.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        view.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-130)
        }
        
        view.addSubview(totalPriceLabel)
        totalPriceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(orderView.snp.centerX)
            make.height.width.equalTo(60)
            make.centerY.equalTo(orderView.snp.centerY)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBasketUI()
        basketTableView.reloadData()
        setupNavBar()
        getTotalPrice()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "load"),object: nil)
    }
    
    
    private func setupNavBar(){
        
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: "Avenir Heavy", size: 33)!]
        
        navigationController?.navigationBar.topItem?.title = "Basket"
        
    }
    
    
    @objc func reloadTable(){
        basketTableView.reloadData()
    }
    
    private func getTotalPrice(){
        
        let array = UsDef.shared.savedProductsArray
        for i in array.indices{
            totPrice += Int(array[i].price)!
        }
    }
}



extension BasketViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if UsDef.shared.savedProductsArray.isEmpty {
            
            isEmtyTitleLabel.alpha = 1
            return 0
        } else{
            
            isEmtyTitleLabel.alpha = 0
            return UsDef.shared.savedProductsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.reuseID, for: indexPath) as? BasketTableViewCell else { fatalError() }
       
        
        if UsDef.shared.savedProductsArray.isEmpty{
            
            cell.textLabel?.text = "  Basket is empty. Nothig was added..."
            cell.textLabel?.textColor = .lightGray
            
        } else {
            let product = UsDef.shared.savedProductsArray[indexPath.row]
            cell.display(item: product)
            cell.deleteProdButton.tag = indexPath.row
            cell.deleteProdButton.addTarget(self, action: #selector(deleteCell(_:)) , for: .touchUpInside)
        }
         return cell
        
        }
    
    @objc func deleteCell(_ sender: UIButton){
        let index = sender.tag
       
            UsDef.shared.savedProductsArray.remove(at:index)
        
            basketTableView.deleteRows(at:[IndexPath(row:index,section:0)],with:.fade)
            basketTableView.reloadData()
            getTotalPrice()
    }

}






