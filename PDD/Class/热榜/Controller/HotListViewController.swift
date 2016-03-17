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
    var segmentedControl = HMSegmentedControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyanColor()
        self.title = "排行榜"
        arrayList = ["大家都在买","最新","猜你喜欢"]

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
        
    }
    
    func setMainScrollerView() {
        
        mainScrollView = UIScrollView(frame:CGRectMake(0, 64+45, ScreenWidth, ScreenHeight-64-45))
        mainScrollView!.contentSize = CGSizeMake((ScreenWidth * CGFloat(Float(arrayList.count))), ScreenHeight-64-45);
        mainScrollView!.pagingEnabled = true
        mainScrollView!.bounces = false
        mainScrollView!.showsHorizontalScrollIndicator = true
        mainScrollView!.directionalLockEnabled = true
        mainScrollView?.delegate = self
        mainScrollView!.contentOffset = CGPointMake(0, 0);
        self.view.addSubview(mainScrollView!)

    }
    
    func addViewControllers() {
        
        for var i = 0; i < arrayList.count; i++ {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.yellowColor()
            self.addChildViewController(vc)
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds)
        
        segmentedControl.selectedSegmentIndex =  Int(Float(index))

    }
    
    func addControllersWhenSlider(index:Int) {
        
        let vc = self.childViewControllers[index];
        vc.view.backgroundColor = UIColor.yellowColor()
        vc.view.frame = mainScrollView!.bounds;
        mainScrollView?.addSubview(vc.view)

    }

}
