//
//  SearchDetailsScrollerViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/31.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

///判断是否是大标题
enum goodsOpt_Type:Int{
    case firstType = 1
    case secondType = 2
}

class SearchDetailsScrollerViewController: BaseViewController,UIScrollViewDelegate {
    
    var optType:goodsOpt_Type = goodsOpt_Type.firstType
    var request:SearchDetailsRequest?
    
    var opt_infosArray = [SearchDetailsOpt_infosModel]()

    ///搜索id
    var goodsId:String!

    var listArray:NSArray?
    
    var opt_nameArray = [String]()
    var opt_idArray = [String]()
    var optinfos = [String]()
    
    var mainScrollView:UIScrollView?
    var segmentedControl = HMSegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        addViewControllers()
    }
    
    func addViewControllewView()  {
        /// 添加默认控制器
        let rankingVC:SearchDetailsViewController = (self.childViewControllers[0] as! SearchDetailsViewController)
        rankingVC.view.frame = mainScrollView!.bounds;
        mainScrollView!.addSubview(rankingVC.view)

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
    
    func setTopScrollView(namearray:NSArray) {
        
        segmentedControl = HMSegmentedControl(sectionTitles: namearray as [AnyObject])
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
    
    func setMainScrollerView(namearray:NSArray) {
        
        mainScrollView = UIScrollView(frame:CGRectMake(0, 64+45, ScreenWidth, ScreenHeight-64-45))
        mainScrollView!.contentSize = CGSizeMake((ScreenWidth * CGFloat(Float(namearray.count))), ScreenHeight-64-45);
        mainScrollView!.pagingEnabled = true
        mainScrollView!.bounces = false
        mainScrollView!.showsHorizontalScrollIndicator = false
        mainScrollView!.directionalLockEnabled = true
        mainScrollView?.delegate = self
        mainScrollView!.contentOffset = CGPointMake(0, 0)
        mainScrollView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(mainScrollView!)
    }
    
    func addViewControllers() {
        
            switch optType {
            case .firstType:
                
                disposeListArray()
                
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
                setTopScrollView(opt_nameArray)
                setMainScrollerView(opt_nameArray)
                addViewControllewView()
                
            default:
                
               let request = SearchDetailsRequest()
               request.getUpOpt_infosDataArray(goodsId, optType: "2", completion: { (namedataAray, iddataArray) in
                self.optinfos = namedataAray!
                for i in 0 ..< namedataAray!.count {
                    
                    let rankingView = SearchDetailsViewController()
                    rankingView.navigationController?.navigationBarHidden = true
                    rankingView.goodsId = iddataArray![i]
                    
                    if i==0 {
                        rankingView.opt_type = "2"
                    }else {
                        rankingView.opt_type = "3"
                    }
                    self.addChildViewController(rankingView)
                }
                self.setTopScrollView(self.optinfos)
                self.setMainScrollerView(self.optinfos)
                self.addViewControllewView()
            })
                
        }
        
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

