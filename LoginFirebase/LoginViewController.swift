//
//  LoginViewController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    var loginView: LoginView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.loginView = LoginView(frame: self.view.frame)
        self.view.addSubview(loginView)
        self.loginView.translatesAutoresizingMaskIntoConstraints = false
        self.loginView.constrainEdges(to: self.view)
        self.loginView.emailTextField.delegate = self
        self.loginView.passwordTextField.delegate = self
        self.loginView.delegate = self
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
        print("signIn tapped")
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
            }
}

