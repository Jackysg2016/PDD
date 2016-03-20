
//
//  HomeAdTableViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/3/17.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页中间插播的广告cell样式

import UIKit

class HomeAdTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    weak var delegate:ClickCollectionCallbackDelegate?

    var bgView:UIView?
    var titleName:UILabel?
    var moreLabel:UILabel?
    var arrowsImageView:UIImageView?
    var collectionView:UICollectionView?
    var dataSouce = [home_recommend_goodlistModel]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = BorderColor.CGColor
        self.contentView.addSubview(bgView!)
        bgView?.snp_makeConstraints(closure: { (make) -> Void in
            
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(20)
            make.bottom.equalTo(self).offset(0)
        })
        
        titleName = UILabel()
        titleName?.numberOfLines = 0
        titleName?.font = UIFont.systemFontOfSize(15)
        titleName?.textColor = UIColor.blackColor()
        bgView?.addSubview(titleName!)
        titleName?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(bgView!).offset(10)
            make.top.equalTo(bgView!).offset(10)
        })
        
        arrowsImageView = UIImageView()
        arrowsImageView?.image = UIImage(named: "forwardWeixinAddress-11b7e073ce")
        bgView?.addSubview(arrowsImageView!)
        arrowsImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(bgView!).offset(-5)
            make.width.height.equalTo(15)
            make.top.equalTo(bgView!).offset(10)
        })

        moreLabel = UILabel()
        moreLabel?.textColor = UIColor.grayColor()
        moreLabel?.text = "查看更多"
        moreLabel?.font = UIFont.systemFontOfSize(13)
        bgView?.addSubview(moreLabel!)
        moreLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(bgView!).offset(10)
            make.right.equalTo(arrowsImageView!.snp_left).offset(-2)
            
        })

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(150,220)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        
        collectionView = UICollectionView(frame: CGRectMake(10, 40, ScreenWidth-40, 220), collectionViewLayout: flowLayout)
        collectionView?.collectionViewLayout = flowLayout
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false

        collectionView?.registerClass(HomeAdCollectionViewCell.self, forCellWithReuseIdentifier: "HomeAdCollectionViewCell")
        bgView?.addSubview(collectionView!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func releaseHomeAdData(homeData:home_recommend_subjectsModel,homeRecommend:[home_recommend_goodlistModel]){
        
        titleName?.text = homeData.subject
        dataSouce = homeRecommend
        collectionView?.reloadData()
    }

    func releaseHaiTaoAdData(homeData:home_recommend_subjectsModel,homeRecommend:[home_recommend_goodlistModel]){
        
        titleName?.text = homeData.subject
        dataSouce = homeRecommend
        collectionView?.reloadData()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let homeRecommend = dataSouce[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeAdCollectionViewCell", forIndexPath: indexPath) as! HomeAdCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.releaseData(homeRecommend)
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let homeRecommend = dataSouce[indexPath.row] 
        self.delegate?.requestResult(homeRecommend)
    }
}

protocol ClickCollectionCallbackDelegate: NSObjectProtocol {
    
    func requestResult(home_recommend_goodlist:home_recommend_goodlistModel)
    
}

