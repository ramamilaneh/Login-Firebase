//
//  LoginView.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit


protocol LoginDelegate: class {
    
    func signInButtonTapped(with sender: LoginView)
    func createAccountTapped(with sender: LoginView)
    func forgotPasswordTapped(with sender: LoginView)
}

class LoginView: UIView {
    
    
    @IBOutlet var contentView: UIView!
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signInButton = UIButton()
    var createAccountButton = UIButton()
    var forgotPaswordButton = UIButton()
    let textColor = UIColor(red: 253/255, green: 255/255, blue: 169/255, alpha: 1)
    weak var delegate: LoginDelegate?

    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.constrainEdges(to: self)
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupCreateAccountButton()
        setupForgotPasswordButton()

        
    }
    
    // MARK: - setup functions
    
    func setupEmailTextField() {
        
        self.contentView.addSubview(emailTextField)
        self.emailTextField.frame = CGRect(x: self.frame.midX*0.1, y: self.frame.midY/3, width: self.frame.width*0.9, height: 50)
        self.emailTextField.backgroundColor = UIColor.clear
        self.emailTextField.layer.borderWidth = 1.5
        self.emailTextField.layer.borderColor = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1).cgColor
        self.emailTextField.clipsToBounds = true
        self.emailTextField.layer.cornerRadius = 5
        self.emailTextField.textColor = textColor
        let color = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: " example@emailprovider.com", attributes: [NSForegroundColorAttributeName: color])
        self.emailTextField.setLeftPaddingPoints(25)
       
    }
    
    func setupPasswordTextField() {
        
        self.contentView.addSubview(passwordTextField)
        let heightOffset = self.frame.midY/3 + self.emailTextField.frame.height + 10
        self.passwordTextField.frame = CGRect(x: self.frame.midX*0.1, y: heightOffset, width: self.frame.width*0.9, height: 50)
        self.passwordTextField.backgroundColor = UIColor.clear
        self.passwordTextField.layer.borderWidth = 1.5
        self.passwordTextField.layer.borderColor = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1).cgColor
        self.passwordTextField.clipsToBounds = true
        self.passwordTextField.layer.cornerRadius = 5
        self.passwordTextField.textColor = textColor
        self.passwordTextField.setLeftPaddingPoints(25)
        self.passwordTextField.isSecureTextEntry = true
        let color = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1)
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: " Password", attributes: [NSForegroundColorAttributeName: color])
        
    }
    
    func setupSignInButton() {
        
        self.contentView.addSubview(signInButton)
        let x = self.frame.midX - self.frame.width*0.25
        self.signInButton.frame = CGRect(x: x, y: self.frame.maxY/2 - 70, width: self.frame.width*0.5, height: 50)
        self.signInButton.backgroundColor = UIColor(red: 255/255, green: 161/255, blue: 189/255, alpha: 1)
        self.signInButton.setTitle("SIGN IN", for: .normal)
        self.signInButton.titleLabel?.font = UIFont(name: "Times New Roman Bold", size: 19)
        self.signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        self.signInButton.setTitleColor(textColor, for: .normal)
        self.signInButton.clipsToBounds = true
        self.signInButton.layer.cornerRadius = 27
        self.signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    
    }
    
    func signIn () {
        
        delegate?.signInButtonTapped(with: self)
        
    }
    
    func setupCreateAccountButton() {
        
        self.contentView.addSubview(createAccountButton)
        self.createAccountButton.frame = CGRect(x: 0, y: self.frame.midY + 30, width: self.frame.width*0.43, height: 50)
        self.createAccountButton.backgroundColor = UIColor.clear
        self.createAccountButton.setTitle("Create an account", for: .normal)
        self.createAccountButton.setTitleColor(textColor, for: .normal)
        self.createAccountButton.titleLabel?.font = UIFont(name: "Times New Roman Bold", size: 6)
        self.createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)

    }
    
    func createAccount() {
        
        delegate?.createAccountTapped(with: self)
    }
    
    func setupForgotPasswordButton() {
        
        self.contentView.addSubview(forgotPaswordButton)
        self.forgotPaswordButton.frame = CGRect(x: self.frame.maxX - 180, y: self.frame.midY + 30, width: self.frame.width*0.43, height: 50)
        self.forgotPaswordButton.backgroundColor = UIColor.clear
        self.forgotPaswordButton.setTitle("Forgot my password", for: .normal)
        self.forgotPaswordButton.setTitleColor(textColor, for: .normal)
        self.forgotPaswordButton.titleLabel?.font = UIFont(name: "Times New Roman Bold", size: 6)
        self.forgotPaswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)

    }
    
    func forgotPassword() {
     
        delegate?.forgotPasswordTapped(with: self)
    }
    

}

extension UIView {
    
    func constrainEdges(to view: UIView) {
        
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    

    func insertgradianPinkColor() {
        let firstColor = UIColor(red: 76/255, green: 48/255, blue: 57/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1).cgColor
        let gradian: CAGradientLayer
        gradian = CAGradientLayer()
        gradian.colors = [ firstColor,secondColor,firstColor]
        gradian.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradian.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradian.frame = self.frame
        self.layer.insertSublayer(gradian, at: 0)
        
        
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
  }
}

