//
//  SentMemeDetailViewController.swift
//  Meme
//
//  Created by Raphael Neuenschwander on 08.05.15.
//  Copyright (c) 2015 Raphael Neuenschwander. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme:Meme!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        memeImageView.image = meme.memedImage
        
    }


}
