//  LoginViewController.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//


import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTF: CustomTextField!
    @IBOutlet weak var userNameTF: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateUserName() -> Bool {
        guard let userName = userNameTF.text, !userName.isEmpty else {
            self.showToast(message: Dialogs.emptyUserName)
            return false
        }
        
        return true
    }
    
    func validatePassword() -> Bool {
        guard let password = passwordTF.text, !password.isEmpty else {
            self.showToast(message: Dialogs.emptyPassword)
            return false
        }
        
        return true
    }


    @IBAction func didTapLogin(_ sender: UIButton) {
        if validateUserName() && validatePassword(){
            PreferenceManager.shared.writeBoolean(key: .isLoggedIn, value: true)
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
               // to do
                scene.moveToStartScreen()
            }
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
