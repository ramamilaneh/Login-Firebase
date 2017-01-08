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
    func googleSignInButtonTapped(with sender: LoginView)
    func facebookSignInButtonTapped(with sender: LoginView)
    func twitterSignInButtonTapped(with sender: LoginView)


    
}

class LoginView: UIView {
    
    
    @IBOutlet var contentView: UIView!
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var orLabel = UILabel()
    var signInButton = UIButton()
    var createAccountButton = UIButton()
    var forgotPaswordButton = UIButton()
    var googleSignIn = UIButton()
    var facebookSignIn = UIButton()
    var twitterSignIn = UIButton()
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
        self.contentView.addSubview(orLabel)
        self.orLabel.text = "OR SIGN IN WITH"
        self.orLabel.font = UIFont(name: "Times New Roman Bold", size: 4)
        let x = self.frame.midX - 60
        self.orLabel.frame = CGRect(x: x, y: self.frame.maxY*0.65, width: 150, height: 50)
        self.orLabel.backgroundColor = UIColor.clear
        self.orLabel.textColor = self.textColor
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupCreateAccountButton()
        setupForgotPasswordButton()
        setupGoogleSignInButton()
        setupFacebookSignInButton()
        setupTwitterSignInButton()

        
    }
    
    // MARK: - setup functions
    
    func setupEmailTextField() {
        
        self.contentView.addSubview(emailTextField)
        self.emailTextField.frame = CGRect(x: self.frame.midX*0.1, y: self.frame.maxY*0.15, width: self.frame.width*0.9, height: 50)
        self.emailTextField.setup()
        let color = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: " example@emailprovider.com", attributes: [NSForegroundColorAttributeName: color])
       
    }
    
    func setupPasswordTextField() {
        
        self.contentView.addSubview(passwordTextField)
        let heightOffset = self.frame.maxY*0.15 + self.emailTextField.frame.height + 10
        self.passwordTextField.frame = CGRect(x: self.frame.midX*0.1, y: heightOffset, width: self.frame.width*0.9, height: 50)
        self.passwordTextField.setup()
        let color = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1)
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: " Password", attributes: [NSForegroundColorAttributeName: color])
        
    }
    
    func setupSignInButton() {
        
        self.contentView.addSubview(signInButton)
        let x = self.frame.midX - self.frame.width*0.25
        self.signInButton.frame = CGRect(x: x, y: self.frame.maxY*0.4, width: self.frame.width*0.5, height: 50)
        self.signInButton.setTitle("SIGN IN", for: .normal)
        self.signInButton.setup()
        self.signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    
    }
    
    func signIn () {
        
        delegate?.signInButtonTapped(with: self)
        
    }
    
    func setupCreateAccountButton() {
        
        self.contentView.addSubview(createAccountButton)
        self.createAccountButton.frame = CGRect(x: 10, y: self.frame.midY + 30, width: self.frame.width*0.43, height: 50)
        self.createAccountButton.backgroundColor = UIColor.clear
        self.createAccountButton.setTitle("Create an account", for: .normal)
        self.createAccountButton.setTitleColor(textColor, for: .normal)
        self.createAccountButton.titleLabel?.font = UIFont(name: "Times New Roman Bold", size: 6)
        self.createAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)

    }
    
    func createAccount() {
        
        delegate?.createAccountTapped(with: self)
    }
    
    func setupForgotPasswordButton() {
        
        self.contentView.addSubview(forgotPaswordButton)
        self.forgotPaswordButton.frame = CGRect(x: self.createAccountButton.frame.width + 30, y: self.frame.midY + 30, width: self.frame.width*0.43, height: 50)
        self.forgotPaswordButton.backgroundColor = UIColor.clear
        self.forgotPaswordButton.setTitle("Forgot my password", for: .normal)
        self.forgotPaswordButton.setTitleColor(textColor, for: .normal)
        self.forgotPaswordButton.titleLabel?.font = UIFont(name: "Times New Roman Bold", size: 6)
        self.forgotPaswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.forgotPaswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)

    }
    
    func forgotPassword() {
     
        delegate?.forgotPasswordTapped(with: self)
    }
    
    func setupGoogleSignInButton() {
        
        self.contentView.addSubview(googleSignIn)
        self.googleSignIn.frame = CGRect(x: self.frame.maxX/2 - 25, y: self.frame.maxY*0.75, width: 50, height: 50)
        self.googleSignIn.backgroundColor = UIColor.clear
        self.googleSignIn.layer.cornerRadius = 0.5 * self.googleSignIn.bounds.size.width
        self.googleSignIn.clipsToBounds = true
        self.googleSignIn.setImage(UIImage(named:"google.png"), for: .normal)
        self.googleSignIn.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
    }
    
    func signInWithGoogle() {
        
        delegate?.googleSignInButtonTapped(with: self)
    }
    
    func setupFacebookSignInButton() {
        
        self.contentView.addSubview(facebookSignIn)
        self.facebookSignIn.frame = CGRect(x: self.frame.maxX/2 - 125, y: self.frame.maxY*0.75, width: 50, height: 50)
        self.facebookSignIn.backgroundColor = UIColor.clear
        self.facebookSignIn.layer.cornerRadius = 0.5 * self.facebookSignIn.bounds.size.width
        self.facebookSignIn.clipsToBounds = true
        self.facebookSignIn.setImage(UIImage(named:"facebook.png"), for: .normal)
        self.facebookSignIn.addTarget(self, action: #selector(signInWithFacebook), for: .touchUpInside)
    }
    
    func signInWithFacebook() {
        
        delegate?.facebookSignInButtonTapped(with: self)
    }

    func setupTwitterSignInButton() {
        
        self.contentView.addSubview(twitterSignIn)
        self.twitterSignIn.frame = CGRect(x: self.frame.maxX/2 + 75, y: self.frame.maxY*0.75, width: 50, height: 50)
        self.twitterSignIn.backgroundColor = UIColor.clear
         self.twitterSignIn.layer.cornerRadius = 0.5 * self.twitterSignIn.bounds.size.width
        self.twitterSignIn.clipsToBounds = true
        self.twitterSignIn.setImage(UIImage(named:"twitter.png"), for: .normal)
        self.twitterSignIn.addTarget(self, action: #selector(signInWithTwitter), for: .touchUpInside)
    }
    
    func signInWithTwitter() {
        
        delegate?.twitterSignInButtonTapped(with: self)
    }

    

}




