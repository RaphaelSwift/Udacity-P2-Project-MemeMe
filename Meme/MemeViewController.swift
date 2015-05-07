//
//  ViewController.swift
//  Meme
//
//  Created by Raphael Neuenschwander on 04.05.15.
//  Copyright (c) 2015 Raphael Neuenschwander. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // View
    @IBOutlet weak var imagePickerView: UIImageView!
    
    // Buttons
    @IBOutlet weak var pickFromCamera: UIBarButtonItem!
    @IBOutlet weak var shareMeme: UIBarButtonItem!
    
    //Text Fields
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    
    
    let textFieldDelegate = TextFieldDelegate()
    
    // Navigation and Tool bars
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the attributes of the textfields
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor() ,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSStrokeWidthAttributeName : -3.0,
        ]
        
        self.textFieldTop.defaultTextAttributes = memeTextAttributes
        self.textFieldBottom.defaultTextAttributes = memeTextAttributes
        
        textFieldTop.textAlignment = .Center
        textFieldBottom.textAlignment = .Center
        
        textFieldBottom.borderStyle = .None
        textFieldTop.borderStyle = .None
        
        textFieldTop.text = "TOP"
        textFieldBottom.text = "BOTTOM"
        
        // Delegate the text fields to the class TextFieldDelegate
        self.textFieldTop.delegate = self.textFieldDelegate
        self.textFieldBottom.delegate = self.textFieldDelegate
        
        // Disable the share button untill an image is picked
        shareMeme.enabled = false
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // Enable the camera button only if the device has a camera
        pickFromCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        

        
        // Set the attribute of the imagePickerView
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
        
        // Call the suscribe to keyboard notifications method
        subscribeToKeyboardNotification()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        // Call the unsubscribe to keyboard notifications method
        unsubscribeToKeyboardNotification()
        
    }


// *** Generate and save the Meme object *** //
    
    // Create a Meme object and add it to the Meme array
    
    func save() {
        
        // Create the Meme object
        var meme = Meme(textTop: textFieldTop.text!, textBottom: textFieldBottom.text!, image: imagePickerView.image!, memedImage: generateMemedImage())
        // Add it to the Meme array
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    // Generate a meme image
    
    func generateMemedImage () -> UIImage {
        
        // Hide navigation bar & tool bar
        
        toolBar.hidden = true
        navigationBar.hidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show navigation bar & tool bar
        toolBar.hidden = false
        navigationBar.hidden = false
        
        return memedImage
        
    }
    
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        
        //Generate the meme
        let memedImage = generateMemedImage()
        // Define an array that will store our meme image
        var memedImages = [UIImage]()
        //Add it to our array of meme
        memedImages.append(memedImage)
        // pass the activity item to our activityViewController
        let myController = UIActivityViewController(activityItems: memedImages as [AnyObject], applicationActivities: nil)
        // present our activityViewController
        presentViewController(myController, animated: true, completion: nil)
    
        // Choose the completion item handler
        myController.completionWithItemsHandler = saveMemeAfterSharing
    }
    
    // The completion item handler that call the methods, to save and dismiss the viewcontroller
    func saveMemeAfterSharing (String!,completed: Bool, [AnyObject]!, NSError!) -> Void {
        if completed {
        self.save()
        self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    

    
// *** ----------------------------------- *** //

    
    
    
 // *** The user picks an image from the library or with his camera *** //
    
    // Methods to pick the images
    
    @IBAction func pickAnImageFromLibrary(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        //Set the sourcetype to be library
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
           presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        // Set the sourcetype to be camera
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }

    // Display the picked image
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            
            // enable the "Share" button
            shareMeme.enabled = true
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Dismiss the view controller if the user presses "Cancel"
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
// ---------------------------------------------------------------------------- //

    
 // *** The view goes up as the keyboard appears when the user enters the bottom textfield and goes down he leaves  ***//
    
    // Subscribe to keyboard notifications
    
    func subscribeToKeyboardNotification () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Unsubscribe to keyboard notifications

    
    func unsubscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // The view goes up of the height of the keyboard when the keyboard appears
    
    func keyboardWillShow(notification : NSNotification) {
        if self.textFieldBottom.isFirstResponder() {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // The view goes down of the height of the keyboard when the keyboard disappears
    
    func keyboardWillHide(notification : NSNotification) {
        if self.textFieldBottom.isFirstResponder() {
        self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    // Get the height of the keyboard
    
    func getKeyboardHeight(notification : NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
    }
    
// ---------------------------------------------------------------------------- //
    
}
    
    



