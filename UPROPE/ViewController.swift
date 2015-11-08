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
    let titles = ["hello", "next Slide. you win", "third slide", "fourth"]
    var x = 0
       // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
        sendObject()
        //        temporary to send a json example
    }
    override func prefersStatusBarHidden() -> Bool {
        return true;
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
        if self.x != 1{
            
            if let itemController = viewController as? PageItemController {
                if itemController.itemIndex-1 > titles.count {
                    return getItemController(itemController.itemIndex-1)
                }
            } else {
        }
            if let itemController = viewController as? TypeOneViewController {
                if itemController.itemIndex - 1 > titles.count {
                    return getItemController(itemController.itemIndex-1)
                }
            }
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if self.x != 0 {
        if let itemController = viewController as? PageItemController {
            if itemController.itemIndex+1 < titles.count {
                return getItemController(itemController.itemIndex+1)
            }
        }
        }else {
            if let itemController = viewController as? TypeOneViewController {
                return getItemController(itemController.itemIndex+1)
            }
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
            } else if self.x == 1 {
                let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("typeOneViewController") as! TypeOneViewController
                pageItemController.itemIndex = itemIndex
                print("itemindex", itemIndex)
                pageItemController.titleText = self.titles[itemIndex]
                return pageItemController
                self.x += 1
            } else {
                let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
                pageItemController.itemIndex = itemIndex
                pageItemController.titleText = titles[itemIndex]
                self.x += 1
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
        let respondent = Party(firstName: "joe", lastName: "sdf", birthDate: NSDate(), lastKnownState: "WA", lastKnownCounty: "King", partyType: "respondent")

//        var children = [Child]()
//        var childrenMap = [NSDictionary]()
//
//        let childOne = Child(firstName: "Tim", lastName: "sdf", age: 10, legalParents: ["respondent","petitioner"])
//        let childTwo = Child(firstName: "Sara", lastName: "sdf", age: 13, legalParents: ["petitioner"])
//        let childThree = Child(firstName: "Sam", lastName: "sdf", age: 16, legalParents: ["respondent"])
//        let childFour = Child(firstName: "Tess", lastName: "sdf", age: 9, legalParents: ["respondent","petitioner"])
//
//        children.append(childOne)
//        children.append(childTwo)
//        children.append(childThree)
//        children.append(childFour)

        let form = Form(respondent: petitioner, petitioner: petitioner, dateMarried: NSDate(), cityMarried: "Springfield", stateMarried: "Arizona", brokenMarriage:  true, separation: nil, children: nil)

        let petitionerMap = [
            "firstName": String(petitioner.firstName),
            "lastName": String(petitioner.lastName),
            "birthDate": String(petitioner.birthDate),
            "lastKnownState": String(petitioner.lastKnownState),
            "lastKnownCounty": String(petitioner.lastKnownCounty)
        ]

        let respondentMap = [
            "firstName": String(respondent.firstName),
            "lastName": String(respondent.lastName),
            "birthDate": String(respondent.birthDate),
            "lastKnownState": String(respondent.lastKnownState),
            "lastKnownCounty": String(respondent.lastKnownCounty)
        ]

//        for child in children
//        {
//            let childMap = [
//                "firstname": child.firstName,
//                "lastname": child.lastName,
//                "age": child.age,
//                "legalParents": child.legalParents
//            ]
//            childrenMap.append(childMap)
//        }

        return [
            "respondent": petitionerMap,
            "petitioner": respondentMap,
            "dateMarried": String(form.dateMarried),
            "cityMarried": form.cityMarried,
            "stateMarried": form.stateMarried,
            "brokenMarriage": String(form.brokenMarriage),
            "separation": "",
            "children": ""
        ]
    }
    
}
