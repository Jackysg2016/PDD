//
//  HaiTaoCountryTableViewCell.swift
//  PDD
//
//  Created by zhoulei on 16/3/20.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

typealias blockSubject_id = (HomeRollModel) -> Void   //定义闭包类型（特定的函数类型函数类型）

class HaiTaoCountryTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    var collectionView:UICollectionView?
    var countryArray = [HomeRollModel]()
    var backClosure:blockSubject_id?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(100,100)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, 100), collectionViewLayout: flowLayout)
        collectionView?.collectionViewLayout = flowLayout
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.registerClass(HaiTaoCountryCollectionViewCell.self, forCellWithReuseIdentifier: "HaiTaoCountryCollectionViewCell")
        self.contentView.addSubview(collectionView!)
        
    }
    
    
    func releaseData(country:[HomeRollModel]) {
        
        countryArray = country
        
        collectionView?.reloadData()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var country = HomeRollModel()
        country = countryArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HaiTaoCountryCollectionViewCell", forIndexPath: indexPath) as! HaiTaoCountryCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.releaseData(country)
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var country = HomeRollModel()
        country = countryArray[indexPath.row]
         self.backClosure!(country)
    }
    
    //闭包变量的Seter方法
    func setBackMyClosure(tempClosure:blockSubject_id) {
        
        self.backClosure = tempClosure
    }
    
}
