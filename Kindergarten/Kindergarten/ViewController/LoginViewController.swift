//
//  LoginViewController.swift
//  Kindergarten
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationItem.title = "KOUNTDOWN2K"
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.textContentType = UITextContentType.oneTimeCode
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Action methods
    
    @IBAction func onSigninButtonClick(_ sender: Any) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        guard let username = self.usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            AlertView().showAlertView(controller: self, title: "", message: "Please enter username and password")
            return
        }
        guard let password = self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            AlertView().showAlertView(controller: self, title: "", message: "Please enter username and password")
            return
        }
        if username.count > 0 && password.count > 0 {
            guard let userResponseModel: UserResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .UserJson_English) else {
                AlertView().showAlertView(controller: self, title: "", message: "Error while signin")
                return
            }
            let userModel = userResponseModel.users?.filter({ (user) in
                if user.username == username {
                    return true
                }
                return false
            }).first
            if userModel?.password == password {
                LocalStorageManager.shared.selectedUsername = username
                self.performSegue(withIdentifier: Constants.kSegueKey.eShowHome.rawValue, sender: nil)
            } else {
                AlertView().showAlertView(controller: self, title: "", message: "SignIn Failed!")
            }
        } else {
            AlertView().showAlertView(controller: self, title: "", message: "Please enter username and password")
        }
    }
    
    @IBAction func onSignupButtonClick(_ sender: Any) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.performSegue(withIdentifier: Constants.kSegueKey.eShowSignup.rawValue, sender: nil)
    }
    
    // MARK: - Keyboard notification
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
