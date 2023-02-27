//
//  SelectProductViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 17/2/23.
//

import UIKit
import SnapKit
import Kingfisher

class SelectProductViewController: UIViewController{
    
    static let selectID = String(describing: SelectProductViewController.self)
    
    private var concreteReviewsArray = [Review](){
        didSet{
            reviewsCollectionView.reloadData()
        }
    }
    
    private let info: Drinks
    
    init(dish: Drinks) {
        self.info = dish
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  var randomPrice = Int.random(min: 1, max: 10)
    
    private let centerPointOfScreen = UIView()
    
    private lazy var backToMenuButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "Chalkboard SE Regular", size: 50)
        button.titleLabel?.textAlignment = .center
        button.layer.shadowOffset = .init(width: 2, height: 5)
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(backtTaped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var selectedProductNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(info.strDrink)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Heavy", size: 13)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.backgroundColor = .gray
        label.alpha = 0.8
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 21
        label.layer.borderColor = UIColor.white.cgColor
        return label
    }()
    
    
    private lazy var selectedProductImage: UIImageView = {
        let image = UIImageView()
        image.kf.setImage(with: URL(string: info.strDrinkThumb))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    private let ratingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 27
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 5)
        button.layer.shadowOpacity = 0.5
        button.addTarget(self, action: #selector(addReviewTaped), for: .touchUpInside)
        return button
    }()
    
    
    private let ratedPeopleFIrstImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "roma")
        image.backgroundColor = .red
        return image
    }()
    
    
    private let ratedPeopleSecondImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "beka")
        image.backgroundColor = .green
        return image
    }()
    
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.5"
        label.font = UIFont(name: "Avenir Heavy", size: 16)
        return label
    }()
    
    
    private let ratingStarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        image.clipsToBounds = true
        return image
    }()
    
    
    private let descriptView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.backgroundColor = UIColor(cgColor:CGColor(
            red: 265/265,
            green: 245/265,
            blue: 240/265,
            alpha: 1))
        return view
    }()
    
    
    private let descriptLargeLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "Avenir Heavy", size: 25)
        label.numberOfLines = 0
        return label
    }()
    
    
    private let descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 14)
        label.numberOfLines = 0
        label.text = """
My tea's gone cold, I'm wondering why I
Got out of bed at all
The morning rain clouds up my window
And I can't see at all…
"""
        return label
    }()
    
    
    private let reviewsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 170, height: 150)
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 20
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 3, height: 5)
        collectionView.layer.shadowOpacity = 0.4
        return collectionView
    }()
    
    
    private func setupCollectionView() {
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.delegate = self
        reviewsCollectionView.register(ReviewsCollectionViewCell.self,
                                       forCellWithReuseIdentifier: ReviewsCollectionViewCell.reuseID)
    }
    
    private let busketAddingView:UIView = {
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
    
    private let productCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Avenir Heavy", size: 16)
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 15
        return label
    }()
    
    
    private let plusProductButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 22)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(plusOneThing), for: .touchUpInside)
        return button
    }()
    
    
    private let minusProductButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 30)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(minususOneThing), for: .touchUpInside)
        return button
    }()
    
    
    private let addToBusketButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "basket.fill"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 22.5
        button.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.layer.shadowOpacity = 0.4
        return button
    }()
    
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.text = "\(randomPrice)"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let dollarSign: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.text = "$"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    private var commentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.backgroundColor = UIColor(cgColor: CGColor(red: 265/265,
                                                        green: 95/265,
                                                        blue: 80/265,
                                                        alpha: 1))
        
        view.layer.cornerRadius = 20
        view.isHidden = true
        return view
    }()
    
    private var commentTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.text = "Rate and leave comment about cocktail"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private var commentTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "  comment.."
        field.textAlignment = .center
        field.textColor = .black
        field.font = UIFont(name: "Avenir", size: 14)
        field.backgroundColor = .white
        field.layer.cornerRadius = 15
        field.isHidden = true
        return field
    }()
    
    
    private lazy var starsRateSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: segments)
        segment.backgroundColor = UIColor(cgColor: CGColor(red: 255/265,
                                                           green: 95/265,
                                                           blue: 80/265,
                                                           alpha: 1))
        segment.selectedSegmentTintColor = .systemYellow
        segment.selectedSegmentIndex = 0
        segment.isHidden = true
        return segment
    }()
    
    var segments = [UIImage(systemName: "star.fill"), UIImage(systemName: "star.fill"),
                    UIImage(systemName: "star.fill"), UIImage(systemName: "star.fill"),
                    UIImage(systemName: "star.fill"),]
    
    private let okRateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(cgColor: CGColor(red: 206/265,
                                                          green: 206/265,
                                                          blue: 265/265,
                                                          alpha: 0.85))
        button.setTitle("OK", for: .normal)
        button.titleLabel?.textColor = .gray
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        button.addTarget(self, action: #selector(okTaped), for: .touchUpInside)
        button.isHidden = true
        button.layer.cornerRadius = 9
        return button
    }()
    
    private let cancelRateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(cgColor: CGColor(red: 206/265,
                                                          green: 206/265,
                                                          blue: 265/265,
                                                          alpha: 0.85))
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.textColor = .gray
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        button.addTarget(self, action: #selector(cancelTaped), for: .touchUpInside)
        button.isHidden = true
        button.layer.cornerRadius = 9
        return button
    }()
    
    
    private let blurBack: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        view.isHidden = true
        return view
    }()
   
    private let isEmpty: UILabel = {
        let label = UILabel()
        label.text = "There are no comments yet..."
        label.textAlignment = .right
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir", size: 13)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        setupSelectedProductUI()
        setupCollectionView()
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true
        
        checkAreExistReviews()
    }
    
    private func setupSelectedProductUI(){
        
        view.addSubview(centerPointOfScreen)
        centerPointOfScreen.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(1)
        }
        
        view.addSubview(selectedProductImage)
        selectedProductImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(centerPointOfScreen.snp.top).offset(100)
        }
        
        view.addSubview(backToMenuButton)
        backToMenuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(60)
        }
        
        view.addSubview(selectedProductNameLabel)
        selectedProductNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backToMenuButton).offset(10)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(150)
            make.height.equalTo(42)
        }
        
        view.addSubview(descriptView)
        descriptView.snp.makeConstraints { make in
            make.top.equalTo(centerPointOfScreen.snp.top)
            make.bottom.equalToSuperview().offset(30)
            make.width.equalToSuperview()
        }
        
        view.addSubview(ratingButton)
        ratingButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(ratedPeopleSecondImage)
        ratedPeopleSecondImage.snp.makeConstraints { make in
            make.width.height.equalTo(ratingButton.snp.height).offset(-10)
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.left.equalTo(ratingButton.snp.left).offset(40)
        }
        
        view.addSubview(ratedPeopleFIrstImage)
        ratedPeopleFIrstImage.snp.makeConstraints { make in
            make.width.height.equalTo(ratingButton.snp.height).offset(-10)
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.left.equalTo(ratingButton.snp.left).offset(10)
        }
        
        view.addSubview(ratingStarImage)
        ratingStarImage.snp.makeConstraints { make in
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.right.equalTo(ratingButton.snp.right).offset(-10)
        }
        
        view.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.right.equalTo(ratingStarImage.snp.left).offset(-10)
        }
        
        view.addSubview(descriptLargeLabel)
        descriptLargeLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingButton.snp.bottom).offset(55)
            make.left.equalTo(descriptView.snp.left).offset(30)
            make.width.equalTo(ratingButton.snp.width).offset(-20)
        }
        
        view.addSubview(descriptionTextLabel)
        descriptionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptLargeLabel.snp.bottom).offset(20)
            make.width.equalTo(descriptLargeLabel.snp.width)
            make.left.equalTo(descriptView.snp.left).offset(30)
        }
        
        view.addSubview(reviewsCollectionView)
        reviewsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptLargeLabel.snp.top)
            make.left.equalTo(descriptLargeLabel.snp.right).offset(50)
            make.width.height.equalTo(descriptLargeLabel.snp.width)
            make.bottom.equalTo(descriptionTextLabel.snp.bottom)
        }
        
        view.addSubview(reviewsCollectionView)
        reviewsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptLargeLabel.snp.top)
            make.left.equalTo(descriptLargeLabel.snp.right).offset(50)
            make.width.height.equalTo(descriptLargeLabel.snp.width)
            make.bottom.equalTo(descriptionTextLabel.snp.bottom)
        }
        
        view.addSubview(isEmpty)
        isEmpty.snp.makeConstraints { make in
            make.right.equalTo(reviewsCollectionView.snp.right).offset(-15)
            make.left.equalTo(reviewsCollectionView.snp.left).offset(15)
            make.height.equalTo(40)
            make.top.equalTo(reviewsCollectionView.snp.top).offset(40)
           
        }
        
        view.addSubview(busketAddingView)
        busketAddingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-130)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-75)
        }
        
        view.addSubview(productCountLabel)
        productCountLabel.snp.makeConstraints { make in
            make.center.equalTo(busketAddingView.snp.center)
            make.width.equalTo(busketAddingView.snp.width).offset(-200)
            make.height.equalTo(busketAddingView.snp.height).offset(-20)
        }
        
        
        view.addSubview(plusProductButton)
        plusProductButton.snp.makeConstraints { make in
            make.centerY.equalTo(busketAddingView.snp.centerY)
            make.width.height.equalTo(busketAddingView.snp.height).offset(-15)
            make.right.equalTo(productCountLabel.snp.right).offset(-2)
        }
        
        
        view.addSubview(minusProductButton)
        minusProductButton.snp.makeConstraints { make in
            make.centerY.equalTo(busketAddingView.snp.centerY)
            make.width.height.equalTo(busketAddingView.snp.height).offset(-15)
            make.left.equalTo(productCountLabel.snp.left).offset(2)
        }
        
        
        view.addSubview(addToBusketButton)
        addToBusketButton.snp.makeConstraints { make in
            make.centerY.equalTo(busketAddingView.snp.centerY)
            make.width.height.equalTo(busketAddingView.snp.height).offset(-15)
            make.right.equalTo(busketAddingView.snp.right).offset(-15)
        }
        
        
        view.addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(busketAddingView.snp.centerY)
            make.right.equalTo(productCountLabel.snp.left).offset(-18)
            make.left.equalTo(busketAddingView.snp.left).offset(12)
        }
        
        view.addSubview(dollarSign)
        dollarSign.snp.makeConstraints { make in
            make.centerY.equalTo(busketAddingView.snp.centerY)
            make.left.equalTo(productPriceLabel.snp.right).inset(13)
            make.width.equalTo(10.5)
            make.height.equalTo(15)
        }
        
        view.addSubview(blurBack)
        blurBack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(commentView)
        commentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.right.equalToSuperview().inset(50)
            make.left.equalToSuperview().offset(50)
            make.height.equalTo(260)
        }
        
        view.addSubview(commentTitle)
        commentTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.right.equalTo(commentView.snp.right).inset(50)
            make.left.equalTo(commentView.snp.left).offset(50)
            make.top.equalTo(commentView.snp.top).inset(15)
            make.height.equalTo(50)
            
        }
        
        view.addSubview(commentTextField)
        commentTextField.snp.makeConstraints { make in
            make.centerX.equalTo(commentView.snp.centerX)
            make.top.equalTo(commentTitle.snp.bottom).offset(5)
            make.right.equalTo(commentView.snp.right).inset(30)
            make.left.equalTo(commentView.snp.left).offset(30)
            make.height.equalTo(60)
        }
        
        view.addSubview(starsRateSegment)
        starsRateSegment.snp.makeConstraints { make in
            make.centerX.equalTo(commentView.snp.centerX)
            make.top.equalTo(commentTextField.snp.bottom).offset(10)
            make.right.equalTo(commentView.snp.right).inset(40)
            make.left.equalTo(commentView.snp.left).offset(40)
            make.height.equalTo(40)
        }
        
        view.addSubview(cancelRateButton)
        cancelRateButton.snp.makeConstraints { make in
            make.top.equalTo(starsRateSegment.snp.bottom).offset(10)
            make.right.equalTo(commentView.snp.right).inset(40)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        view.addSubview(okRateButton)
        okRateButton.snp.makeConstraints { make in
            make.top.equalTo(starsRateSegment.snp.bottom).offset(10)
            make.left.equalTo(commentView.snp.left).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
       
    }
    
    
    @objc func backtTaped(){
        let vc = MenuViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func plusOneThing(){
        guard productCountLabel.text != "10" else{return}
        let price = productPriceLabel.text
        productPriceLabel.text = String(Int(price!)! + (Int(price!)! / Int(productCountLabel.text!)!))
        productCountLabel.text = String(Int(productCountLabel.text!)! + 1)
    }
    
    
    @objc func minususOneThing(){
        guard productCountLabel.text != "1" else{return}
        let price = productPriceLabel.text

        productPriceLabel.text = String(Int(price!)! - (Int(price!)! / Int(productCountLabel.text!)!))
        productCountLabel.text = String(Int(productCountLabel.text!)! - 1)
    }
    
    
    @objc func addToBasket(){
        
        if addToBusketButton.tintColor == .white{
            
            addToBusketButton.tintColor = .black
            addToBusketButton.backgroundColor = .white
            
            UsDef.shared.savedProductsArray.removeFirst()
            
        }else{
            addToBusketButton.tintColor = .white
            addToBusketButton.backgroundColor = .black
            
            UsDef.shared.saveProducts(name: info.strDrink ,
                                      image: info.strDrinkThumb,
                                      count: productCountLabel.text!,
                                      price: productPriceLabel.text!,
                                      rate: ratingLabel.text!)
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        
    }
    
    
    @objc func addReviewTaped(){
        showAlert()
    }
    
    @objc func okTaped(){
    
        if commentTextField.text != "" || commentTextField.text != " " {
            UsDef.shared.saveReviews(username: SignUpViewController.shared.userNameTextField.text ?? "Anonimus",
                                     prodName: selectedProductNameLabel.text!,
                                     comment: commentTextField.text!,
                                     rate: "\(starsRateSegment.selectedSegmentIndex + 1)",
                                     date: "\(Date())")
            
          concreteReviewsArray.removeAll()
          checkAreExistReviews()
          hideAlert()
        }else{
     }
 }
    
    @objc func cancelTaped(){
        hideAlert()
        starsRateSegment.selectedSegmentIndex = 0
        print(UsDef.shared.savedReviewsArray)
    }
    
    private func checkAreExistReviews(){
        
        for i in UsDef.shared.savedReviewsArray.indices{
            
            if selectedProductNameLabel.text == UsDef.shared.savedReviewsArray[i].prodName{
                concreteReviewsArray.append(UsDef.shared.savedReviewsArray[i])
                
            }
        }
    }
    
    
    private func showAlert(){
        commentTextField.text = ""
        commentView.isHidden = false
        commentTitle.isHidden = false
        commentTextField.isHidden = false
        starsRateSegment.isHidden = false
        okRateButton.isHidden = false
        cancelRateButton.isHidden = false
        blurBack.isHidden = false
    }
    
    private func hideAlert(){
        commentView.isHidden = true
        commentTitle.isHidden = true
        commentTextField.isHidden = true
        starsRateSegment.isHidden = true
        okRateButton.isHidden = true
        cancelRateButton.isHidden = true
        blurBack.isHidden = true
    }
    
}

extension SelectProductViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return concreteReviewsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCollectionViewCell.reuseID, for: indexPath) as? ReviewsCollectionViewCell else { fatalError() }
        
        
        if concreteReviewsArray.isEmpty{
            isEmpty.isHidden = false
            return cell
        } else {
            isEmpty.isHidden = true
            let product = concreteReviewsArray[indexPath.row]
            cell.displayInfo(product: product)
        }
        return cell
    }
}





public extension Int {

    /// Returns a random Int point number between 0 and Int.max.
    static var random: Int {
        return Int.random(n: Int.max)
    }

    /// Random integer between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random Int point number between 0 and n max
    static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }

    ///  Random integer between min and max
    ///
    /// - Parameters:
    ///   - min:    Interval minimun
    ///   - max:    Interval max
    /// - Returns:  Returns a random Int point number between 0 and n max
    static func random(min: Int, max: Int) -> Int {
        return Int.random(n: max - min + 1) + min

    }
}
