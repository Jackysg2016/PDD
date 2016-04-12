//
//  BaseViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  基类控制器

import UIKit
import SnapKit
import ReachabilitySwift


class BaseViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var titleLabel = UILabel()

    var topButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        /**监测有无网络 */
        httpReachability()
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
    
    func top(scroller:UIScrollView){
        
        topButton = UIButton(frame:CGRectMake(ScreenWidth - 60, self.view.frame.size.height - 100, 40, 40))
        topButton.setImage(UIImage(named: "home_topBtn"), forState: UIControlState.Normal)
        topButton.alpha = 0;
        topButton.addTarget(self, action: #selector(BaseViewController.topButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(topButton)
    }
    
    func topButtonClick() {
        
       print(111)
    }
// MARK: - 监测有无网络
    func httpReachability() {
        
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            return
        }
        
        /**判断连接状态*/
        if reachability.isReachable() {
            
            /**网络连接可用*/

        }else {
            
            self.showErrorAllTextDialog("当前网络没有链接")
        }
        
//        //判断连接类型
//        if reachability.isReachableViaWiFi() {
//            self.showStatusHub("WiFi")
//        }else if reachability.isReachableViaWWAN() {
//            self.showStatusHub("移动网络")
//        }else {
//            self.showStatusHub("没有网络连接")
//
//        }
    }
}
