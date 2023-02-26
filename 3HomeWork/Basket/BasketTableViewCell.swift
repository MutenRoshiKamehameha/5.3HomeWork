//
//  BasketTableViewCell.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 20/2/23.
//

import UIKit
import SnapKit
import Kingfisher

class BasketTableViewCell: UITableViewCell {
    
   static var reuseID = String(describing: BasketTableViewCell.self)
    
   private let roundingCorners = RoundCornerImageProcessor(cornerRadius: 100)
    
   private var tableProdNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
     
    
    private var tableProdImage: UIImageView = {
        let image =  UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
     }()
    
   
    private var tableProdPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 15)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
     }()
    
    
    private var tableProdCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 13)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
     }()
    
    private var rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
     }()
    
    private var rateStar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        return image
     }()
    
     var deleteProdButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = .systemRed
        return button
     }()
    
    override func awakeFromNib() {
           super.awakeFromNib()
       
        
       }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: false)
           setupTableViewCellUI()
           
       }

   
    func setupTableViewCellUI(){
        
        self.backgroundColor =  UIColor(cgColor: CGColor(red: 251/265,
                                                         green: 237/265,
                                                         blue: 234/265,
                                                         alpha: 1))
        
        self.addSubview(tableProdImage)
        tableProdImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().offset(-18)
            make.width.equalTo(tableProdImage.snp.height)
            make.right.equalToSuperview().offset(-30)
        }
        
        self.addSubview(tableProdNameLabel)
        tableProdNameLabel.snp.makeConstraints { make in
            make.top.equalTo(tableProdImage.snp.top).offset(15)
            make.right.equalTo(tableProdImage.snp.left).offset(-15)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(30)
        }
        
        self.addSubview(tableProdPriceLabel)
        tableProdPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(tableProdNameLabel.snp.bottom).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(tableProdNameLabel.snp.width)
            make.left.equalToSuperview().offset(30)
        }

        self.addSubview(tableProdCountLabel)
        tableProdCountLabel.snp.makeConstraints { make in
            make.top.equalTo(tableProdPriceLabel.snp.bottom).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(tableProdNameLabel.snp.width)
            make.left.equalToSuperview().offset(30)
        }
        
        self.addSubview(rateStar)
        rateStar.snp.makeConstraints { make in
            make.bottom.equalTo(tableProdCountLabel.snp.bottom).offset(-5)
            make.right.equalTo(tableProdNameLabel.snp.right)
            make.width.height.equalTo(20)
        }
        
        self.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(rateStar.snp.bottom)
            make.right.equalTo(rateStar.snp.left).offset(-3)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        
        self.addSubview(deleteProdButton)
        rateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(rateStar.snp.bottom)
            make.right.equalTo(rateLabel.snp.left).offset(-8)
            make.height.width.equalTo(30)
        }
    }
    
   
 
    func display(item:Product) {
        tableProdNameLabel.text = item.name
        tableProdImage.kf.setImage(with: URL(string: item.image), options: [.processor(roundingCorners)])
        tableProdPriceLabel.text = "Price: " + item.price
        tableProdCountLabel.text = "Portions: " + item.count
        rateLabel.text = item.rate
    }
}
