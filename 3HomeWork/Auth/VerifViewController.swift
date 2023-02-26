//
//  VerifViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 26/2/23.
//

import UIKit
import Firebase
import FirebaseAuth
import SnapKit
class VerifViewController: UIViewController {

    private var verifId:String?
    
    private let codeTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Print code"
        field.layer.cornerRadius = 15
        field.font = UIFont(name: "Avenir Heavy", size: 30)
        field.backgroundColor = .white
        field.textAlignment = .center
        field.textColor = .black
        return field
    }()
    
    private let checkCodeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 18)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(checkCode), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        authentificateWithPN()
        codeTextField.delegate = self
        setupVerifUI()
    }
    
    
    private func setupVerifUI(){
        
        view.addSubview(codeTextField)
        codeTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
        view.addSubview(checkCodeButton)
        checkCodeButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(90)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
        }
    }
    
    
    private func authInApp(with credential: PhoneAuthCredential){
        Auth.auth().signIn(with: credential) { authResult, error in
    
            if let error = error {
                print("Error is: \(error.localizedDescription)")
            }else{
                let vc = TabbarViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                print("Authorized: \(authResult?.user)")
            }
        }
    }
    
    
    @objc func checkCode(){
        let vc = TabbarViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        verifyPhoneAuth()
       
    }
    
    
    private func authentificateWithPN(){
    
        guard let number = UsDef.shared.savedUsersArray.first?.number else {return}
    
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.verifId = verificationID
         }
    }
    
    private func verifyPhoneAuth(){
    
        guard let code = codeTextField.text,
                        let vId = verifId else
        {
         return
        }
    
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: vId,
            verificationCode: code
        )
        authInApp(with: credential)
    }

}


extension VerifViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString = (codeTextField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
}
