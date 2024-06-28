//
//  SideMenuViewController.swift
//  MyAssignment
//
//  Created by pthakare on 25/06/24.
//

import UIKit
import SWRevealViewController


class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func didTapOption(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch sender.tag {
        case 100: // privacy policy
            
            
            let vc = storyboard.instantiateViewController(withIdentifier: "PrivacyViewBrowser") as! PrivacyViewBrowser
            
            self.navigationController?.pushViewController(vc, animated: true)
     
            
            break
        case 101: // Location
            
           
            let vc = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default: // Web View
            
           
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewBrowser") as! WebViewBrowser
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        }
        
        self.revealViewController().revealToggle(animated: true)
    }
    
}


