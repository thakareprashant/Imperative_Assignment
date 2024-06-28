//
//  ProfileViewController.swift
//  MyAssignment
//
//  Created by pthakare on 26/06/24.
//

import UIKit
import DropDown

class ProfileViewController: UIViewController {

    //MARK: Personal Details
    @IBOutlet weak var personalView: UIStackView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: Address Details
    @IBOutlet weak var addressView: UIStackView!
    @IBOutlet weak var addressTextView: UITextView!
    
    //MARK: Other Details
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var otherView: UIStackView!
    @IBOutlet weak var fatherNameTextField: UITextField!
    @IBOutlet weak var motherNameTextField: UITextField!
    @IBOutlet weak var occupationTextFiled: UITextField!
    
    private lazy var occupationDropDown = DropDown()
    var sectionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        
        addressTextView.layer.cornerRadius = 5
        addressTextView.layer.borderWidth = 1
        addressTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backTabClick(_ sender: Any) {
        if sectionIndex == 0 {
            self.navigationController?.popViewController(animated: true)
        }
        
        sectionIndex -= 1
        updateViewSection()
    }
    
    @IBAction func nextTabClick(_ sender: Any) {
    
        if (validate() == false) {
            return
        } else if sectionIndex == 2 {
            return
        }
         
        sectionIndex += 1
        updateViewSection()
    }
    
    @IBAction func dropDownClick(_ sender: Any) {
        
        occupationDropDown.dataSource = Constants.professionArray
        occupationDropDown.anchorView = occupationTextFiled
        occupationDropDown.backgroundColor = UIColor.white
        occupationDropDown.cornerRadius = 5
        occupationDropDown.show()

        occupationDropDown.selectionAction = { [weak self] (index, item) in
            self?.occupationTextFiled.text = item
        }
        
    }
    
    @IBAction func submitButtonClick(_ sender: Any) {
        self.showToast(message: Dialogs.detailsSaveMessage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    //MARK: Validation
    private func validate() -> Bool {
        
        switch sectionIndex {
        case 0:
            
            if titleTextField.text?.isEmpty == true {
                self.showToast(message: Dialogs.enterTitleMessage)
                return false
            } else if fullNameTextField.text?.isEmpty == true {
                self.showToast(message: Dialogs.enterFirstNameMessage)
                return false
            } else if mobileNumberTextField.text?.isEmpty == true {
                self.showToast(message: Dialogs.invalidMobile)
                return false
            } else if (mobileNumberTextField.text?.count ?? 0) < 10 || (mobileNumberTextField.text?.count ?? 0) > 10 {
                self.showToast(message: Dialogs.invalidMobile)
                return false
            } else if emailTextField.text?.isEmpty == true {
                self.showToast(message: Dialogs.emptyMail)
                return false
            } else if emailTextField.text?.validateEmail() == false {
                self.showToast(message: Dialogs.invalidMail)
                return false
            } else {
                return true
            }

        case 1:
            
            if addressTextView.text?.isEmpty == true {
                self.showToast(message: Dialogs.validAddress)
                return false
            } else {
                return true
            }
    
        default:
            
            if fatherNameTextField.text?.isEmpty == true {
                self.showToast(message: Dialogs.enterFatherName)
                return false
            } else if motherNameTextField.text?.isEmpty == true {
                self.showToast(message: Dialogs.enterMotherName)
                return false
            } else {
                return true
            }
        }
        
    }
    
      //Changing UI as per the section
    private func updateViewSection() {
        
        switch sectionIndex {
        case 0:
            
            submitButton.isHidden = true
            personalView.isHidden = false
            addressView.isHidden = true
            otherView.isHidden = true
            break
        case 1:
            
            submitButton.isHidden = true
            personalView.isHidden = true
            addressView.isHidden = false
            otherView.isHidden = true
            break
        default:
            
            submitButton.isHidden = false
            personalView.isHidden = true
            addressView.isHidden = true
            otherView.isHidden = false
            break
        }
    }
    
}
