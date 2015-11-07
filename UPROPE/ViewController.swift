//
//  ViewController.swift
//  UPROPE
//
//  Created by Computer on 10/12/15.
//  Copyright © 2015 Computer. All rights reserved.
//

//temporarily need to parse through html page to get info. This will not be needed when we json from backend
import UIKit
var userInfoLabelCollection: [UILabel]!
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPageViewControllerDataSource {
    private var pageViewController: UIPageViewController?
    let titles = ["hello", "next Slide. you win"]
       // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
        //        temporary to send a json example
        self.sendObject()
    }
    //    test function
    func sendObject() {
        let respondent = Party(firstName: "first", lastName: "last", birthDate: NSDate(), lastKnownState: "WA", lastKnownCounty: "King" , partyType: "respondet" )
        let petitioner = Party(firstName: "firstTwo", lastName: "lastTwo", birthDate: NSDate(), lastKnownState: "OR", lastKnownCounty: "Clamath", partyType: "petitioner")
        
        let form = Form(respondent: respondent, petitioner: petitioner, dateMarried: NSDate(), cityMarried: "Seattle", stateMarried: "WA", separation: nil, children: nil)
        let requestString = "https://legalvoice.azurewebsites.net/FORM"
        
        let objectToPass = ["form":form]
        
        
        Alamofire.request(.POST, requestString, parameters: objectToPass, encoding: .JSON)
            .responseJSON { response in
                print(response)
                print(response.data)
        }
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if titles.count > 0 {
            let firstController = getItemController(0)!
            var startingViewControllers = [PageItemController]()
            startingViewControllers.append(firstController)
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex+1 < titles.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < titles.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.titleText = titles[itemIndex]
            return pageItemController
        }
        
        return nil
    }
}

