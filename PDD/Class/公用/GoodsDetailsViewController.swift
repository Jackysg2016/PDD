//
//  GoodsDetailsViewController.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品详情

import UIKit
import SwiftyJSON

class GoodsDetailsViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
        /// 是否是搜索页进来的，搜索页的商家id是在请求后得来的
    var isSearchGoInto:Bool!
    
    /// 商品id
    var goodsId:String!
    /// 商家id
    var mallId:String!
    let goodsRequest = GoodsDetailsrequest()
    let goodsDetailsModel = GoodsDetailsModel()

    var goodsJson:JSON!
    var mallJson:JSON!
    var reviewsJson:JSON!
    var recommendationJson:JSON!
    var lucky_drawJson:JSON!
    var collectionSection:Int?
    var basicDataArray = [basicInformation]()
    var basic = basicInformation()
    
    lazy var collectionView:UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-45),collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = BgColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerClass(PricesAndSalesCell.self, forCellWithReuseIdentifier: "PricesAndSalesCell")
        collectionView.registerClass(GoodsNameCell.self, forCellWithReuseIdentifier: "GoodsNameCell")
        collectionView.registerClass(GoodsDescCell.self, forCellWithReuseIdentifier: "GoodsDescCell")
        collectionView.registerClass(LotteryRulesCell.self, forCellWithReuseIdentifier: "LotteryRulesCell")
        collectionView.registerClass(ImportedGoodsCell.self, forCellWithReuseIdentifier: "ImportedGoodsCell")
        collectionView.registerClass(AllowedRegionCell.self, forCellWithReuseIdentifier: "AllowedRegionCell")
        collectionView.registerClass(GroupSpecificationCell.self, forCellWithReuseIdentifier: "GroupSpecificationCell")
        collectionView.registerClass(GroupBuyingCell.self, forCellWithReuseIdentifier: "GroupBuyingCell")
        collectionView.registerClass(GroupPurchaseCell.self, forCellWithReuseIdentifier: "GroupPurchaseCell")


        return collectionView
    }()
    
    
    lazy var bottomView:GoodsDetailsBottomView = {
        let bottomView = GoodsDetailsBottomView(frame:CGRectMake(0,ScreenHeight-45,ScreenWidth,45))
        bottomView.setclickblockClosure {
            print("团购")
        }
        bottomView.setaloneClickblockClosure {
            print("单独购买")
        }
        bottomView.setbuttonBlockClosure { (value) in
            switch value {
            case 1:
                print("首页")
            case 2:
                print("收藏")
            default:
                print("客服")
            }
        }
        return bottomView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bottomView)
        self.view.addSubview(collectionView)
        self.showHUD()
        request()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return basicDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var basic = basicInformation()
        basic = basicDataArray[indexPath.row]
        
        switch basic.cellType {
        case .pricesAndSales:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PricesAndSalesCell", forIndexPath: indexPath) as! PricesAndSalesCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
            
        case .goodsName:
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GoodsNameCell", forIndexPath: indexPath) as! GoodsNameCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
            
        case .goodsDesc:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GoodsDescCell", forIndexPath: indexPath) as! GoodsDescCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .lotteryRules:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LotteryRulesCell", forIndexPath: indexPath) as! LotteryRulesCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .importedGoods:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImportedGoodsCell", forIndexPath: indexPath) as! ImportedGoodsCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .allowedRegion:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AllowedRegionCell", forIndexPath: indexPath) as! AllowedRegionCell
            cell.backgroundColor = BgColor
            return cell
        case .groupSpecification:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupSpecificationCell", forIndexPath: indexPath) as! GroupSpecificationCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .groupBuying:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupBuyingCell", forIndexPath: indexPath) as! GroupBuyingCell
            cell.backgroundColor = BgColor
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupPurchaseCell", forIndexPath: indexPath) as! GroupPurchaseCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.reloadDataSouce(basic.groupPurchaseDetails!)
//            cell.basicDataSouce =  basic.groupPurchaseDetails
            return cell
        }
        
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
  
        var basic = basicInformation()
        basic = basicDataArray[indexPath.row]
        return CGSizeMake(ScreenWidth ,basic.cellHeight)
        
    }
    
    func request() {
        /**主要数据*/
        
        if isSearchGoInto == false {
            
            goodsRequest.goodsDetailsrequest(goodsId, successBlock: { (successJson) in
                self.goodsJson = successJson
                /**店铺信息*/
                self.goodsRequest.goodsDetailsmallRequest(self.mallId, successBlock: { (successJson) in
                    self.mallJson = successJson
                    
                    /**评价信息*/
                    self.goodsRequest.goodsDetailsReviewsRequest(self.goodsId, successBlock: { (successJson) in
                        self.reviewsJson = successJson
                        /**抽奖信息*/
                        self.goodsRequest.goodsDetailslucky_drawRequest(self.goodsId, successBlock: { (successJson) in
                            self.lucky_drawJson = successJson
                            /**可能喜欢*/
                            self.goodsRequest.goodsDetailsRecommendationRequest(self.goodsId, successBlock: { (successJson) in
                                
                                self.hideHUD()
                                self.recommendationJson = successJson
                                
                                self.processData(self.goodsJson, mallData: self.mallJson, reviewsData: self.reviewsJson, recommendationData: self.recommendationJson, lucky_drawData: self.lucky_drawJson)
                                
                            }) { (error) in
                                print(error)
                            }
                            
                        }) { (error) in
                            print(error)
                        }
                        
                    }) { (error) in
                        print(error)
                    }
                    
                }) { (error) in
                    print(error)
                }
                
            }) { (error) in
                print(error)
            }

        } else {
        
            
        
        }
        
    }
    
    /**处理数据*/
    func processData(goodsData:JSON,mallData:JSON,reviewsData:JSON,recommendationData:JSON,lucky_drawData:JSON) {
        
        //判断有多少区
        /**
         *  基本信息为一区，团购信息为一区，评价信息为一区，店铺信息为一区，图片信息为一区，推荐为一区
         */
        
        if goodsData["local_group"].count > 0 {
            
            /**
             *  可参加的团购
             */
        }
        
        if reviewsData["data"].count > 0 {
            
            /**
             *  有评价
             */
        }
        
       
        
       let pricesAndSales = basicInformation()
        pricesAndSales.basicDataSouce = goodsData
        pricesAndSales.cellType = .pricesAndSales
        pricesAndSales.cellHeight = 30
        basicDataArray.append(pricesAndSales)

       let  goodsName = basicInformation()
        goodsName.basicDataSouce = goodsData
        goodsName.cellType = .goodsName
        goodsName.cellHeight = String(goodsName.goodsName).stringHeightWith(15,width:(ScreenWidth-10))+5
        basicDataArray.append(goodsName)

        let goodsDesc = basicInformation()
        goodsDesc.basicDataSouce = goodsData
        goodsDesc.cellType = .goodsDesc
        goodsDesc.cellHeight = String(goodsDesc.goods_desc).stringHeightWith(15,width:(ScreenWidth-10))+5
        basicDataArray.append(goodsDesc)

        if goodsData["lucky_end_time"] != nil {///有抽奖
            let lotteryRules = basicInformation()
            lotteryRules.basicDataSouce = goodsData
            lotteryRules.cellType = .lotteryRules
            if ScreenWidth < 370 {
                lotteryRules.cellHeight = 120
            }else {
                lotteryRules.cellHeight = 100
            }
            basicDataArray.append(lotteryRules)
        }
        
        if String(goodsData["country"]) != "" && String(goodsData["warehouse"]) != "" {///有显示国外发货
            
           let importedGoods = basicInformation()
            importedGoods.cellType = .importedGoods
            importedGoods.cellHeight = 30
            self.basicDataArray.append(importedGoods)
        }
        
        let allowedRegion = basicInformation()
        allowedRegion.basicDataSouce = goodsData
        allowedRegion.cellType = .allowedRegion
        allowedRegion.cellHeight = 30
        basicDataArray.append(allowedRegion)

        let groupSpecification = basicInformation()
        groupSpecification.basicDataSouce = goodsData
        groupSpecification.cellType = .groupSpecification
        groupSpecification.cellHeight = 30
        basicDataArray.append(groupSpecification)
        
        if goodsData["local_group"].count > 0 {
            
            /**有正在团购的信息*/
             /// 参加团购
            let groupBuying = basicInformation()
            groupBuying.basicDataSouce = goodsData
            groupBuying.cellType = .groupBuying
            groupBuying.cellHeight = 30
            basicDataArray.append(groupBuying)
            
            for i in 0..<goodsData["local_group"].count {
                 /// 团购详情
                let groupPurchaseDetails = basicInformation()
                groupPurchaseDetails.cellType = .groupPurchaseDetails
                groupPurchaseDetails.cellHeight = 50
                groupPurchaseDetails.groupPurchaseDetails = String(goodsData["local_group"][i])
                basicDataArray.append(groupPurchaseDetails)
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        bottomView.basicDataSouce = goodsData
        collectionView.reloadData()
    }
}
