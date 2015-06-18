//
//  ViewController.swift
//  ActivityIndicator
//
//  Created by Admin on 18.06.15.
//  Copyright (c) 2015 dd.kostin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var activityIndicator : DUIActivityIndicatorView = {
        return DUIActivityIndicatorView()
        }()
    
    lazy var activityIndicator2 : DUIActivityIndicatorView = {
        return DUIActivityIndicatorView()
        }()
    
    lazy var activityIndicator3 : DUIActivityIndicatorView = {
        return DUIActivityIndicatorView()
        }()
    
    lazy var activityIndicator4 : DUIActivityIndicatorView = {
        return DUIActivityIndicatorView()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.frame = CGRect(x: 10.0, y: 30.0, width: 150.0, height: 150.0)
        activityIndicator.dotColor = UIColor.whiteColor()
        activityIndicator.dotSize = 30.0
        activityIndicator.dotsCount = 100
        activityIndicator.bgColor = UIColor.yellowColor()
        self.view.addSubview(activityIndicator)
        activityIndicator.initAnimationLayer()
        
        activityIndicator2.frame = CGRect(x: 170.0, y: 30.0, width: 50.0, height: 50.0)
        activityIndicator2.dotColor = UIColor.orangeColor()
        activityIndicator2.dotSize = 8.0
        activityIndicator2.dotsCount = 10
        activityIndicator2.bgColor = UIColor.clearColor()
        self.view.addSubview(activityIndicator2)
        activityIndicator2.initAnimationLayer()
        
        activityIndicator3.frame = CGRect(x: 10.0, y: 230.0, width: 50.0, height: 50.0)
        activityIndicator3.dotColor = UIColor.greenColor()
        activityIndicator3.dotSize = 15.0
        activityIndicator3.dotsCount = 3
        activityIndicator3.bgColor = UIColor.clearColor()
        self.view.addSubview(activityIndicator3)
        activityIndicator3.initAnimationLayer()
        
        activityIndicator4.frame = CGRect(x: 100.0, y: 230.0, width: 150.0, height: 30.0)
        activityIndicator4.dotColor = UIColor.yellowColor()
        activityIndicator4.dotSize = 3.0
        activityIndicator4.dotTopMargin = 5.0
        activityIndicator4.dotsCount = 50
        self.view.addSubview(activityIndicator4)
        activityIndicator4.initAnimationLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        activityIndicator.setupAnimationLayer()
        activityIndicator.startAnimating()
        
        activityIndicator2.setupAnimationLayer()
        activityIndicator2.startAnimating()
        
        activityIndicator3.setupAnimationLayer()
        activityIndicator3.startAnimating()
        
        activityIndicator4.setupAnimationLayer()
        activityIndicator4.startAnimating()
    }
}

