//
//  SignupViewController.swift
//  Kindergarten
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.fullNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
        self.confirmPasswordTextField.isSecureTextEntry = true
        self.passwordTextField.textContentType = UITextContentType.oneTimeCode
        self.confirmPasswordTextField.textContentType = UITextContentType.oneTimeCode
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
    
    @IBAction func onCreateAccountButtonClick(_ sender: Any) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.confirmPasswordTextField.resignFirstResponder()
        self.fullNameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        guard let username = self.usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            AlertView().showAlertView(controller: self, title: "", message: "All are mandatory fields")
            return
        }
        guard let password = self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            AlertView().showAlertView(controller: self, title: "", message: "All are mandatory fields")
            return
        }
        guard let confirmPassword = self.confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            AlertView().showAlertView(controller: self, title: "", message: "All are mandatory fields")
            return
        }
        guard let fullName = self.fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            AlertView().showAlertView(controller: self, title: "", message: "All are mandatory fields")
            return
        }
        guard let email = self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            AlertView().showAlertView(controller: self, title: "", message: "All are mandatory fields")
            return
        }
        
        if username.count > 0 && password.count > 0 && confirmPassword.count > 0 && fullName.count > 0 && email.count > 0 {
            if self.isUsernameAlreadyExist(username: username) == true {
                AlertView().showAlertView(controller: self, title: "", message: "Username already exist")
            } else if password.count < 5 {
                AlertView().showAlertView(controller: self, title: "", message: "Password must have at least 5 characaters")
            } else if password != confirmPassword {
                AlertView().showAlertView(controller: self, title: "", message: "New Password and Confirm Password should match")
            } else if self.isValidEmail(email: email) == false {
                AlertView().showAlertView(controller: self, title: "", message: "Entered email is not in correct format")
            } else {
                var userModel = UserModel()
                userModel.username = username
                userModel.password = password
                userModel.fullName = fullName
                userModel.email = email
                var uploadUserResponseModel = UserResponseModel()
                if let userResponseModel: UserResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .UserJson_English) {
                    var usersArray = userResponseModel.users
                    usersArray?.append(userModel)
                    uploadUserResponseModel.users = usersArray
                } else {
                    uploadUserResponseModel.users = [userModel]
                }
                LocalStorageManager.shared.saveToLocalStorage(fileName: .UserJson_English, responseObject: uploadUserResponseModel)
                AlertView().showAlertView(controller: self, title: "", message: "Account Created. Enter your credentials in Login screen", okButtonTitle: "Ok", handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
            }
            
        } else {
            AlertView().showAlertView(controller: self, title: "", message: "All are mandatory fields")
        }
    }
    
    // MARK: - Other
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]{2,64}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    private func isUsernameAlreadyExist(username: String) -> Bool {
        guard let userResponseModel: UserResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .UserJson_English) else {
            return false
        }
        let userModelArray = userResponseModel.users?.filter({ (user) in
            if user.username == username {
                return true
            }
            return false
        })
        if userModelArray?.count ?? 0 > 0 {
            return true
        }
        return false
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
