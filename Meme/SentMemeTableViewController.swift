//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Raphael Neuenschwander on 07.05.15.
//  Copyright (c) 2015 Raphael Neuenschwander. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // retrieve the saved memes from our shared model located in AppDelegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        memes = appDelegate.memes
        
    }
    
    // Number of rows to be displayed corresponds to the number of memes
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    // Display a meme image for each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeTableCell") as! UITableViewCell
        
        let meme = memes[indexPath.row]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.textTop) -- \(meme.textBottom)"
        
        return cell
        
    }
    
    // Show a detailed view of the selected Meme
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tableController = self.storyboard?.instantiateViewControllerWithIdentifier("SentMemeDetailViewController") as! SentMemeDetailViewController
        
        tableController.meme = self.memes[indexPath.row]
        
        self.navigationController?.pushViewController(tableController, animated: true)
    
    }
    
    
    
    
    @IBAction func editNewMeme(sender: UIBarButtonItem) {
        
        let myController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        
        presentViewController(myController, animated: true, completion: nil)
        
    }


}
