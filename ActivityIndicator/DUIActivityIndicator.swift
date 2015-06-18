//
//  DUIActivityIndicator.swift
//  ActivityIndicator
//
//  Created by dan-leech on 18.06.15.
//  Copyright (c) 2015 Daniil Kostin. All rights reserved.
//

import UIKit
import QuartzCore

// MARK: Helpers

func DegreesToRadians (value: Double) -> Double {
    return value * M_PI / 180.0
}

// MARK: Activity Indicator View

@IBDesignable
class DUIActivityIndicatorView: UIView {
    // MARK: Variables
    
    @IBInspectable var hidesWhenStopped : Bool = true {
        didSet {
            if self.hidesWhenStopped {
                self.hidden = !self.animating
            } else {
                self.hidden = false
            }
        }
    }
    
    @IBInspectable var dotsCount: Int = 20 { didSet { setupAnimationLayer() } }
    
    @IBInspectable var dotSize: CGFloat = 14.0  { didSet { setupAnimationLayer() } }
    
    @IBInspectable var dotTopMargin: CGFloat = 0.0  { didSet { setupAnimationLayer() } }
    
    @IBInspectable var dotColor: UIColor? = UIColor.whiteColor() { didSet { animationElementLayer.backgroundColor = dotColor!.CGColor } }
    
    @IBInspectable var bgColor: UIColor? = UIColor(white: 0.0, alpha: 0.75) { didSet { animationLayer.backgroundColor = bgColor!.CGColor } }
    
    
    
    @IBInspectable var duration: CGFloat = 1.5  {
        didSet {
            shrinkAnimation.duration = CFTimeInterval(duration)
            animationLayer.instanceDelay = CFTimeInterval(duration)/Double(dotsCount)
        }
    }

    
    // MARK: private Variables

    private let debug = true;
    
    lazy private var animationLayer : CAReplicatorLayer = {
        return CAReplicatorLayer()
        }()
    
    lazy private var animationElementLayer : CALayer = {
        return CALayer()
        }()
    
    private var animating = false
    
    private var angle:CGFloat = 0.0
    
    lazy private var shrinkAnimation: CABasicAnimation = {
        return CABasicAnimation(keyPath: "transform.scale")
        }()
    
    lazy private var opacityAnimation: CABasicAnimation = {
        return CABasicAnimation(keyPath: "opacity")
        }()
    
    private var layoutOnceToken: dispatch_once_t = 0
    
    // MARK: functions
    
    func startAnimating () {
        
        func animate () {
            self.animating = true
            self.hidden = false
            
            animationElementLayer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
            addShrinkAnimation()
            addOpacityAnimation()
        }
        
        if !self.animating {
            animate()
        }
    }
    
    func stopAnimating () {
        self.animating = false
        
        animationElementLayer.removeAllAnimations()
        
        if self.hidesWhenStopped {
            self.hidden = true
        }
    }
    
    func isAnimating () -> Bool {
        return self.animating
    }
    
    // MARK: Init & Deinit
    
    func initAnimationLayer() {
        self.layer.addSublayer(animationLayer)
        animationLayer.addSublayer(animationElementLayer)
        
        self.hidden = true
    }
    
    func setupAnimationLayer() {
        animationLayer.bounds = CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: self.bounds.size.height)
        animationLayer.cornerRadius = 10.0
        animationLayer.backgroundColor = bgColor?.CGColor
        animationLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        
        animationElementLayer.bounds = CGRect(x: 0.0, y: 0.0, width: dotSize, height: dotSize)
        animationElementLayer.position = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height - dotSize - dotTopMargin)
        animationElementLayer.backgroundColor = dotColor!.CGColor
        //animationElementLayer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        //animationElementLayer.borderWidth = 1.0
        animationElementLayer.cornerRadius = dotSize / 2
      
        animationLayer.instanceCount = dotsCount
        
        angle = CGFloat(2*M_PI) / CGFloat(dotsCount)
        
        animationLayer.instanceDelay = CFTimeInterval(duration)/Double(dotsCount)
        animationLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    }
    
    func addShrinkAnimation() {
        shrinkAnimation.fromValue = 1.0
        shrinkAnimation.toValue = 0.0
        shrinkAnimation.duration = CFTimeInterval(duration)
        shrinkAnimation.repeatCount = Float.infinity
        //shrinkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        animationElementLayer.addAnimation(shrinkAnimation, forKey: "shrinkAnimation")
    }
    
    func addOpacityAnimation() {
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.duration = CFTimeInterval(duration)
        opacityAnimation.repeatCount = Float.infinity
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        animationElementLayer.addAnimation(opacityAnimation, forKey: "opacityAnimation")
    }
    
    override init(frame: CGRect) { // run from interface builder and controller
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        initAnimationLayer()
        setupAnimationLayer()
    }
    
    required init(coder aDecoder: NSCoder) { // run in runtime, when added to view in interface builder
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clearColor()
        
        initAnimationLayer()
        startAnimating()
    }
    
    override func awakeFromNib() {
        //setupAnimationLayer() // do it in viewdidapear, self.bounds not correct at this time
    }
    
    override func prepareForInterfaceBuilder() {
        setupAnimationLayer()
        updateConstraints()
    }

    
    override func updateConstraints() {
        dispatch_once(&layoutOnceToken, {
            // one time only layout code
        })
        super.updateConstraints()
        // adjust layout here
    }
}
