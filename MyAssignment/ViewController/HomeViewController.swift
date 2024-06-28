//
//  HomeViewController.swift
//  MyAssignment
//
//  Created by pthakare on 25/06/24.
//

import UIKit
import SWRevealViewController

class HomeViewController: UIViewController {

    @IBOutlet weak var buttonSideMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setUpRevealSideDrawer()
    }
    
    @IBAction func profileSectionClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backTabClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpRevealSideDrawer() {
 
        if  revealViewController() != nil {
     
            buttonSideMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
        }
    }
}
