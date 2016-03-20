//
//  HotListViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HotListViewController: BaseViewController,UIScrollViewDelegate {
    
    var mainScrollView:UIScrollView?
    var arrayList = [String]()
    var parameterArray = [String]()
    var segmentedControl = HMSegmentedControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        arrayList = ["大家都在买","最新","猜你喜欢"]
        parameterArray = ["ranklist","newlist","randlist"]
        setTopScrollView()
        setMainScrollerView()
        addViewControllers()
        
    }

    func setTopScrollView() {
        
        segmentedControl = HMSegmentedControl(sectionTitles: arrayList)
        segmentedControl.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        segmentedControl.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        segmentedControl.frame = CGRectMake(0, 64, ScreenWidth, 45)
        /**设置滚动条的位置为下*/
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        /**设置滚动条高度*/
        segmentedControl.selectionIndicatorHeight = 2;
        /**设置未选中的字体大小和颜色*/
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(16)]
        /**设置选中的字体大小和颜色*/
        segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor.redColor(),NSFontAttributeName:UIFont.systemFontOfSize(16)]
        /**设置滚动条颜色*/
        segmentedControl.selectionIndicatorColor = UIColor.redColor()
        /**添加点击事件*/
        segmentedControl.addTarget(self, action: Selector("segmentedControlChangedValue:"), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segmentedControl)

    }
    
    func segmentedControlChangedValue(sender:HMSegmentedControl) {
        
        let segment:HMSegmentedControl = sender
        
        mainScrollView!.contentOffset = CGPointMake(CGFloat(Float(segment.selectedSegmentIndex))*ScreenWidth, 0);
        
        addControllersWhenSlider(segmentedControl.selectedSegmentIndex)
        
    }
    
    func setMainScrollerView() {
        
//        let headerView = UIView(frame:CGRectMake(0, 64+45, ScreenWidth, 5))
//        headerView.backgroundColor = BgColor
//        self.view.addSubview(headerView)

        mainScrollView = UIScrollView(frame:CGRectMake(0, 64+45, ScreenWidth, ScreenHeight-64-45))
        mainScrollView!.contentSize = CGSizeMake((ScreenWidth * CGFloat(Float(arrayList.count))), ScreenHeight-64-45);
        mainScrollView!.pagingEnabled = true
        mainScrollView!.bounces = false
        mainScrollView!.showsHorizontalScrollIndicator = true
        mainScrollView!.directionalLockEnabled = true
        mainScrollView?.delegate = self
        mainScrollView!.contentOffset = CGPointMake(0, 0)
        mainScrollView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(mainScrollView!)

    }
    
    func addViewControllers() {
        
        for var i = 0; i < arrayList.count; i++ {
            
            let rankingView = RankingTableViewController()
            
            rankingView.parameter = parameterArray[i]
            
            self.addChildViewController(rankingView)
        }
        /// 添加默认控制器
        let rankingVC:RankingTableViewController = (self.childViewControllers[0] as! RankingTableViewController)
        rankingVC.view.frame = mainScrollView!.bounds;
        mainScrollView!.addSubview(rankingVC.view)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds)
        
        segmentedControl.selectedSegmentIndex =  Int(Float(index))

        addControllersWhenSlider(segmentedControl.selectedSegmentIndex)
    }
    
    func addControllersWhenSlider(index:Int) {
        
        let rankingView:RankingTableViewController = (self.childViewControllers[index] as! RankingTableViewController)
        rankingView.view.frame = mainScrollView!.bounds
        mainScrollView?.addSubview(rankingView.view)
        
    }

}
