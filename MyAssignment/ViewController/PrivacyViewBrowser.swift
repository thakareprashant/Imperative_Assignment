//
//  PrivacyViewBrowser.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//

import UIKit

class PrivacyViewBrowser: UIViewController {

    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func agreeBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func policyAcceptenceClick(_ sender: Any) {
        //Checked if check box is selected
        if checkboxBtn.isSelected == false {
            self.showToast(message: Dialogs.acceptPolicyMessage)
            return
        }
        
        self.showToast(message: Dialogs.thankMessagePolicy)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    @IBAction func policyDisagreeClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PrivacyViewBrowser: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: ContenTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
