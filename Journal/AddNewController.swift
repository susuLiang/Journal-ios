//
//  AddNewController.swift
//  Journal
//
//  Created by Susu Liang on 2017/12/8.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit

class AddNewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoPlaced: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setSaveButton()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddNewController {
    
    func setTextField() {
        
        titleTextField.isUserInteractionEnabled = true
        
        titleTextField.becomeFirstResponder()
        
        titleTextField.borderStyle = .none
        
        contentTextField.isUserInteractionEnabled = true
        
        contentTextField.becomeFirstResponder()
        
        contentTextField.borderStyle = .none
        
    }
    
    func setSaveButton() {
        
        saveButton.layer.cornerRadius = 22
        
        saveButton.titleLabel?.font = UIFont(name: "SFUIText", size: 20)
        
    }
    
    
    
    
}
