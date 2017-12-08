//
//  AddNewController.swift
//  Journal
//
//  Created by Susu Liang on 2017/12/8.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Nuke

class AddNewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Property
    var journal: Journal?
    
    @IBOutlet weak var photoPlaced: UIImageView!

    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var contentTextField: UITextField!

    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var separator: UIView!

    var imagePicker: UIImagePickerController!

    var ref: DatabaseReference?

    var handle: DatabaseHandle?

    @IBAction func pickPhoto(_ sender: UIButton) {

        imagePicker = UIImagePickerController()

        imagePicker.delegate = self

        imagePicker.allowsEditing = false

        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setTextField()

        setSaveButton()

        setPhotoPlaceeHolder()

        setSeparator()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


    @IBAction func saveEntry() {

        guard

            let content = contentTextField.text,

            let title = titleTextField.text,

            let photo = photoPlaced.image

        else {

            print("Form is not valid")

            return

        }

        var data = Data()

        data = UIImageJPEGRepresentation(photoPlaced.image!, 1)!

        let ref = Database.database().reference()

        let storageRef = Storage.storage().reference()

        let metadata = StorageMetadata()
        
        metadata.contentType = "image/jpg"

        let uploadTask = storageRef.child("\(title).jpg").putData(data, metadata: metadata) { (metadata, error) in

            guard let metadata = metadata else {

                // Todo: error handling

                return
            }

            let downloadURL = metadata.downloadURL()?.absoluteString

            let value = ["title": title, "content": content, "imageURL": downloadURL, "date": "\(Date())"]
            
            if self.journal != nil {
                
                ref.child("Entry").child((self.journal?.id)!).setValue(value)
                
            }

            ref.child("Entry").childByAutoId().setValue(value)

        }
        
    }

}

// MARK: - Set up views
extension AddNewController {

    func setTextField() {

        titleTextField.isUserInteractionEnabled = true

        titleTextField.becomeFirstResponder()

        titleTextField.borderStyle = .none
        
        titleTextField.tintColor = .clear

        contentTextField.contentVerticalAlignment = .top

        contentTextField.isUserInteractionEnabled = true

        contentTextField.becomeFirstResponder()

        contentTextField.borderStyle = .none
        
        contentTextField.tintColor = .clear
        
        
        if journal != nil {
            
            titleTextField.text = journal?.title
            
            contentTextField.text = journal?.content
        }

    }

    func setSaveButton() {

        saveButton.layer.cornerRadius = 22

        saveButton.titleLabel?.font = UIFont(name: "SFUIText", size: 20)

        saveButton.frame.size.height = 44

        saveButton.backgroundColor = UIColor(red: 237/255, green: 96/255, blue: 81/255, alpha: 1)

    }

    func setPhotoPlaceeHolder() {

        photoPlaced.backgroundColor = UIColor(red: 67/255, green: 87/255, blue: 97/255, alpha: 1)

        photoPlaced.image = UIImage(named: "icon_photo")?.withRenderingMode(.alwaysTemplate)

        photoPlaced.contentMode = .center

        photoPlaced.tintColor = UIColor.white
        
        if journal != nil {
            
            Nuke.loadImage(with: (journal?.imageURL)!, into: photoPlaced)
            
            photoPlaced.contentMode = .scaleAspectFit
        }

    }

    func setSeparator() {

        separator.backgroundColor = UIColor(red: 171/255, green: 179/255, blue:176/255, alpha: 1)

        separator.frame.size.height = 0.5
    }

}

// MARK: - UIImagePickerControllerDelegate Methods
extension AddNewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            photoPlaced.image = pickedImage

            photoPlaced.contentMode = .scaleAspectFill

            dismiss(animated: true, completion: nil)

        }
    }

}
