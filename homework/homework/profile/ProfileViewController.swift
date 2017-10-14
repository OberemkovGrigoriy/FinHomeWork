//
//  ProfileViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 11.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit
import Foundation


class ProfileViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let gcdDataManager: GCDDataManager = GCDDataManager()
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var GCDbutton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var operationButton: UIButton!
    
    @IBAction func tapPhotoButton(_ sender: Any) {
        print("Выбери изображение профиля")
        
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self 
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion:nil)
            }else{
                print("camera not available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo labrary", style: .default, handler: {(action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion:nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBOutlet weak var nameProfileField: UITextField!
    @IBOutlet weak var AboutProfileField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gcdDataManager.load(closure: self.setInfo)
        photoButton.layer.cornerRadius = photoButton.frame.size.height / 2
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = photoButton.frame.size.height / 2
        GCDbutton.layer.cornerRadius = 9
        GCDbutton.layer.borderWidth = 1.0
        operationButton.layer.cornerRadius = 9
        operationButton.layer.borderWidth = 1.0
        activityIndicator.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }

    
    var save: Bool  = false{
        didSet{
            if(save){
                activityIndicator.startAnimating()
                GCDbutton.isEnabled = false
                operationButton.isEnabled = false
            }
            else{
                activityIndicator.stopAnimating()
                GCDbutton.isEnabled = true
                operationButton.isEnabled = true
            }
        }
    }
    
    
    func setInfo(user:ProfileDataToSave?){
        if let data = user{
            self.profileImage.image = data.profileImage
            self.AboutProfileField.text = data.profileAbout
            self.nameProfileField.text = data.profileName
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func GCDButtonTap(_ sender: Any) {
        save = true
        let ourProfileObject = ProfileDataToSave(profileName: nameProfileField.text, profileAbout: AboutProfileField.text, profileImage: profileImage.image)
        gcdDataManager.save(dataToSave: ourProfileObject, closure: {
            self.saveClosure()
        })
        print("!!!!!!!!!!!!!!SAVE!!!!!!!!!!!!!!!!!!!!!!!!")
    }
    
    func saveClosure(){
        self.save = false
        let alert = UIAlertController(title: "Сохранение успешно", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    @IBAction func operationButtonTap(_ sender: Any) {
        save = true
        save = false
    }
    
}
