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

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoButton.layer.cornerRadius = photoButton.frame.size.height / 2
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = photoButton.frame.size.height / 2
        GCDbutton.layer.cornerRadius = 9
        GCDbutton.layer.borderWidth = 1.0
        operationButton.layer.cornerRadius = 9
        operationButton.layer.borderWidth = 1.0
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
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
