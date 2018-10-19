//
//  ViewControllerOfSegmenttedController.swift
//  Ertegi
//
//  Created by Kuanysh on 14.08.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit
import SJSegmentedScrollView


class ViewControllerOfSegmenttedController: UIViewController {

    var selectedSegment: SJSegmentTab?
    let segmentController = SJSegmentedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // navigationController?.navigationBar.isHidden = true
      
        tabBarController?.tabBar.isHidden = true
//        let tabBarItems = (tabBarController?.tabBar.items!)! as [UITabBarItem]
//        tabBarItems[0].title = nil
//        tabBarItems[0].imageInsets = UIEdgeInsetsMake(5,0,-5,0)
//        tabBarItems[1].title = nil
//        tabBarItems[1].imageInsets = UIEdgeInsetsMake(5,0,-5,0)
//        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.578044951, green: 0.571351707, blue: 0.5925549865, alpha: 1)
        
        
        if let storyboard = self.storyboard {
            setup()
            
            let firstViewController = storyboard.instantiateViewController(withIdentifier: "ListOfBooks")
            firstViewController.title = "Ертегілер"
            
            
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "AudioVC")
            secondViewController.title = "Аудио Ертегілер"
        
            segmentController.headerViewController = nil
            
            segmentController.segmentControllers = [firstViewController,
                                                    secondViewController]
           
            addChildViewController(segmentController)
            segmentController.view.center.y += 10
            segmentController.view.backgroundColor = #colorLiteral(red: 0.578044951, green: 0.571351707, blue: 0.5925549865, alpha: 1)
            self.view.addSubview(segmentController.view)
            segmentController.didMove(toParentViewController: self)
        }
        
    
    }
    
    func setup() {
        segmentController.delegate = self
        segmentController.selectedSegmentViewHeight = 2.0
        segmentController.selectedSegmentViewColor = #colorLiteral(red: 0.4843233228, green: 0.8361018896, blue: 0, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewControllerOfSegmenttedController: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        
        if segmentController.segments.count > 0 {
            selectedSegment = segmentController.segments[index]
            selectedSegment?.titleColor(#colorLiteral(red: 0.4843233228, green: 0.8361018896, blue: 0, alpha: 1))
        }
        
    }
}


