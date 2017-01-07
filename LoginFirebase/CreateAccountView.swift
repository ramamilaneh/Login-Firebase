//
//  CreateAccountView.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

protocol CreateAccountDelegate: class {
    
    func signUpTapped(with sender: CreateAccountView)
    func cancelTapped(with sender: CreateAccountView)
    
}

class CreateAccountView: UIView {

    @IBOutlet var contentView: UIView!
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var confirmPasswordTextField = UITextField()
    var signUpButton = UIButton()
    var cancelButton = UIButton()
    let textcolor = UIColor(red: 253/255, green: 255/255, blue: 169/255, alpha: 1)
    weak var delegate: CreateAccountDelegate?

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CreateAccountView", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.constrainEdges(to: self)
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPassword()
        setupSignUpButton()
        setupCancelButton()
    }
    
    // MARK: - setup functions
    
    func setupEmailTextField() {
        
        self.contentView.addSubview(emailTextField)
        self.emailTextField.frame = CGRect(x: self.frame.midX*0.1, y: self.frame.midY/3, width: self.frame.width*0.9, height: 50)
        self.emailTextField.setup()
        let color = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: " example@emailprovider.com", attributes: [NSForegroundColorAttributeName: color])
        
    }
    
    func setupPasswordTextField() {
        
        self.contentView.addSubview(passwordTextField)
        let heightOffset = self.frame.midY/3 + self.emailTextField.frame.height + 10
        self.passwordTextField.frame = CGRect(x: self.frame.midX*0.1, y: heightOffset, width: self.frame.width*0.9, height: 50)
        self.passwordTextField.setup()
        let color = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1)
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: " Password", attributes: [NSForegroundColorAttributeName: color])
        
    }
    
    func setupConfirmPassword () {
        
        self.contentView.addSubview(confirmPasswordTextField)
        let heightOffset = self.frame.midY/3 + 120
        self.confirmPasswordTextField.frame = CGRect(x: self.frame.midX*0.1, y: heightOffset, width: self.frame.width*0.9, height: 50)
        self.confirmPasswordTextField.setup()
        let color = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1)
        self.confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: " Confirm Password", attributes: [NSForegroundColorAttributeName: color])
    }
    
    func setupSignUpButton() {
        
        self.contentView.addSubview(signUpButton)
        let x = self.frame.midX - self.frame.width*0.25
        self.signUpButton.frame = CGRect(x: x, y: self.frame.maxY/2, width: self.frame.width*0.5, height: 50)
        self.signUpButton.setTitle("SIGN UP", for: .normal)
        self.signUpButton.setup()
        self.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    func signUp () {
       
        delegate?.signUpTapped(with: self)
        
    }
    
    func setupCancelButton() {
        
        self.contentView.addSubview(cancelButton)
        let x = self.frame.midX - self.frame.width*0.25
        self.cancelButton.frame = CGRect(x: x, y: self.frame.maxY/2 + 80, width: self.frame.width*0.5, height: 50)
        self.cancelButton.setTitle("CANCEL", for: .normal)
        self.cancelButton.setup()
        self.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        }
    
    func cancel() {
        
        delegate?.cancelTapped(with: self)
    }

}


