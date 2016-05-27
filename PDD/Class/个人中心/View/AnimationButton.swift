//
//  AnimationButton.swift
//  PDD
//
//  Created by 周磊 on 16/4/22.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import pop

class AnimationButton: UIButton {

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        //缩放
        var scale = self.pop_animationForKey("scale") as? POPSpringAnimation
        if scale != nil {
            scale!.toValue = NSValue(CGPoint:CGPointMake(0.8, 0.8))
        }else {
            
            scale = POPSpringAnimation.init(propertyNamed: kPOPViewScaleXY)
            scale?.toValue = NSValue(CGPoint: CGPointMake(0.8, 0.8))
            scale?.springBounciness = 20
            scale?.springSpeed = 18
            self.pop_addAnimation(scale, forKey: "scale")
        }
        //旋转
        var rotate = self.layer.pop_animationForKey("rotate") as? POPSpringAnimation
        if rotate != nil {
            rotate?.toValue = M_PI/6
        }else {
            
            rotate = POPSpringAnimation.init(propertyNamed: kPOPLayerRotation)
            rotate!.toValue = M_PI/6
            rotate?.springBounciness = 20
            rotate?.springSpeed = 18
            self.layer.pop_addAnimation(rotate, forKey: "rotate")

        }
    }

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        //缩放
        var scale = self.pop_animationForKey("scale") as? POPSpringAnimation
        if scale != nil {
            scale!.toValue = NSValue(CGPoint:CGPointMake(1, 1))
        }else {
            
            scale = POPSpringAnimation.init(propertyNamed: kPOPViewScaleXY)
            scale?.toValue = NSValue(CGPoint: CGPointMake(1, 1))
            scale?.springBounciness = 20
            scale?.springSpeed = 18
            self.pop_addAnimation(scale, forKey: "scale")
        }
        //旋转
        var rotate = self.layer.pop_animationForKey("rotate") as? POPSpringAnimation
        if rotate != nil {
            rotate?.toValue = 0
        }else {
            
            rotate = POPSpringAnimation.init(propertyNamed: kPOPLayerRotation)
            rotate!.toValue = 0
            rotate?.springBounciness = 20
            rotate?.springSpeed = 18
            self.layer.pop_addAnimation(rotate, forKey: "rotate")
            
        }
        
    }
    
}
