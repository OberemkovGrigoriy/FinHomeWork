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
    let operationDataManager: OperationDataManager = OperationDataManager()
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var GCDbutton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var operationButton: UIButton!
    @IBOutlet weak var nameProfileField: UITextField!
    @IBOutlet weak var AboutProfileField: UITextField!
    var checkName: String? = ""
    var checkAbout: String? = ""
    var checkImage: UIImage? = nil
    
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
    
    
    
    
    
    
    // MARK: -Configuration and viewdidload
    
    
    
    
    
    
    
    @IBAction func nameChange(_ sender: Any) {
        GCDbutton.isEnabled = true
        operationButton.isEnabled = true
    }
    
    @IBAction func aboutChange(_ sender: Any) {
        GCDbutton.isEnabled = true
        operationButton.isEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //operationDataManager.load(closure: self.setInfo)
        gcdDataManager.load(closure: self.setInfo)
        photoButton.layer.cornerRadius = photoButton.frame.size.height / 2
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = photoButton.frame.size.height / 2
        GCDbutton.layer.cornerRadius = 9
        GCDbutton.layer.borderWidth = 1.0
        operationButton.layer.cornerRadius = 9
        operationButton.layer.borderWidth = 1.0
        activityIndicator.hidesWhenStopped = true
        GCDbutton.isEnabled = false
        operationButton.isEnabled = false
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: -PhotoButton
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        GCDbutton.isEnabled = true
        operationButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    

    
    
    // MARK: -GCD and Operation button, and closure

    
    
    
    
    @IBAction func GCDButtonTap(_ sender: Any) {
        if(checkName == self.nameProfileField.text && checkImage! == self.profileImage.image && checkAbout == self.AboutProfileField.text){
            return
        }
        else{
            save = true
        let ourProfileObject = ProfileDataToSave(profileName: nameProfileField.text, profileAbout: AboutProfileField.text, profileImage: profileImage.image)
        gcdDataManager.save(dataToSave: ourProfileObject, closure: {
            self.saveClosure()
        })
       
        }
    }
    
    func saveClosure(){
        self.save = false
        gcdDataManager.load(closure: self.setInfo)
        
        if(self.nameProfileField.text == nil || self.profileImage.image == nil || self.AboutProfileField.text == nil){
            let refreshAlert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { (action: UIAlertAction!) in
                self.save = true
                let ourProfileObject = ProfileDataToSave(profileName: self.nameProfileField.text, profileAbout: self.AboutProfileField.text, profileImage: self.profileImage.image)
                self.sendToSave(obj: self.gcdDataManager, data: ourProfileObject, clos: {
                    self.saveClosure()
            })
//                self.gcdDataManager.save(dataToSave: ourProfileObject, closure: {
//                    self.saveClosure()
//                })
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else{
        let alert = UIAlertController(title: "Сохранение успешно", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
        })
        self.present(alert, animated: true)
        GCDbutton.isEnabled = false
        operationButton.isEnabled = false
        
        }
    }
    
    func saveOperationClosure(){
        self.save = false
        operationDataManager.load(closure: self.setInfo)
        
        if(self.nameProfileField.text == nil || self.profileImage.image == nil || self.AboutProfileField.text == nil){
            let refreshAlert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { (action: UIAlertAction!) in
                self.save = true
                let ourProfileObject = ProfileDataToSave(profileName: self.nameProfileField.text, profileAbout: self.AboutProfileField.text, profileImage: self.profileImage.image)
                
                self.gcdDataManager.save(dataToSave: ourProfileObject, closure: {
                    self.saveClosure()
                })
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Сохранение успешно", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            })
            self.present(alert, animated: true)
            GCDbutton.isEnabled = false
            operationButton.isEnabled = false
        }
    }
    
    @IBAction func operationButtonTap(_ sender: Any) {
        if(checkName == self.nameProfileField.text && checkImage! == self.profileImage.image && checkAbout == self.AboutProfileField.text){
        return
        }
        else{
        self.save = true
        
        let ourProfileObject = ProfileDataToSave(profileName: nameProfileField.text, profileAbout: AboutProfileField.text, profileImage: profileImage.image)
        
        sendToSave(obj: operationDataManager, data: ourProfileObject, clos: {
            self.saveOperationClosure()})
        }
        //                self.operationDataManager.save(dataToSave: ourProfileObject, closure: {
        //                    self.saveOperationClosure()
        //                })
        
    }
    
    func setInfo(user:ProfileDataToSave?){
        if let data = user{
            self.profileImage.image = data.profileImage
            self.AboutProfileField.text = data.profileAbout
            self.nameProfileField.text = data.profileName
            
            checkName = data.profileName
            checkAbout = data.profileAbout
            checkImage = data.profileImage
            
        }
    }
    
    //функция для крутанов?
    func sendToSave(obj:DataManagerMustSave, data: ProfileDataToSave, clos: @escaping ()->()){
        obj.save(dataToSave: data, closure: clos)
    }
    
}
