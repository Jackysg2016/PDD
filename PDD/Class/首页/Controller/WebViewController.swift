//
//  WebViewController.swift
//  PDD
//
//  Created by 周磊 on 16/4/18.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import pop

class WebViewController: UIViewController {

    var hamburerButton : AnimationButton!
    var top:UIView!
    var center:UIView!
    var bottom:UIView!
    
    var isTouch = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        let button = AnimationButton.init(type: UIButtonType.Custom)
        button.setImage(UIImage(named: "cancel_icon-1ae5cacdfb"), forState: UIControlState.Normal)
        button.frame = CGRectMake(100, 100, 30, 30)
//        button.addTarget(self, action: #selector(WebViewController.hah), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        
        
        
        hamburerButton = AnimationButton.init(frame: CGRectMake(100, 350, 150, 150))
        hamburerButton.backgroundColor = UIColor.blackColor()
        hamburerButton.layer.cornerRadius = 75
        hamburerButton.addTarget(self, action: #selector(WebViewController.hamburerButtonTouch), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(hamburerButton)
        
        top = UIView.init(frame: CGRectMake(self.hamburerButton.bounds.size.width/2 - 40, 40, 80, 11))
        top.backgroundColor = UIColor.whiteColor()
        top.userInteractionEnabled = false
        top.layer.cornerRadius = 11/2
        self.hamburerButton.addSubview(top)
        
        
        center = UIView.init(frame: CGRectMake(self.hamburerButton.bounds.size.width/2 - 40, 69, 80, 11))
        center.backgroundColor = UIColor.whiteColor()
        center.userInteractionEnabled = false
        center.layer.cornerRadius = 11/2
        self.hamburerButton.addSubview(center)
        
        bottom = UIView.init(frame: CGRectMake(self.hamburerButton.bounds.size.width/2 - 40, 99, 80, 11))
        bottom.backgroundColor = UIColor.whiteColor()
        bottom.userInteractionEnabled = false
        bottom.layer.cornerRadius = 11/2
        self.hamburerButton.addSubview(bottom)
        
        
    }
    func hamburerButtonTouch() {
        
        /// 颜色
        var topColor = self.top.pop_animationForKey("topColor") as? POPSpringAnimation
        var bottomColor = self.top.pop_animationForKey("bottomColor") as? POPSpringAnimation
        /**
         *  角度旋转
         */
        var topRotate = self.top.pop_animationForKey("topRotate") as? POPSpringAnimation
        var bottomRotate = self.top.pop_animationForKey("bottomRotate") as? POPSpringAnimation
        /// 位置
        var topPosition = self.top.pop_animationForKey("topPosition") as? POPSpringAnimation
        var bottomPosition = self.top.pop_animationForKey("bottomPosition") as? POPSpringAnimation
        
        
        if isTouch {
            isTouch = false
  
            UIView.animateWithDuration(0.2, animations: { 
                self.center.alpha = 0
            })
            
            if topColor != nil {
                topColor?.toValue = UIColor.redColor()
            }else {
                
                topColor = POPSpringAnimation.init(propertyNamed: kPOPViewBackgroundColor)
                topColor?.toValue = UIColor.redColor()
                topColor?.springBounciness = 0
                topColor?.springSpeed = 18
                top.pop_addAnimation(topColor, forKey: "topColor")
            }
            
            
            if bottomColor != nil {
                bottomColor?.toValue = UIColor.redColor()
            }else {
                
                bottomColor = POPSpringAnimation.init(propertyNamed: kPOPViewBackgroundColor)
                bottomColor?.toValue = UIColor.redColor()
                bottomColor?.springBounciness = 0
                bottomColor?.springSpeed = 18
                bottom.pop_addAnimation(bottomColor, forKey: "bottomColor")
            }
            
            
            if topRotate != nil {
                topRotate?.toValue = -M_PI/4
            }else {
                
                topRotate = POPSpringAnimation.init(propertyNamed: kPOPLayerRotation)
                topRotate?.toValue = -M_PI/4
                topRotate?.springBounciness = 11
                topRotate?.springSpeed = 18
                top.layer.pop_addAnimation(topRotate, forKey: "topRotate")
            }
            
            
            if bottomRotate != nil {
                bottomRotate?.toValue = M_PI/4
            }else {
                
                bottomRotate = POPSpringAnimation.init(propertyNamed: kPOPLayerRotation)
                bottomRotate?.toValue = M_PI/4
                bottomRotate?.springBounciness = 11
                bottomRotate?.springSpeed = 18
                bottom.layer.pop_addAnimation(bottomRotate, forKey: "bottomRotate")
            }
            
            
            if topPosition != nil {
                topPosition?.toValue = 29
            }else {
                
                topPosition = POPSpringAnimation.init(propertyNamed: kPOPLayerTranslationY)
                topPosition?.toValue = 29
                topPosition?.springBounciness = 11
                topPosition?.springSpeed = 18
                top.layer.pop_addAnimation(topPosition, forKey: "topPosition")
            }
           
            
            if bottomPosition != nil {
                bottomPosition?.toValue = -29
            }else {
                
                bottomPosition = POPSpringAnimation.init(propertyNamed: kPOPLayerTranslationY)
                bottomPosition?.toValue = -29
                bottomPosition?.springBounciness = 11
                bottomPosition?.springSpeed = 18
                bottom.layer.pop_addAnimation(bottomPosition, forKey: "bottomPosition")
            }
            
            
            
        }else {
            
            isTouch = true
            
            UIView.animateWithDuration(0.2, animations: {
                self.center.alpha = 1
            })
            
            if topColor != nil {
                topColor?.toValue = UIColor.whiteColor()
            }else {
                
                topColor = POPSpringAnimation.init(propertyNamed: kPOPViewBackgroundColor)
                topColor?.toValue = UIColor.whiteColor()
                topColor?.springBounciness = 0
                topColor?.springSpeed = 18
                top.pop_addAnimation(topColor, forKey: "topColor")
            }
            
            
            if bottomColor != nil {
                bottomColor?.toValue = UIColor.whiteColor()
            }else {
                
                bottomColor = POPSpringAnimation.init(propertyNamed: kPOPViewBackgroundColor)
                bottomColor?.toValue = UIColor.whiteColor()
                bottomColor?.springBounciness = 0
                bottomColor?.springSpeed = 18
                bottom.pop_addAnimation(bottomColor, forKey: "bottomColor")
            }
            
            
            if topRotate != nil {
                topRotate?.toValue = 0
            }else {
                
                topRotate = POPSpringAnimation.init(propertyNamed: kPOPLayerRotation)
                topRotate?.toValue = 0
                topRotate?.springBounciness = 11
                topRotate?.springSpeed = 18
                top.layer.pop_addAnimation(topRotate, forKey: "topRotate")
            }
            
            
            if bottomRotate != nil {
                bottomRotate?.toValue = 0
            }else {
                
                bottomRotate = POPSpringAnimation.init(propertyNamed: kPOPLayerRotation)
                bottomRotate?.toValue = 0
                bottomRotate?.springBounciness = 11
                bottomRotate?.springSpeed = 18
                bottom.layer.pop_addAnimation(bottomRotate, forKey: "bottomRotate")
            }
            
            
            if topPosition != nil {
                topPosition?.toValue = 0
            }else {
                
                topPosition = POPSpringAnimation.init(propertyNamed: kPOPLayerTranslationY)
                topPosition?.toValue = 0
                topPosition?.springBounciness = 11
                topPosition?.springSpeed = 18
                top.layer.pop_addAnimation(topPosition, forKey: "topPosition")
            }
            
            
            if bottomPosition != nil {
                bottomPosition?.toValue = -0
            }else {
                
                bottomPosition = POPSpringAnimation.init(propertyNamed: kPOPLayerTranslationY)
                bottomPosition?.toValue = 0
                bottomPosition?.springBounciness = 11
                bottomPosition?.springSpeed = 18
                bottom.layer.pop_addAnimation(bottomPosition, forKey: "bottomPosition")
            }
        }
    
    }
}
