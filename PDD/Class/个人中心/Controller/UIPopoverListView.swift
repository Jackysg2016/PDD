//
//  UIPopoverListView.swift
//  PDD
//
//  Created by 周磊 on 16/4/19.
//  Copyright © 2016年 ZL. All rights reserved.
//  自定义弹窗

import UIKit
import QuartzCore
import pop

class UIPopoverListView: UIView,UITableViewDelegate,UITableViewDataSource {

    var listView:UITableView!
    var titleView:UILabel!
    var overlayView:UIControl!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        defalutInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func defalutInit() {
        
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        titleView = UILabel()
        titleView.font = UIFont.systemFontOfSize(15)
        titleView.textColor = UIColor.whiteColor()
        titleView.backgroundColor = UIColor.cyanColor()
        titleView.textAlignment = NSTextAlignment.Center
        titleView.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.addSubview(titleView)
        titleView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self).offset(0)
            make.height.equalTo(40)
        }
        
        listView = UITableView()
        listView.dataSource = self
        listView.delegate = self
        self.addSubview(listView)
        listView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(40)
            make.bottom.equalTo(self).offset(-40)
        }

        overlayView = UIControl.init(frame: CGRectMake(0, 64, ScreenWidth
            , ScreenHeight))
        overlayView.backgroundColor = UIColor.init(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.5)
        overlayView.addTarget(self, action: #selector(UIPopoverListView.dismiss), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func dismiss() {
        
        dis()
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "hehe"
        
        var  cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        
        if cell == nil {
            
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = "\(indexPath.row)"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dis()
    }
    
    
    func show() {
        
        let keyWindow = UIApplication.sharedApplication().keyWindow
        
        keyWindow?.addSubview(overlayView)
        keyWindow?.addSubview(self)
        
//        self.center = CGPointMake((keyWindow?.bounds.size.width)!/2, (keyWindow?.bounds.size.height)!/2+100)
        
//        self.frame = CGRectMake(0, ScreenHeight-200+45, ScreenWidth, 200)
        self.center = (keyWindow?.center)!
        fadeIn()
    }
    
    func dis() {
        
        fadeOut()
        
    }
    
    
    func fadeIn() {
        
      self.transform = CGAffineTransformMakeTranslation(0, -200)
        self.alpha = 0
        
        var translation = self.pop_animationForKey("translation") as? POPSpringAnimation
        
        if translation != nil {
            
            translation?.toValue = NSValue(CGPoint: CGPointMake(0, 0))
        }else {
            
            translation = POPSpringAnimation.init(propertyNamed: kPOPLayerTranslationXY)
            translation?.toValue = NSValue(CGPoint: CGPointMake(0, 0))
            translation?.springBounciness = 18
            translation?.springSpeed = 12
            self.layer.pop_addAnimation(translation, forKey: "translation")

        }
        
        
        var alpha = self.pop_animationForKey("alpha") as? POPSpringAnimation
        
        if alpha != nil {
            
            alpha?.toValue = 1
        }else {
            
            alpha = POPSpringAnimation.init(propertyNamed: kPOPViewAlpha)
            alpha?.toValue = 1
            alpha?.springBounciness = 18
            alpha?.springSpeed = 12
            self.pop_addAnimation(alpha, forKey: "alpha")
            
        }
        
        
        
        
//        
//        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
//            self.alpha = 1
//            self.transform = CGAffineTransformMakeTranslation(0, 0)
//            
//            }, completion: nil)
//        
//        

    }
    
    func fadeOut() {
        
        UIView.animateWithDuration(0.35) {
            
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
        
        
//        UIView.animateWithDuration(0.25, animations: {
//            
//            self.transform = CGAffineTransformMakeTranslation(0, ScreenHeight+20)
//            self.alpha = 0.0
//            
//            }) { (finished) in
//                
//                if (finished) {
//                    self.overlayView.removeFromSuperview()
//                    self.removeFromSuperview()
//                }
//        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dis()
    }
}
