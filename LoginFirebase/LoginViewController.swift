//
//  LoginViewController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    var loginView: LoginView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupLoginView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.loginView.contentView.insertgradianPinkColor()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupLoginView() {
        
        self.loginView = LoginView(frame: self.view.frame)
        self.view.addSubview(loginView)
        self.loginView.translatesAutoresizingMaskIntoConstraints = false
        self.loginView.constrainEdges(to: self.view)
        self.loginView.emailTextField.delegate = self
        self.loginView.passwordTextField.delegate = self
        self.loginView.delegate = self
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.loginView.emailTextField {
            self.loginView.emailTextField.becomeFirstResponder()
        }
        if textField == self.loginView.passwordTextField {
            self.loginView.passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension LoginViewController: LoginDelegate {
    
    func signInButtonTapped(with sender: LoginView) {
        
        if let email = self.loginView.emailTextField.text, let password = self.loginView.passwordTextField.text {
            
            FirebaseManager.signIn(with: email, and: password, completion: { (success) in
                if !success{
                    
                    let alertController = UIAlertController(title: "Error", message: "Email or Password is incorrect", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(action)
                    
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        
                        NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                    }
                    
                }
            })
        }
    }
    
    func createAccountTapped(with sender: LoginView) {
        
        print("create account tapped")
        let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "create-account-view-controller") as! AccountViewController
        destVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        destVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(destVC, animated: true, completion: nil)
        
    }
    
    func forgotPasswordTapped(with sender: LoginView) {
        
        print("forgotPassword tapped")
        let alertController = UIAlertController(title: "Forgot My Password", message: "Enter your email address so we can send you info on how to reset your password.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let sendAction = UIAlertAction(title: "Send", style: .default) { (action) in
            let emailField = alertController.textFields![0]
            if let email = emailField.text {
                
                FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
                    if let error = error {
                        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        UserNotification.show("Password reset e-mail sent")
                    }
                })
            }
        }
        
        alertController.addAction(sendAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter E-mail address"
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}

