//
//  ProfileViewController.swift
//  Kindergarten
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Profile"
        self.updateUI()
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
    
    @IBAction func onLogoutClick(_ sender: Any) {
        LocalStorageManager.shared.selectedUsername = nil
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Other

    private func updateUI() {
        guard let username = LocalStorageManager.shared.selectedUsername else {
            return
        }
        guard let userResponseModel: UserResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .UserJson_English) else {
            return
        }
        let userModel = userResponseModel.users?.filter({ (user) in
            if user.username == username {
                return true
            }
            return false
        }).first
        self.usernameLabel.text = username
        self.fullNameLabel.text = userModel?.fullName
        self.emailLabel.text = userModel?.email
    }
}
