//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by Olga Dalton on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    @IBOutlet weak var titleTextOutlet: UILabel!
    // MARK: - Variables
    var itemIndex: Int = 0
    var titleText = ""
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
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextOutlet.text = self.titleText
    }
}
