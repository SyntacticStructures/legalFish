//
//  TypeOneViewController.swift
//  UPROPE
//
//  Created by Computer on 11/7/15.
//  Copyright © 2015 Computer. All rights reserved.
//

import UIKit
import FontAwesome_swift


class TypeOneViewController: UIViewController {
    
    @IBOutlet var labelsHideForever: [UILabel]!

    @IBOutlet var buttonsAlwaysHide: [UIButton]!
    @IBOutlet var buttonsToHide: [UIButton]!
   

    @IBOutlet var textViewsToHide: [UITextView]!
    
    @IBOutlet var labelsToHide: [UILabel]!
    
    @IBOutlet weak var yesNoOutlet: UISegmentedControl!
    
    @IBOutlet var buttonToIconCollection: [UIButton]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageOutlet: UIButton!
    
    @IBOutlet weak var titleTextOutlet: UILabel!
    // MARK: - Variables
    var itemIndex: Int = 0
    var titleText = ""
    let colorPalate = ColorPalate()
    //    var imageName: String = "" {
    //
    //        didSet {
    //
    //            if let imageView = contentImageView {
    //                imageView.image = UIImage(named: imageName)
    //            }
    //
    //        }
    //    }
    
    @IBAction func nextButton(sender: AnyObject) {
    }
    
    @IBAction func prevButton(sender: AnyObject) {
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageOutlet.titleLabel?.font = UIFont.fontAwesomeOfSize(25)
        self.imageOutlet.setTitle(String.fontAwesomeIconWithName(.Bars), forState: .Normal)
        self.imageOutlet.setTitleColor(colorPalate.lightText, forState: .Normal)
//        self.scrollView.directionalLockEnabled = true;
//        let point = CGPointMake(0, self.scrollView.contentOffset.y)
//        self.scrollView.setContentOffset(point, animated: false)
//        self.scrollView.directionalLockEnabled = false
        self.hideAll()
        for button in buttonsToHide {
            button.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
            button.setTitle(String.fontAwesomeIconWithName(.SquareO), forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        for button in buttonsAlwaysHide {
            button.hidden = true
        }
        for label in labelsHideForever {
            label.hidden = true
        }
        
        //        self.titleTextOutlet.text = self.titleText
//        self.imageOutlet.backgroundColor
        
    }
    
    @IBAction func yesNoDidChange(sender: AnyObject) {
        if self.yesNoOutlet.selectedSegmentIndex == 1 {
            self.hideAll()
            
        } else {
            self.showAll()
        }
        print(self.yesNoOutlet.selectedSegmentIndex)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func hideAll() {
        for outlet in self.labelsToHide {
            outlet.hidden = true
        }
        for outlet in self.buttonsToHide {
            outlet.hidden = true
        }
        for outlet in self.textViewsToHide {
            outlet.hidden = true
        }
    }
    
    @IBAction func checkTapped(sender: AnyObject) {
        for button in buttonsToHide {
            if sender.tag == button.tag { 
                button.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
                button.setTitle(String.fontAwesomeIconWithName(.CheckSquareO), forState: .Normal)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
        }
    }

    func showAll() {
        for outlet in self.labelsToHide {
            outlet.hidden = false
        }
        for outlet in self.buttonsToHide {
            outlet.hidden = false
        }
        for outlet in self.textViewsToHide {
            outlet.hidden = false
        }
    }
}
