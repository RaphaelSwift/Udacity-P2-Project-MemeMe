//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by Raphael Neuenschwander on 07.05.15.
//  Copyright (c) 2015 Raphael Neuenschwander. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController {

    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        memes = appDelegate.memes
        
    }


}
