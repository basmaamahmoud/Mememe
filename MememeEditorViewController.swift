//
//  MememeEditorViewController.swift
//  MememeV2
//
//  Created by Basma Ahmed Mohamed Mahmoud on 3/8/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func back(controller: MememeEditorViewController)
}

class MememeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // meme image without toolbar
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var viewImage: UIView!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    @IBOutlet weak var shareButtnCheck: UIBarButtonItem!
    @IBOutlet weak var cancelButtnCheck: UIBarButtonItem!
    
    @IBOutlet weak var albumbuttnCheck: UIBarButtonItem!
    @IBOutlet weak var cameraButtnCheck: UIBarButtonItem!
    
    
    var memeImage: UIImage!
    var imagePicker = UIImagePickerController()
    var delegate: CellDelegate?
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cameraButtnCheck.isEnabled = true
        shareButtnCheck.isEnabled = false
        
        configure(textField: topTextField, withText: "TOP")
        configure(textField: bottomTextField, withText: "BOTTOM")
        
        
        // check if the device has camera or not, it will disable the camera button
        if UIImagePickerController.availableCaptureModes(for: .rear) == nil{
            cameraButtnCheck.isEnabled = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if meme != nil{
            shareButtnCheck.isEnabled = true
            showSavedMemeImage(memeTopText: meme.topText!, memeBottomText: meme.bottomText!, OriginalSavedImage: meme.originalImage!)
        }
    }
    
    func showSavedMemeImage (memeTopText: String, memeBottomText: String,OriginalSavedImage: UIImage){
        
        topTextField.text = memeTopText
        bottomTextField.text = memeBottomText
        configure(textField: topTextField, withText: topTextField.text!)
        configure(textField: bottomTextField, withText: bottomTextField.text!)
        imageView.image = OriginalSavedImage
        
    }
    
    func configure(textField: UITextField, withText text: String) {
        
        imagePicker.delegate = self
        textField.delegate = self
        
        let memeTextAttributes:[NSAttributedStringKey:Any] = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        ]
        
        textField.attributedText = NSAttributedString(string: text, attributes: memeTextAttributes)
        textField.autocapitalizationType = .allCharacters
    }
    
    // This function to let keyboard dissappear when we press return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // this function to move the view up according to the keyboard
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == bottomTextField {
            let moveValue: CGFloat = UIDevice.current.orientation.isLandscape ? 150.0 : 220.0
            animateViewMoving(up: true, moveValue: moveValue)
        }
        
        if topTextField.isEditing == true{
            configure(textField: topTextField, withText: " ")
        } else if bottomTextField.isEditing == true {
            configure(textField: bottomTextField, withText: " ")
        }
    }
    
    
    // this function to return back the view down according to the keyboard were dismissed
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if textField == bottomTextField {
            let moveValue: CGFloat = UIDevice.current.orientation.isLandscape ? 150.0 : 220.0
            animateViewMoving(up: true, moveValue: -moveValue)
        }
    }
    
    
    // image Picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            if imageView.image != nil{
                shareButtnCheck.isEnabled = true
                
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func albumButtn(_ sender: Any) {
        presentImagePickerWith(imagePick: imagePicker, sourceType: .photoLibrary, animated: false)
    }
    
    @IBAction func cameraButtn(_ sender: Any) {
        presentImagePickerWith(imagePick: imagePicker, sourceType: .camera, animated: true)
    }
    
    @IBAction func cancelImageButtn(_ sender: Any) {
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButtnCheck.isEnabled = false
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareButtn(_ sender: Any) {
        hideToolbars(flag: true)
        
        memeImage = viewImage.MemeImage
        
        hideToolbars(flag: false)
        
        
        let activityViewController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.save(memed: self.memeImage)
                self.dismiss(animated: true, completion: {
                    if self.delegate != nil {
                        self.delegate?.back(controller: self)
                    }
                })
                
            }
            
        }
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        present(activityViewController, animated: true, completion: nil)
        
    }
    func presentImagePickerWith(imagePick: UIImagePickerController, sourceType: UIImagePickerControllerSourceType, animated: Bool) {
        
        imagePick.sourceType = sourceType
        imagePick.allowsEditing = animated
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func save(memed: UIImage) {
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memed)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = (self.view.frame).offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    func hideToolbars(flag: Bool) {
        topToolBar.isHidden = flag
        bottomToolBar.isHidden = flag
    }
    
}
extension UIView {
    
    var MemeImage: UIImage?  {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 1.0);
        if let _ = UIGraphicsGetCurrentContext() {
            drawHierarchy(in: bounds, afterScreenUpdates: true)
            let MemeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return MemeImage
        }
        return nil
    }
}

