//
//  ViewController.swift
//  UPROPE
//
//  Created by Computer on 10/12/15.
//  Copyright © 2015 Computer. All rights reserved.
//

//temporarily need to parse through html page to get info. This will not be needed when we json from backend
import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class ViewController: UIViewController, UIPageViewControllerDataSource {
    var userInfoLabelCollection: [UILabel]!
    private var pageViewController: UIPageViewController?
    let titles = ["hello", "next Slide. you win"]
    var x = 0
       // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
        sendObject()
        //        temporary to send a json example
    }
    //    test function
    func sendObject() {
        let formParameters = formToDictionary()
        let postURL = "http://legalvoice.azurewebsites.net/api/FORM"
        if NSJSONSerialization.isValidJSONObject(formParameters) {
            print("dictPoint is valid JSON")
            Alamofire.request(.POST, postURL, parameters: formParameters)
            .responseJSON { response in
                let json = JSON(data: response.data!)
                print(response)
                print(json)
            }
        }
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if titles.count > 0 {
            let firstController = getItemController(0)!
            var startingViewControllers = [UIViewController]()
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
    
    private func getItemController(itemIndex: Int) -> UIViewController? {
        
        if itemIndex < titles.count {
            if self.x == 0 {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.titleText = titles[itemIndex]
                self.x += 1
            return pageItemController
            } else {
                let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("typeOneViewController") as! TypeOneViewController
                pageItemController.itemIndex = itemIndex
                pageItemController.titleText = titles[itemIndex]
                return pageItemController
            }
        }
        
        return nil
    }
    
    class LocationPoint {
        var x: Double
        var y: Double
        var orientation: Double
        
        init(x: Double, y: Double, orientation: Double) {
            self.x = x
            self.y = y
            self.orientation = orientation
        }
    }
    
    
    func formToDictionary() -> [String: AnyObject] {
        let petitioner = Party(firstName: "josn", lastName: "sdf", birthDate: NSDate(), lastKnownState: "WA", lastKnownCounty: "King", partyType: "petitioner")
        let petitionerOne = [
            "firstName": String(petitioner.firstName),
            "lastName": String(petitioner.lastName),
            "birthDate": String(petitioner.birthDate),
            "lastKnownState": String(petitioner.lastKnownState),
            "lastKnownCounty": String(petitioner.lastKnownCounty)
        ]
        return [
            "respondent": petitionerOne,
            "petitioner": petitionerOne,
            "dateMarried": String(form.dateMarried),
            "cityMarried": form.cityMarried,
            "stateMarried": form.stateMarried,
            "separation": "lsdkfj",
            "children": "lsakjdf"
        ]
    }
    
}
