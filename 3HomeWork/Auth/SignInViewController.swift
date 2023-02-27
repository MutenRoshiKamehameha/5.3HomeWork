//
//  OpenViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 27/2/23.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {

    private let backImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "3dCocktail")
        image.contentMode = .scaleAspectFill
        image.layer.shadowOffset = .init(width: 1, height: 5)
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.4
        return image
    }()
    
    private let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 45)
        label.text = "Welcome Back"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let logTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 17)
        label.text = "Login to your account"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let passwordTextfield: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Avenir Heavy", size: 16)
        field.textColor = .black
        field.backgroundColor = UIColor(cgColor: CGColor(red: 156/265,
                                                         green: 167/265,
                                                         blue: 225/265,
                                                         alpha: 1))
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.layer.cornerRadius = 10
        field.layer.shadowOffset = .init(width: 1, height: 5)
        field.layer.shadowColor = UIColor.black.cgColor
        field.layer.shadowOpacity = 0.4
        field.clipsToBounds = true
        return field
    }()
    
    private let usernameTextfield: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Avenir Heavy", size: 16)
        field.textColor = .black
        field.backgroundColor = UIColor(cgColor: CGColor(red: 156/265,
                                                         green: 167/265,
                                                         blue: 225/265,
                                                         alpha: 1))
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.layer.cornerRadius = 10
        field.layer.shadowOffset = .init(width: 2, height: 10)
        field.layer.shadowColor = UIColor.black.cgColor
        field.layer.shadowOpacity = 1
        field.clipsToBounds = true
        return field
    }()
    
    private let SignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 18)
        button.backgroundColor = UIColor(cgColor: CGColor(red: 43/265,
                                                          green: 56/265,
                                                          blue: 136/265,
                                                          alpha: 1))
        button.addTarget(self, action: #selector(signInTaped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    private let goToSignUp: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 14)
        button.titleLabel?.attributedText = NSAttributedString(string: "Text", attributes:
                                                        [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.addTarget(self, action: #selector(goSignUpTaped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let haveAnAcc: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont(name: "Avenir Heavy", size: 14)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setUpOpenUI()
    }
    
    private func setUpOpenUI(){
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 100/265,
                                                        green: 90/265,
                                                        blue: 220/265,
                                                        alpha: 1))
        
        view.addSubview(backImage)
        backImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-300)
            make.height.equalTo(backImage.snp.width)
        }
        
        view.addSubview(welcomeTitleLabel)
        welcomeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(50)
        }
        
        view.addSubview(logTitleLabel)
        logTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitleLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(welcomeTitleLabel.snp.width).offset(-100)
            make.height.equalTo(30)
        }
        
        view.addSubview(passwordTextfield)
        passwordTextfield.snp.makeConstraints { make in
            make.top.equalTo(logTitleLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-140)
            make.height.equalTo(50)
        }
        view.addSubview(usernameTextfield)
        usernameTextfield.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfield.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-140)
            make.height.equalTo(passwordTextfield.snp.height)
        }
        
        view.addSubview(haveAnAcc)
        haveAnAcc.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview().offset(-25)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
        view.addSubview(goToSignUp)
        goToSignUp.snp.makeConstraints { make in
            make.top.equalTo(haveAnAcc.snp.top)
            make.centerY.equalTo(haveAnAcc.snp.centerY)
            make.left.equalTo(haveAnAcc.snp.right)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        view.addSubview(SignInButton)
        SignInButton.snp.makeConstraints { make in
            make.bottom.equalTo(goToSignUp.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-140)
            make.height.equalTo(40)
        }
       
    }
    
    @objc func signInTaped(){
        let vc = TabbarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goSignUpTaped(){
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
