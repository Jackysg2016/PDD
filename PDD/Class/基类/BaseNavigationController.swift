//
//  BaseNavigationController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 返回按钮
    lazy var backBtn:UIButton = {
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.setImage(UIImage(named: "back"), forState: .Normal)
        backBtn.titleLabel?.hidden = true
        backBtn.addTarget(self, action: #selector(BaseNavigationController.back), forControlEvents: .TouchUpInside)
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        backBtn.frame = CGRectMake(0, 0, btnW, 40)
        return backBtn
    }()
    /// 分享按钮
    lazy var rightBtn:UIButton = {
        let rightBtn = UIButton(type: UIButtonType.Custom)
        rightBtn.setImage(UIImage(named: "share"), forState: .Normal)
        rightBtn.addTarget(self, action: #selector(BaseNavigationController.share), forControlEvents: .TouchUpInside)
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        rightBtn.frame = CGRectMake(0, 0, btnW, 40)
        return rightBtn
    }()
    
    /**重写push方法*/
    override func pushViewController(viewController: UIViewController, animated: Bool) {
//        viewController.navigationItem.hidesBackButton = true
        if childViewControllers.count > 0 {
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func back(){
        popViewControllerAnimated(true)
    }
    func share(){
        print("分享")
    }
}
