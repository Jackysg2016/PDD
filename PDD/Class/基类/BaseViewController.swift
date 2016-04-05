//
//  BaseViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  基类控制器

import UIKit
import SnapKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var titleLabel = UILabel()

    var topButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureInterface()
    }
    /**右侧分享按钮*/
    private func configureInterface() {
        let rightBtn = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(BaseViewController.share))
        rightBtn.image = UIImage(named: "share")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    func share(){
        print("分享")
    }
    
    func top(){
        topButton = UIButton(frame:CGRectMake(ScreenWidth - 60, self.view.frame.size.height - 100, 40, 40))
        topButton.setImage(UIImage(named: "home_topBtn"), forState: UIControlState.Normal)
        topButton.alpha = 0;
        topButton.addTarget(self, action: #selector(BaseViewController.topButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(topButton)
    }
    
    func topButtonClick() {
        
       print(111)
    }
    
    
}
