//
//  LoginViewController.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 06/03/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var emailArray = [String]()
    var passwordArray = [String]()
    var roleArray = [Bool]()
    
    let appText: UILabel = {
        let t = UILabel()
        t.text = "Adminify"
        t.font = .systemFont(ofSize: 28)
        return t
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        textField.layer.borderWidth = 1
        textField.placeholder = "Email"
        textField.setLeftPaddingPoints(10)
        textField.setAnchor(width: 0, height: 50)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.placeholder = "Password"
        textField.setLeftPaddingPoints(10)
        textField.setAnchor(width: 0, height: 50)
        return textField
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.setAnchor(width: 0, height: 50)
        return button
    }()
    
    let signupButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.setAnchor(width: 0, height: 50)
        return button
    }()
    
    @objc func handleLogin() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
               let context = appdelegate.persistentContainer.viewContext
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
               fetchRequest.returnsObjectsAsFaults = false
               
               do{
                   let results = try context.fetch(fetchRequest)
                   
                   for result in results as! [NSManagedObject]{
                       if let email = result.value(forKey: "email") as? String{
                           self.emailArray.append(email)
                       }
                       if let password = result.value(forKey: "password") as? String{
                           self.passwordArray.append(password)
                       }
                       
                       if let role = result.value(forKey: "role") as? Bool{
                           self.roleArray.append(role)
                       }
                       
                   }
               }
               catch{
                   print("error")
               }
               
               if (emailArray.contains(emailTextField.text!)){
                   let emailIndex = emailArray.firstIndex(where: {$0 == emailTextField.text})
                   
                   if passwordArray[emailIndex!] == passwordTextField.text{
                       
                       if (roleArray[emailIndex!] == true) {
                           let vc = MainAdminViewController()
                           navigationController?.pushViewController(vc, animated: true)
                       }else {
                           
                           let vc = MainViewController()
                           navigationController?.pushViewController(vc, animated: true)
                       }
                   }
               }
               else{
                   let alert = UIAlertController(title: "Not Found", message: "No account found for this e-mail address", preferredStyle: .alert)
                
                   let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                           UIAlertAction in
                       }
                   alert.addAction(okAction)

                   self.present(alert, animated: true, completion: nil)
               }
    }
    
    @objc func handleSignup() {
        let vc = SignupViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                       passwordTextField,
                                                       loginButton,
                                                       signupButton
                                                      ])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    func setup() {
        let stackView = mainStackView()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(stackView)
        stackView.setAnchor(width: self.view.frame.width - 60, height: 230)
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Log In"

 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setup()
        
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
    }
}

