//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    let label = UILabel(frame: CGRect(x: 0, y: 140, width: UIScreen.main.bounds.width, height: 100))
    let littleView = UIView(frame: CGRect(x: 0, y: 250, width: UIScreen.main.bounds.width - 32, height: 16 * 4 + 110))
    let usernameField = UITextField(frame: CGRect(x: 16, y: 16, width: UIScreen.main.bounds.width - 64, height: 30))
    let passField = UITextField(frame: CGRect(x: 16, y: 16 * 2 + 30, width: UIScreen.main.bounds.width - 64, height: 30))
    let loginButton = UIButton(frame: CGRect(x: 0, y: 16 * 3 + 2 * 30, width: UIScreen.main.bounds.width/3, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
    
        // TODO: layout your views using frames or AutoLayout

        label.text = "Login View\nController"
        label.center.x = view.center.x
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        littleView.backgroundColor = UIColor.white
        littleView.center = view.center
        littleView.layer.cornerRadius = 8.0
        littleView.clipsToBounds = true
        
        usernameField.placeholder = "berkeley.edu account"
        usernameField.autocapitalizationType = UITextAutocapitalizationType.none
        usernameField.autocorrectionType = UITextAutocorrectionType.no
        usernameField.keyboardType = UIKeyboardType.emailAddress
        
        passField.placeholder = "Password:"
        passField.autocapitalizationType = UITextAutocapitalizationType.none
        passField.autocorrectionType = UITextAutocorrectionType.no

        
        loginButton.setTitle("Login", for: .normal)
        loginButton.center.x = view.center.x
        loginButton.backgroundColor = Constants.backgroundColor
        loginButton.titleLabel?.textColor = UIColor.white
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.layer.cornerRadius = 8.0
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        view.addSubview(label)
        view.addSubview(littleView)
        littleView.addSubview(passField)
        littleView.addSubview(usernameField)
        littleView.addSubview(loginButton)
        
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func login() {
        let username = usernameField.text
        let password = passField.text
        authenticateUser(username: username, password: password)
    }
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
