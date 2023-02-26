//
//  MenuCollectionViewCell.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 10/2/23.
//

import UIKit
import SnapKit
import Kingfisher

class MenuCollectionViewCell: UICollectionViewCell {
        
    static var reuseID = String(describing: MenuCollectionViewCell.self)
        
      private let roundingCorners = RoundCornerImageProcessor(cornerRadius: 210)
        
      private let productImage: UIImageView! = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
            image.layer.cornerRadius = 35
            image.clipsToBounds = true
            return image
        }()
        
    
      private let productNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont(name: "Avenir", size: 13)
            return label
        }()
        
   
      private let productBuyLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = UIColor(cgColor: CGColor(red: 255/265,
                                                              green: 95/265,
                                                              blue: 80/265,
                                                              alpha: 1))
            label.text = "Buy now"
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont(name: "Avenir Heavy", size: 10)
            label.layer.cornerRadius = 10
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowOffset = CGSize(width: 3, height: 5)
            label.layer.shadowOpacity = 0.4
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.init(red: 265/265,
                                                   green: 50/265,
                                                   blue: 50/265,
                                                   alpha: 0.5).cgColor
            label.clipsToBounds = true
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupMenuCellUI()
            self.backgroundColor =
            UIColor(cgColor: CGColor(red: 251/265,
                                     green: 237/265,
                                     blue: 234/265,
                                     alpha: 1))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupMenuCellUI() {
            self.addSubview(productImage)
            productImage.snp.makeConstraints{ make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(13)
                make.width.height.equalTo(140)
            }
            
            self.addSubview(productNameLabel)
            productNameLabel.snp.makeConstraints{ make in
                make.top.equalTo(productImage.snp.bottom)
                make.centerX.equalTo(productImage)
                make.width.equalTo(productImage.snp.width).offset(-5)
                make.height.equalTo(45)
            }
            
            self.addSubview(productBuyLabel)
            productBuyLabel.snp.makeConstraints { make in
                make.top.equalTo(productNameLabel.snp.bottom)
                make.centerX.equalTo(productNameLabel)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }
            
        }
        
    func displayInfo(product: Drinks) {
        productNameLabel.text = product.strDrink
        productImage.kf.setImage(with: URL(string: product.strDrinkThumb), options: [.processor(roundingCorners)])
    }

}
