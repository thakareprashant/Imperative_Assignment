//
//  SceneDelegate.swift
//  MyAssignment
//
//  Created by pthakare on 25/06/24.
//

import UIKit
import SWRevealViewController

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SWRevealViewControllerDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let winScene = (scene as? UIWindowScene) else { return }
        
        let win = UIWindow(windowScene: winScene)
        window = win
        if PreferenceManager.shared.readBoolean(key: .isLoggedIn){
            moveToStartScreen()
        }
        else{
            moveToLogin()
        }
       
        
//        moveToStartScreen()
    }
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    func moveToLogin(){
       
        let vc =  storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController.init(rootViewController: vc)
        navigationController.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    func moveToStartScreen() {
        
       
        
        let revealController = SWRevealViewController()

        let sidebar = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let homepage = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        revealController.frontViewController = homepage
        revealController.rearViewController = sidebar
        revealController.delegate = self
        
        let navigationController = UINavigationController.init(rootViewController: revealController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

