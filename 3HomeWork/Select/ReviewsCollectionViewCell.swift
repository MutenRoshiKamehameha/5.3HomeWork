//
//  ReviewsCollectionViewCell.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 17/2/23.
//

import UIKit
import SnapKit
import Kingfisher

class ReviewsCollectionViewCell: UICollectionViewCell {

    static var reuseID = String(describing: ReviewsCollectionViewCell.self)
    
    private var rateValue = ""
    
        private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir Heavy", size: 10)
        label.textColor = .black
        return label
    }()

    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir",size: 12)
        label.textColor = .gray
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold",size: 8)
        label.textColor = .gray
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    
    private let starImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        image.clipsToBounds = true
        return image
    }()
    
    private let starImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()

    private let starImage3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()

    private let starImage4: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()
    
    private let starImage5: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()

    
    private let borderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupReviewcCellUI()
        self.backgroundColor = .white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
            private func setupReviewcCellUI(){
                
                self.addSubview(borderLineView)
                borderLineView.snp.makeConstraints{ make in
                    make.top.equalToSuperview().offset(23)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview().offset(-32)
                    make.height.equalTo(2.3)
                }

                self.addSubview(starImage1)
                starImage1.snp.makeConstraints{ make in
                    make.top.equalTo(borderLineView.snp.bottom).offset(6)
                    make.right.equalToSuperview().offset(-20)
                    make.height.width.equalTo(12)
                }
                self.addSubview(starImage2)
                starImage2.snp.makeConstraints{ make in
                    make.top.equalTo(starImage1.snp.top)
                    make.right.equalTo(starImage1.snp.left).offset(-3)
                    make.height.equalTo(starImage1.snp.height)
                    make.width.equalTo(starImage1.snp.width)
                }
                self.addSubview(starImage3)
                starImage3.snp.makeConstraints{ make in
                    make.top.equalTo(starImage1.snp.top)
                    make.right.equalTo(starImage2.snp.left).offset(-3)
                    make.height.equalTo(starImage1.snp.height)
                    make.width.equalTo(starImage1.snp.width)
                }
                
                self.addSubview(starImage4)
                starImage4.snp.makeConstraints{ make in
                    make.top.equalTo(starImage1.snp.top)
                    make.right.equalTo(starImage3.snp.left).offset(-3)
                    make.height.equalTo(starImage1.snp.height)
                    make.width.equalTo(starImage1.snp.width)
                }
                self.addSubview(starImage5)
                starImage5.snp.makeConstraints{ make in
                    make.top.equalTo(starImage1.snp.top)
                    make.right.equalTo(starImage4.snp.left).offset(-3)
                    make.height.equalTo(starImage1.snp.height)
                    make.width.equalTo(starImage1.snp.width)
                }
                
                
                
                self.addSubview(nameLabel)
                nameLabel.snp.makeConstraints{ make in
                    make.top.equalTo(starImage1.snp.bottom).offset(5)
                    make.right.equalToSuperview().offset(-20)
                    make.height.equalTo(10)
                }

                self.addSubview(commentLabel)
                commentLabel.snp.makeConstraints { make in
                    make.top.equalTo(nameLabel.snp.bottom).offset(5)
                    make.width.equalToSuperview().offset(-40)
                    make.right.equalToSuperview().offset(-20)
                    make.height.equalTo(40)
                }
                
                self.addSubview(dateLabel)
                dateLabel.snp.makeConstraints { make in
                    make.bottom.equalToSuperview().offset(-20)
                    make.width.equalToSuperview().offset(-40)
                    make.right.equalToSuperview().offset(-20)
                }
                
        }

    
   func displayInfo(product:Review) {
    
    nameLabel.text = product.username
    commentLabel.text = product.comment
    dateLabel.text = product.date
    
       setStars(rate:  "\(product.rate)")
   }
    
    
    private func setStars(rate:String){
        switch rate{
        case "2":
            starImage2.isHidden = false
        case "3":
            starImage2.isHidden = false
            starImage3.isHidden = false
        case "4":
            starImage2.isHidden = false
            starImage3.isHidden = false
            starImage4.isHidden = false
           
        case "5":
            starImage2.isHidden = false
            starImage3.isHidden = false
            starImage4.isHidden = false
            starImage5.isHidden = false
        default:
            return
        }
    }
    
    
}


    


