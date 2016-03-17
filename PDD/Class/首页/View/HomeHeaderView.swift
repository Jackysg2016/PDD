//
//  HomeHeaderView.swift
//  PDD
//
//  Created by 周磊 on 16/3/16.
//  Copyright © 2016年 ZL. All rights reserved.
//  滚动广告视图

import UIKit

class HomeHeaderView: UIView,UIScrollViewDelegate {

    weak var delegate:HomeHeaderDelegate?
    
    var homeRollDataArray = [HomeRollModel]()
    var scrollView:UIScrollView?
    var pageControl:UIPageControl?
    var timer:NSTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BgColor
        setUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setUI(){
        
        scrollView = UIScrollView()
        scrollView?.scrollsToTop = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.pagingEnabled = true
        scrollView?.delegate = self
        self.addSubview(scrollView!)
        scrollView?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.equalTo(self).offset(0)
            make.height.equalTo(200)
        })
        
        pageControl = UIPageControl()
        pageControl?.userInteractionEnabled = false
        pageControl?.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl?.currentPageIndicatorTintColor = UIColor.redColor()
        self.addSubview(pageControl!)
        pageControl?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self).offset(170)
            make.centerX.equalTo(self.snp_centerX).offset(0)
        })
        
        let tapGestureRecognize = UITapGestureRecognizer(target: self, action: "singleTapGestureRecognizer")
        tapGestureRecognize.numberOfTapsRequired = 1;
        scrollView?.addGestureRecognizer(tapGestureRecognize)
        
    }
    
    
    func addTimer(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "nextImage:", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
    }
    
    func removeTimer(){
        self.timer!.invalidate()
    }
    
    func nextImage(sender:AnyObject!){
        
        var page:Int = pageControl!.currentPage
        if(page == homeRollDataArray.count-1){
            page = 0
        }else{
            ++page
        }
        let x:CGFloat = CGFloat(page) * scrollView!.frame.size.width
        scrollView!.contentOffset = CGPointMake(x, 0)
        
    }
    
    func reloadData(daArray:NSArray){
        
        homeRollDataArray = daArray as! [HomeRollModel]
        addTimer()
        
        for var i=0;i<homeRollDataArray.count;i++ {
            
            let homeData = homeRollDataArray[i]
            
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i) * scrollView!.frame.size.width, 0, scrollView!.frame.size.width, scrollView!.frame.size.height))
            
            imageView.wxn_setImageWithURL(NSURL(string: homeData.home_banner!)!, placeholderImage: UIImage(named: "homeWu.png")!)
            
            imageView.userInteractionEnabled = true

            scrollView?.addSubview(imageView)
        }
        
        scrollView?.contentSize = CGSizeMake(scrollView!.frame.size.width * CGFloat(homeRollDataArray.count), scrollView!.frame.size.height)
        scrollView?.contentOffset = CGPointMake(0, 0)
        
        pageControl?.numberOfPages = homeRollDataArray.count
        pageControl!.currentPage = 0;
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollviewW:CGFloat = scrollView.frame.size.width
        let x:CGFloat = scrollView.contentOffset.x
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW)
        pageControl!.currentPage = page
    }
    
//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//
//        removeTimer()
//    }
//    
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        addTimer()
//    }

    
    func singleTapGestureRecognizer() {
        let page = (Int)(scrollView!.contentOffset.x / scrollView!.frame.size.width)
        let homeRoll = homeRollDataArray[page]
        self.delegate?.homeHeaderRequestResult(homeRoll)
    }
    
}

protocol HomeHeaderDelegate: NSObjectProtocol {
    
    func homeHeaderRequestResult(homeRollData:HomeRollModel)
    
}
