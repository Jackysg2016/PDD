//
//  SearchDetailsScrollerViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/31.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SearchDetailsScrollerViewController: BaseViewController,UIScrollViewDelegate {
    
    ///搜索id
    var goodsId:String!
    ///判断是否是大标题
    var opt_type:String!

    var listArray:NSArray?
    
    var opt_nameArray = [String]()
    var opt_idArray = [String]()
    
    var mainScrollView:UIScrollView?
    var segmentedControl = HMSegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disposeListArray()
        setTopScrollView()
        setMainScrollerView()
        addViewControllers()
        
    }

    func disposeListArray() {
        
        for i in 0 ..< listArray!.count {
            
            var childrenEntity = childrenModel()
            childrenEntity.mapping(listArray![i] as! Dictionary<String, AnyObject>)
            opt_nameArray.append(childrenEntity.opt_name!)
            opt_idArray.append(childrenEntity.id!)
        }
        opt_nameArray.insert("全部", atIndex: 0)
        opt_idArray.insert(goodsId, atIndex: 0)
        
    }
    
    
    func setTopScrollView() {
        
        segmentedControl = HMSegmentedControl(sectionTitles: opt_nameArray)
        segmentedControl.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        segmentedControl.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        segmentedControl.frame = CGRectMake(0, 64, ScreenWidth, 45)
        segmentedControl.segmentEdgeInset  = UIEdgeInsetsMake(0, 15, 0, 15)
        ///指定段的宽度的风格
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic
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
        segmentedControl.addTarget(self, action: #selector(HotListViewController.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segmentedControl)
        
    }
    
    func segmentedControlChangedValue(sender:HMSegmentedControl) {
        
        let segment:HMSegmentedControl = sender
        
        mainScrollView!.contentOffset = CGPointMake(CGFloat(Float(segment.selectedSegmentIndex))*ScreenWidth, 0);
        
        addControllersWhenSlider(segmentedControl.selectedSegmentIndex)
        
    }
    
    func setMainScrollerView() {
        
        mainScrollView = UIScrollView(frame:CGRectMake(0, 64+45, ScreenWidth, ScreenHeight-64-45))
        mainScrollView!.contentSize = CGSizeMake((ScreenWidth * CGFloat(Float(opt_nameArray.count))), ScreenHeight-64-45);
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
        
        for i in 0 ..< opt_idArray.count {
            
            let rankingView = SearchDetailsViewController()
            rankingView.navigationController?.navigationBarHidden = true
            rankingView.goodsId = opt_idArray[i]
            if i==0 {
                rankingView.opt_type = "1"
            }else {
                rankingView.opt_type = "2"
            }
            self.addChildViewController(rankingView)
        }
        
        /// 添加默认控制器
        let rankingVC:SearchDetailsViewController = (self.childViewControllers[0] as! SearchDetailsViewController)
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
        
        let rankingView:SearchDetailsViewController = (self.childViewControllers[index] as! SearchDetailsViewController)
        rankingView.view.frame = mainScrollView!.bounds
        mainScrollView?.addSubview(rankingView.view)
        
    }

}
