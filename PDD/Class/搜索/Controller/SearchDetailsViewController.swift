//
//  SearchDetailsViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/30.
//  Copyright © 2016年 ZL. All rights reserved.
//  搜索详情页

import UIKit

class SearchDetailsViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate,searchDetailsRequestDelegate {
///搜索id
    var goodsId:String!
///判断是否是大标题
    var opt_type:String!
    
    var request:SearchDetailsRequest?
    var collectionView:UICollectionView?

    var mainDataArray = [SearchDetailsGoods_listModel]()
    var titleDataArray = [SearchDetailsOpt_infosModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BgColor

        setUpConnectionView()
        
        setUpRequest()
        
    }
    
    func setUpRequest() {
        
        request = SearchDetailsRequest()
        request!.delegate = self
        self.showHUD()
        request!.searchDetailsRequest(goodsId,optType: opt_type)
        
    }
    
    func searchDetailsRequest(goods_listArray:[SearchDetailsGoods_listModel],opt_infosArray:[SearchDetailsOpt_infosModel]) {
         self.hideHUD()
        mainDataArray = goods_listArray
        titleDataArray = opt_infosArray
        collectionView?.reloadData()
        
    }
    
    
    func setUpConnectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-45),collectionViewLayout: flowLayout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = BgColor
        collectionView?.registerClass(SearchDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "SearchDetailsCollectionViewCell")
        self.view.addSubview(collectionView!)
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainDataArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var searchDetailsModel = SearchDetailsGoods_listModel()
        searchDetailsModel =  mainDataArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SearchDetailsCollectionViewCell", forIndexPath: indexPath) as! SearchDetailsCollectionViewCell
        cell.datsSouce = searchDetailsModel
        return cell
    }
    ///定义每个UICollectionViewCell 的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
            return CGSizeMake((ScreenWidth-30)/2 ,230)
    }
    
    ///定义每个cell 的 margin
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets  {
        return UIEdgeInsetsMake(10, 10, 0, 10);//分别为上、左、下、右
    }
    
}


