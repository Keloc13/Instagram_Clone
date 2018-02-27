//
//  PhotoMapViewController.swift
//  instagram
//
//  Created by Kevin Nguyen on 2/20/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textFieldDescript: UITextField!
    @IBOutlet weak var instaImage: UIImageView!
    let vc = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        // Do any additional setup after loading the view.
            vc.sourceType = .camera
            self.present(vc, animated: true, completion: nil)
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        instaImage.image = resize(image: originalImage,newSize: CGSize(width: 200, height: 200) )
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func callCameraGallery(_ sender: Any) {
         self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        print("Reached done button")
        let post = Post()
        post.postUserImage( image: instaImage.image, withCaption: textFieldDescript.text) {(success, error) -> Void in
            if success != nil {
                print("Saved was successful")
            } else {
                print("Error, data was not saved in the file.")
            }
        }
        textFieldDescript.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
