//
//  ProfileViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 10/2/23.
//
import Foundation
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private var userArray = [User]()
    
    private let topBorderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 206/265,
                                                        green: 206/265,
                                                        blue: 265/265,
                                                        alpha: 0.85))
        view.layer.cornerRadius = 3
        return view
    }()
    
    
    private var bottomBorderLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 206/265,
                                                        green: 206/265,
                                                        blue: 265/265,
                                                        alpha: 0.85))
        view.layer.cornerRadius = 3
        return view
    }()
    
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.width/2
        image.image = UIImage(systemName: "person.circle.fill")
        image.tintColor = UIColor(cgColor: CGColor(
                                      red: 216/265,
                                    green: 216/265,
                                     blue: 225/265,
                                    alpha: 0.85))
        image.clipsToBounds = true
        return image
    }()
    
    
     var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 26)
        label.numberOfLines = 0
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 7
        label.layer.borderColor = UIColor.clear.cgColor
        return label
    }()
    
    private lazy var  usernameTextField: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .clear
        textfield.font = UIFont(name: "Avenir Next", size: 26)
        textfield.isEnabled = true
        textfield.isHidden = true
        textfield.backgroundColor  = .clear
        return textfield
    }()
    
    private let phoneNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "    Phone number:"
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.backgroundColor = UIColor(cgColor:CGColor(red: 265/265,
                                                      green: 245/265,
                                                       blue: 240/265,
                                                      alpha: 1))
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        return label
    }()
    
    
    private let phoneTextField: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.font = UIFont(name: "Avenir Next", size: 16)
        textfield.backgroundColor = .clear
        textfield.textAlignment = .center
        textfield.isEnabled = true
        textfield.isHidden = true
        return textfield
    }()
    
    
    private let printedNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.backgroundColor = UIColor(cgColor:CGColor(red: 265/265,
                                                      green: 245/265,
                                                       blue: 240/265,
                                                            alpha: 1))
        label.textAlignment = .center
        return label
    }()
        
    
    private let dateOfBirthTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "    Date Of Birth:"
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.backgroundColor = UIColor(cgColor:CGColor(red: 265/265,
                                                      green: 245/265,
                                                       blue: 240/265,
                                                      alpha: 1))
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        return label
    }()
    
    
    private lazy var datePicker: UIDatePicker = {
        let datepick = UIDatePicker()
        datepick.locale = .current
        datepick.maximumDate = .now
        datepick.datePickerMode = .date
        datepick.backgroundColor = .clear
        datepick.layer.cornerRadius = 15
        datepick.clipsToBounds = true
        datepick.isEnabled = false
        return datepick
    }()
    
    
    private let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "    Addres:"
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.backgroundColor = UIColor(cgColor:CGColor(red: 265/265,
                                                      green: 245/265,
                                                       blue: 240/265,
                                                      alpha: 1))
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 6.5
        return label
    }()
    
    
    private let addressTextField: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.font = UIFont(name: "Avenir Next", size: 16)
        textfield.backgroundColor = .clear
        textfield.textAlignment = .center
        textfield.isEnabled = true
        textfield.isHidden = true
        return textfield
    }()
    
    
    private let printedAdressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.backgroundColor = UIColor(cgColor:CGColor(red: 265/265,
                                                      green: 245/265,
                                                       blue: 240/265,
                                                            alpha: 1))
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private let editInfoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(editTaped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileUI()
        setupNavBar()
        setInfoFromReg()
        usernameTextField.delegate = self
    }
    

    
    private func setupProfileUI() {
        
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
        
        view.addSubview(bottomBorderLineView)
        bottomBorderLineView.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.bottom.equalToSuperview().inset(95)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(profileImage)
        profileImage.snp.makeConstraints{ make in
            make.top.equalTo(topBorderLineView.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.width.height.equalTo(188)
        }
        
        view.addSubview(editInfoButton)
        editInfoButton.snp.makeConstraints{ make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.left.equalTo(profileImage.snp.right).offset(-70)
            make.width.height.equalTo(70)
        }
        
        view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(profileImage.snp.centerY)
            make.left.equalTo(profileImage.snp.right).offset(15)
            make.right.equalTo(topBorderLineView.snp.right).offset(-10)
            make.height.equalTo(110)
        }
        
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints{ make in
            make.center.equalTo(usernameLabel.snp.center)
            make.width.equalTo(usernameLabel.snp.width)
            make.height.equalTo(110)
        }
        
        view.addSubview(phoneNumberTitleLabel)
        phoneNumberTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).offset(50)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(45)
        }
        
        view.addSubview(dateOfBirthTitleLabel)
        dateOfBirthTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberTitleLabel.snp.bottom).offset(35)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(45)
        }
        
        view.addSubview(addressTitleLabel)
        addressTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateOfBirthTitleLabel.snp.bottom).offset(35)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(110)
        }
        
        view.addSubview(printedNumberLabel)
        printedNumberLabel.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberTitleLabel.snp.top).offset(2)
            make.bottom.equalTo(phoneNumberTitleLabel.snp.bottom).offset(-2)
            make.right.equalTo(phoneNumberTitleLabel.snp.right).offset(-20)
            make.left.equalTo(phoneNumberTitleLabel.snp.left).offset(145)
        }
        
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints{ make in
            make.top.equalTo(dateOfBirthTitleLabel.snp.top).offset(2)
            make.bottom.equalTo(dateOfBirthTitleLabel.snp.bottom).offset(-2)
            make.right.equalTo(dateOfBirthTitleLabel.snp.right).offset(-40)
            make.left.equalTo(dateOfBirthTitleLabel.snp.left).offset(200)
        }
        
        view.addSubview(printedAdressLabel)
        printedAdressLabel.snp.makeConstraints{ make in
            make.top.equalTo(addressTitleLabel.snp.top).offset(2)
            make.bottom.equalTo(addressTitleLabel.snp.bottom).offset(-20)
            make.right.equalTo(addressTitleLabel.snp.right).offset(-2)
            make.left.equalTo(addressTitleLabel.snp.left).offset(90)
        }
        
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberTitleLabel.snp.top).offset(2)
            make.bottom.equalTo(phoneNumberTitleLabel.snp.bottom).offset(-2)
            make.right.equalTo(phoneNumberTitleLabel.snp.right).offset(-20)
            make.left.equalTo(phoneNumberTitleLabel.snp.left).offset(145)
        }
        
        
        view.addSubview(addressTextField)
        addressTextField.snp.makeConstraints{ make in
            make.top.equalTo(addressTitleLabel.snp.top).offset(2)
            make.bottom.equalTo(addressTitleLabel.snp.bottom).offset(-20)
            make.right.equalTo(addressTitleLabel.snp.right).offset(-2)
            make.left.equalTo(addressTitleLabel.snp.left).offset(90)
        }
        
    }
    
    
    private func setupNavBar(){
        
        navigationController!.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: "Avenir Heavy", size: 33)!]
        
        navigationController!.navigationBar.topItem?.title = "Profile"
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(exitTaped))
    }
    
        @objc func exitTaped(){
            let vc = RegisterViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    
    
    
    @objc func editTaped(){
        
        if  editInfoButton.currentImage == UIImage(systemName: "pencil.circle.fill")!{
            
            editInfoButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
            usernameTextField.isEnabled = true
            phoneTextField.isEnabled = true
            datePicker.isEnabled = true
            addressTextField.isEnabled = true
            
            usernameTextField.isHidden = false
            phoneTextField.isHidden = false
            addressTextField.isHidden = false
            
        }else{
            
            editInfoButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
            
            usernameTextField.isEnabled = true
            phoneTextField.isEnabled = false
            datePicker.isEnabled = false
            addressTextField.isEnabled = false
            
            usernameTextField.isHidden = false
            phoneTextField.isHidden = true
            addressTextField.isHidden = true
            saveInfo()
        }
    }
    
    
    
    
    private func saveInfo(){
        
        if phoneTextField.text?.isNumber == false || phoneTextField.text == "" ||
           phoneTextField.text == " " || phoneTextField.text!.count < 10 {
            
            phoneNumberTitleLabel.layer.borderColor = UIColor.systemRed.cgColor
            editInfoButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
            editTaped()
        }else{
            printedNumberLabel.text = phoneTextField.text
            phoneNumberTitleLabel.layer.borderColor = UIColor.lightGray.cgColor
        }
       
    
        
        
        if addressTextField.text == "" || addressTextField.text == " " {
            
            addressTitleLabel.layer.borderColor = UIColor.systemRed.cgColor
            editInfoButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
            editTaped()
        }else{
            printedAdressLabel.text = addressTextField.text
            addressTitleLabel.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        
        if usernameTextField.text == "" || usernameTextField.text == " " {
           
            usernameLabel.layer.borderColor = UIColor.systemRed.cgColor
            editInfoButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
            editTaped()
        }else{
            usernameLabel.text = usernameTextField.text
            usernameLabel.layer.borderColor = UIColor.clear.cgColor
        }
        
    }
    
    
    private func setInfoFromReg(){
        
        userArray = UsDef.shared.savedUsersArray
        let currentUser = userArray.first
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = dateFormater.date(from: currentUser?.date ?? "\(Date())")
        
      
        printedNumberLabel.text = currentUser?.number
        printedAdressLabel.text = currentUser?.addres
        datePicker.date = date!
        
        
        if currentUser?.username == ""{
            usernameLabel.text = "Anonimus"
        }
    }
    
}




extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}




extension ProfileViewController: UITextFieldDelegate {
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // to be always updated, you cannot use textField.text directly, because after this method gets called, the textField.text will be changed
        let usText = (usernameTextField.text as NSString?)?.replacingCharacters(in: range, with: string)
        usernameLabel.text = (usText)
       
        
        
        return true
    }
}

