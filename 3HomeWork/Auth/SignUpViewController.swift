//
//  AuthViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 25/2/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    static let shared = SignUpViewController()
    
     let userNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Print username"
        field.layer.cornerRadius = 15
        field.font = UIFont(name: "Avenir", size: 17)
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
    
    private let numberTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Print number"
        field.layer.cornerRadius = 15
        field.font = UIFont(name: "Avenir", size: 17)
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
    
    private let datePicker: UIDatePicker = {
        let datepick = UIDatePicker()
        datepick.maximumDate = .now
        datepick.locale = .current
        datepick.datePickerMode = .date
        datepick.backgroundColor = .white
        datepick.layer.cornerRadius = 15
        datepick.clipsToBounds = true
        return datepick
    }()
    
    private let addressTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Print address"
        field.layer.cornerRadius = 15
        field.font = UIFont(name: "Avenir", size: 17)
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
   
    private let getCodeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 13)
        button.backgroundColor = .systemRed
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(getCode), for: .touchUpInside)
        return button
    }()
    
   
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setupAuthUI()
          view.backgroundColor = .black
        
        
       
      }
    
    
    private func setupAuthUI(){
        
        view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(220)
            make.width.equalToSuperview().offset(-90)
            make.height.equalTo(40)
        }
        
        view.addSubview(addressTextField)
        addressTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameTextField.snp.bottom).offset(30)
            make.width.equalTo(userNameTextField.snp.width)
            make.height.equalTo(40)
        }
        
        view.addSubview(numberTextField)
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(30)
            make.left.equalTo(addressTextField.snp.left)
            make.width.equalTo(157)
            make.height.equalTo(40)
        }
        
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(30)
            make.right.equalTo(addressTextField.snp.right)
            make.width.equalTo(numberTextField.snp.width)
            make.height.equalTo(40)
        }
        
        
        view.addSubview(getCodeButton)
        getCodeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(datePicker.snp.bottom).offset(30)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
    }
   
  
    
   @objc func getCode(){
     let vc = VerifViewController()
     navigationController?.pushViewController(vc, animated: true)
       saveInfo()
   }
   
    
   

    private func saveInfo() {
        
        UsDef.shared.saveUser(username: userNameTextField.text ?? "Username",
                               number: numberTextField.text ?? "+996999999",
                               date: "\(datePicker.date)",
                               addres: addressTextField.text ?? "Bishkek")
        
        print( UsDef.shared.savedUsersArray)
    }
    
  
}
   
