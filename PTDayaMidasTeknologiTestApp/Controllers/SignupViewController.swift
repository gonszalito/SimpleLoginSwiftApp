//
//  LoginViewController.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 06/03/23.
//

import UIKit
import CoreData

class SignupViewController: UIViewController {
    
    var radioButtons = [UIButton]()
    var emailArray = [String]()
    
    let adminButton : UIButton = {
        let button = UIButton()
        button.setTitle("Admin", for: .normal)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        // if the selected button cannot be reclick again, you can use .Disabled state
        button.setImage(UIImage(systemName: "circle.fill")!, for: .selected)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.setAnchor(width: 0, height: 50)
        return button
    }()
    
    let userButton : UIButton = {
        let button = UIButton()
        button.setTitle("User", for: .normal)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        // if the selected button cannot be reclick again, you can use .Disabled state
        button.setImage(UIImage(systemName: "circle.fill")!, for: .selected)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.setAnchor(width: 0, height: 50)
        return button
    }()

    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        textField.layer.borderWidth = 1
        textField.placeholder = "Username"
        textField.setLeftPaddingPoints(10)
        textField.setAnchor(width: 0, height: 50)
        return textField
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
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .red
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
    
    @objc func buttonAction(sender: UIButton!){
        for button in radioButtons {
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @objc func handleCancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignup() {
        if(!emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !usernameTextField.text!.isEmpty && (adminButton.isSelected || userButton.isSelected) ){
            
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
                    
                }
            }
            catch{
                print("error")
            }
            
      
            let newUser = User(id: emailArray.count + 1 , username: usernameTextField.text ?? "", email: emailTextField.text ?? "" , role: adminButton.isSelected ,password: passwordTextField.text ?? "" )
            
            DataPersistenceManager.shared.saveUserWith(model: newUser) { result in
                switch result {
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("saved"), object: nil)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let alert = UIAlertController(title: "Empty Field", message: "All Fields Must Be Field", preferredStyle: .alert)
         
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
            alert.addAction(okAction)

            self.present(alert, animated: true, completion: nil)
        }
      
        
  
    }
    
    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField,
                                                       emailTextField,
                                                       passwordTextField,
                                                       adminButton,
                                                       userButton,
                                                       signupButton,
                                                       cancelButton
                                                      ])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    
    func setup() {
        radioButtons.append(adminButton)
        radioButtons.append(userButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
        let stackView = mainStackView()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(stackView)
        stackView.setAnchor(width: self.view.frame.width - 60, height: 410)
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Sign Up"

 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setup()
        
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
    }
}
