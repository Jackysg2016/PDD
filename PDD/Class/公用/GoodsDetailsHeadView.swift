//
//  GoodsDetailsHeadView.swift
//  PDD
//
//  Created by 周磊 on 16/4/13.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class GoodsDetailsHeadView: UICollectionReusableView,UIScrollViewDelegate{
    
    weak var delegate:GoodsDetailsHeadDelegate?

    var scrollView:UIScrollView?
    var pageControl:UIPageControl?
    var timer:NSTimer?
    var imageDataArray:[imagesInformation]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView()
        scrollView?.scrollsToTop = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.pagingEnabled = true
        scrollView?.delegate = self
        self.addSubview(scrollView!)
        scrollView?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.bottom.equalTo(self).offset(0)
        })
        
        pageControl = UIPageControl()
        pageControl?.userInteractionEnabled = false
        pageControl?.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl?.currentPageIndicatorTintColor = UIColor.redColor()
        self.addSubview(pageControl!)
        pageControl?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self).offset(200)
            make.centerX.equalTo(self.snp_centerX).offset(0)
        })
        
        let tapGestureRecognize = UITapGestureRecognizer(target: self, action: #selector(GoodsDetailsHeadView.singleTapGestureRecognizer))
        tapGestureRecognize.numberOfTapsRequired = 1;
        scrollView?.addGestureRecognizer(tapGestureRecognize)
        
        
    }
    
    func singleTapGestureRecognizer() {
        let page = (Int)(scrollView!.contentOffset.x / scrollView!.frame.size.width)
        self.delegate?.GoodsDetailsHeadRequestResult(page)
    }
    
    
    func addTimer(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(GoodsDetailsHeadView.nextImage(_:)), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)

    }
    
    func removeTimer(){
        timer!.invalidate()
        timer = nil
    }
    
    
    func nextImage(sender:AnyObject!){
        
        var page:Int = pageControl!.currentPage
        if(page == imageDataArray.count-1){
            page = 0
        }else{
            page += 1
        }
        let x:CGFloat = CGFloat(page) * scrollView!.frame.size.width
        scrollView!.contentOffset = CGPointMake(x, 0)
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollviewW:CGFloat = scrollView.frame.size.width
        let x:CGFloat = scrollView.contentOffset.x
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW)
        pageControl!.currentPage = page
    }
    
    func reloadData(daArray:[imagesInformation]){
        
        addTimer()
        imageDataArray = daArray
        
        for i in 0 ..< imageDataArray.count {
            
            let homeData = imageDataArray[i]
            
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i) * scrollView!.frame.size.width, 0, scrollView!.frame.size.width, scrollView!.frame.size.height))
            
            imageView.pdd_setImageWithURL(NSURL(string: homeData.url!)!, placeholderImage: UIImage(named: "homeWu.png")!)
            
            imageView.userInteractionEnabled = true
            
            scrollView?.addSubview(imageView)
        }
        
        scrollView?.contentSize = CGSizeMake(scrollView!.frame.size.width * CGFloat(imageDataArray.count), scrollView!.frame.size.height)
        scrollView?.contentOffset = CGPointMake(0, 0)
        
        pageControl?.numberOfPages = imageDataArray.count
        pageControl!.currentPage = 0;
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        removeTimer()
    }
    //当用户停止的时候调用
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        addTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
protocol GoodsDetailsHeadDelegate: NSObjectProtocol {
    
    func GoodsDetailsHeadRequestResult(page:Int)
    
}
