//
//  textFieldDelegate.swift
//  Meme
//
//  Created by Raphael Neuenschwander on 05.05.15.
//  Copyright (c) 2015 Raphael Neuenschwander. All rights reserved.
//

import Foundation
import UIKit

// This class implement the methods for our textfields of our MemeViewController


// Hide the keyboard when the user hit "return"
class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

// Clears the text in the textfields when the user starts editing.
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
}
