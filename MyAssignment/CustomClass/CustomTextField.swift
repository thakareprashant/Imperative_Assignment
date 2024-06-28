//  CustomTextField.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//
import Foundation
import UIKit


protocol CustomTextFieldDelegate: UITextFieldDelegate {
    func textFieldIconClicked(btn:UIButton)
}

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var leftPadding: CGFloat {
           get {
               return leftView?.frame.size.width ?? 0
           }
           set {
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
               leftView = paddingView
               leftViewMode = .always
           }
       }
       
       @IBInspectable var rightPadding: CGFloat {
           get {
               return rightView?.frame.size.width ?? 0
           }
           set {
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
               rightView = paddingView
               rightViewMode = .always
           }
       }
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
    @IBInspectable var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
    private var myDelegate: CustomTextFieldDelegate? {
        get { return delegate as? CustomTextFieldDelegate }
    }
    
    @objc func buttonClicked(btn: UIButton){
        self.myDelegate?.textFieldIconClicked(btn: btn)
    }
    
    //Padding images on left
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }
    
    //Padding images on Right
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }
    
    @IBInspectable var padding: CGFloat = 0
    @IBInspectable var leadingImage: UIImage? { didSet { updateView() }}
    @IBInspectable var color: UIColor = UIColor.lightGray { didSet { updateView() }}
    @IBInspectable var imageColor: UIColor? { didSet { updateView() }}
    @IBInspectable var rtl: Bool = false { didSet { updateView() }}
    @IBInspectable var disableKeyboard: Bool = false { didSet {
        
        if disableKeyboard == true {
            self.inputView = UIView()
        }
        
    }}
    
    
    //Date picker
    var maxDate = Date()
    private let datePicker = UIDatePicker()
    @IBInspectable var dateFormate: String = "MMMM yyyy"
    var datePickerMode: UIDatePicker.Mode = .date {
        didSet { datePicker.datePickerMode = datePickerMode }
    }
    
    @IBInspectable var isShowDatePicker: Bool = false {
        didSet {
            if isShowDatePicker {
                showDatePicker(txtDatePicker: self)
            }
        }
    }
    
    func updateView() {
        rightViewMode = UITextField.ViewMode.never
        rightView = nil
        leftViewMode = UITextField.ViewMode.never
        leftView = nil

        if let image = leadingImage {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            let imageView = UIImageView(frame: button.frame)
            imageView.center.y = button.frame.height/2 + 5
            imageView.image = tintedImage
            imageView.tintColor = imageColor
            button.addSubview(imageView)

            button.tintColor = imageColor
            button.setTitleColor(UIColor.clear, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked(btn:)), for: UIControl.Event.touchDown)
            button.isUserInteractionEnabled = true

            if rtl {
                rightViewMode = UITextField.ViewMode.always
                rightView = button
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width:10, height: frame.size.height))
                leftView = paddingView
                leftViewMode = .always
            } else {
                leftViewMode = UITextField.ViewMode.always
                leftView = button
                
            }
        }

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    
    private func showDatePicker(txtDatePicker:UITextField){
        
        //Formate Date
        datePicker.datePickerMode = datePickerMode
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.maximumDate = maxDate
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action:       #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:       UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:       #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated:       false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
    
    }
    
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormate
        let result = formatter.string(from: datePicker.date)
        self.text = result
        
        self.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.endEditing(true)
    }
    
}

   
