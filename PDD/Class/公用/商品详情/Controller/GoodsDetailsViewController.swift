//
//  GoodsDetailsViewController.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品详情

import UIKit
import SwiftyJSON
import SKPhotoBrowser

class GoodsDetailsViewController: BaseViewController {
    
        /// 是否是搜索页进来的，搜索页的商家id是在请求后得来的
    var isSearchGoInto:Bool!
    
    /// 判断是不是从店铺信息界面跳转进来的，如果是从店铺信息页跳转进来的，再次点击店铺信息的时候要返回上一层
    var isStoreInformationGoInto:Bool!
    
    
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
    
    var scrollerImageArray = [imagesInformation]()
    var imageArray = [imagesInformation]()
    
    var headView = GoodsDetailsHeadView()
    
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
            case 1:///首页
                self.navigationController?.popToRootViewControllerAnimated(true)
            case 2:
                print("收藏")
            default:
                print("客服")
            }
        }
        return bottomView
    }()

    
    lazy var collectionView:UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-45),collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
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
        collectionView.registerClass(EvaluateCell.self, forCellWithReuseIdentifier: "EvaluateCell")
        collectionView.registerClass(EvaluateParticularsCell.self, forCellWithReuseIdentifier: "EvaluateParticularsCell")
        collectionView.registerClass(StoreCell.self, forCellWithReuseIdentifier: "StoreCell")
        collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.registerClass(GoodsDetailsHeadView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "GoodsDetailsHeadView")
        collectionView.registerClass(MayLoveCell.self, forCellWithReuseIdentifier: "MayLoveCell")
        collectionView.registerClass(RecommendedGoodsCell.self, forCellWithReuseIdentifier: "RecommendedGoodsCell")
        collectionView.registerClass(BottomCell.self, forCellWithReuseIdentifier: "BottomCell")

        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        self.showHUD()
        request()
        
    }
    
    func request() {
        /**主要数据*/
        
            goodsRequest.goodsDetailsrequest(goodsId, successBlock: { (successJson) in
                self.goodsJson = successJson
                /**评价信息*/
                    self.goodsRequest.goodsDetailsReviewsRequest(self.goodsId, successBlock: { (successJson) in
                        self.reviewsJson = successJson
                        /**抽奖信息*/
                        self.goodsRequest.goodsDetailslucky_drawRequest(self.goodsId, successBlock: { (successJson) in
                            self.lucky_drawJson = successJson
                            /**可能喜欢*/
                            self.goodsRequest.goodsDetailsRecommendationRequest(self.goodsId, successBlock: { (successJson) in
                                
                                self.recommendationJson = successJson
                                
                                let mall_id:String = self.isSearchGoInto == true  ? String(self.goodsJson["mall_id"]) : self.mallId
                                /**店铺信息 */
                                self.goodsRequest.goodsDetailsmallRequest(mall_id, successBlock: { (successJson) in
                                    
                                    self.hideHUD()
                                    self.view.addSubview(self.bottomView)
                                    self.mallJson = successJson
                                    self.processData(self.goodsJson, mallData: self.mallJson, reviewsData: self.reviewsJson, recommendationData: self.recommendationJson, lucky_drawData: self.lucky_drawJson)
                                    
                                    }, errorBlock: { (error) in
                                        print(error)
                                })
                                
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
    }
    
    /**处理数据*/
    func processData(goodsData:JSON,mallData:JSON,reviewsData:JSON,recommendationData:JSON,lucky_drawData:JSON) {
        
        ///价格和销量
       let pricesAndSales = basicInformation()
        pricesAndSales.basicDataSouce = goodsData
        pricesAndSales.cellType = .pricesAndSales
        pricesAndSales.cellHeight = 30
        pricesAndSales.cellWidth = ScreenWidth
        basicDataArray.append(pricesAndSales)

        ///商品名称
       let  goodsName = basicInformation()
        goodsName.basicDataSouce = goodsData
        goodsName.cellType = .goodsName
        goodsName.cellHeight = String(goodsName.goodsName).stringHeightWith(15,width:(ScreenWidth-10))+5
        goodsName.cellWidth = ScreenWidth
        basicDataArray.append(goodsName)

        ///商品说明
        let goodsDesc = basicInformation()
        goodsDesc.basicDataSouce = goodsData
        goodsDesc.cellType = .goodsDesc
        goodsDesc.cellHeight = String(goodsDesc.goods_desc).stringHeightWith(15,width:(ScreenWidth-10))+5
        goodsDesc.cellWidth = ScreenWidth
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
            lotteryRules.cellWidth = ScreenWidth
            basicDataArray.append(lotteryRules)
        }
        
        if String(goodsData["country"]) != "" && String(goodsData["warehouse"]) != "" {///有显示国外发货
            ///进口商品
           let importedGoods = basicInformation()
            importedGoods.cellType = .importedGoods
            importedGoods.cellHeight = 30
            importedGoods.cellWidth = ScreenWidth
            self.basicDataArray.append(importedGoods)
        }
        ///商家许可范围
        let allowedRegion = basicInformation()
        allowedRegion.basicDataSouce = goodsData
        allowedRegion.cellType = .allowedRegion
        allowedRegion.cellHeight = 30
        allowedRegion.cellWidth = ScreenWidth
        basicDataArray.append(allowedRegion)

        ///团购说明
        let groupSpecification = basicInformation()
        groupSpecification.basicDataSouce = goodsData
        groupSpecification.cellType = .groupSpecification
        groupSpecification.cellHeight = 30
        groupSpecification.cellWidth = ScreenWidth
        basicDataArray.append(groupSpecification)
        
        if goodsData["local_group"].count > 0 {
            
            /**有正在团购的信息*/
             /// 参加团购
            let groupBuying = basicInformation()
            groupBuying.basicDataSouce = goodsData
            groupBuying.cellType = .groupBuying
            groupBuying.cellHeight = 30
            groupBuying.cellWidth = ScreenWidth
            basicDataArray.append(groupBuying)
            
            for i in 0..<goodsData["local_group"].count {
                 /// 团购详情
                let groupPurchaseDetails = basicInformation()
                groupPurchaseDetails.cellType = .groupPurchaseDetails
                groupPurchaseDetails.cellHeight = 50
                groupPurchaseDetails.cellWidth = ScreenWidth
                groupPurchaseDetails.groupPurchaseDetails = String(goodsData["local_group"][i])
                basicDataArray.append(groupPurchaseDetails)
            }
        }
        
        if reviewsData["data"].count > 0  {///有评价信息
                        /// 评价
            let evaluate = basicInformation()
            evaluate.cellType = .evaluate
            evaluate.cellHeight = 40
            evaluate.cellWidth = ScreenWidth
            basicDataArray.append(evaluate)
            
            for i in 0..<reviewsData["data"].count {
                /// 评价详情
                let evaluateParticulars = basicInformation()
                evaluateParticulars.cellType = .evaluateParticulars
                evaluateParticulars.evaluateInformation = reviewsData["data"][i]
                evaluateParticulars.cellHeight = String(reviewsData["data"][i]["comment"]).stringHeightWith(13,width:(ScreenWidth-10))+70
                evaluateParticulars.cellWidth = ScreenWidth
                basicDataArray.append(evaluateParticulars)
                
            }
        }
         /// 店铺信息
        let store = basicInformation()
        store.cellType = .store
        store.cellHeight = 80
        store.cellWidth = ScreenWidth
        var shopMation = shopInformation()
        shopMation.id = String(mallData["id"])
        shopMation.logo = String(mallData["logo"])
        shopMation.mall_name = String(mallData["mall_name"])
        shopMation.mall_sales = String(mallData["mall_sales"])
        store.shopMation = shopMation
        basicDataArray.append(store)
        
        
        /**
         *  解析图片
         *  @return nil
         */
        var array = [imagesInformation]()
        var scrollImageArray = [imagesInformation]()
        
        for j in 0 ..< goodsData["gallery"].count { //图片数组
            var images = imagesInformation()
            images.goods_id = String(goodsData["gallery"][j]["goods_id"])
            images.height = String(goodsData["gallery"][j]["height"])
            images.id = String(goodsData["gallery"][j]["id"])
            images.priority = Int(String(goodsData["gallery"][j]["priority"]))
            images.type = String(goodsData["gallery"][j]["type"])
            images.url = String(goodsData["gallery"][j]["url"])
            images.width = String(goodsData["gallery"][j]["width"])

            if Int(images.type!) ==  2{
                array.append(images)
            }
            if Int(images.type!) ==  1 {
                scrollImageArray.append(images)
            }
        }
        
        
       //对数组进行排序,反序
        imageArray = array.sort({$0.priority < $1.priority})
        scrollerImageArray = scrollImageArray.sort({$0.priority < $1.priority})
        
        for i in 0..<imageArray.count {
            let image = basicInformation()
            image.cellType = .image
            image.imagesInformn = imageArray[i]
            let imageHeight =  Float((image.imagesInformn?.height)!)
            let imageWidth =  Float((image.imagesInformn?.width)!)
            image.cellHeight = ScreenWidth * CGFloat(imageHeight!/imageWidth!)
            image.cellWidth = ScreenWidth
            basicDataArray.append(image)
            
        }
        
        
        /// 可能喜欢
        let mayLove = basicInformation()
        mayLove.cellType = .mayLove
        mayLove.cellHeight = 40
        mayLove.cellWidth = ScreenWidth
        basicDataArray.append(mayLove)
        
        
        for j in 0 ..< recommendationData["list"].count {
            
            var recommend = recommendInformation()
            recommend.goods_id = String(recommendationData["list"][j]["goods_id"])
            recommend.goods_name = String(recommendationData["list"][j]["goods_name"])
            recommend.thumb_url = String(recommendationData["list"][j]["thumb_url"])
            recommend.mall_id = String(recommendationData["list"][j]["mall_id"])
            recommend.price = String(recommendationData["list"][j]["price"])

            /// ///推荐的商品
            let recommendedGoods = basicInformation()
            recommendedGoods.cellType = .recommendedGoods
            recommendedGoods.cellHeight = 180
            recommendedGoods.cellWidth = ScreenWidth/3
            recommendedGoods.recommendInformn = recommend
            basicDataArray.append(recommendedGoods)
        }
        
        ///底部显示
        let bottom = basicInformation()
        bottom.cellType = .bottom
        bottom.cellHeight = 50
        bottom.cellWidth = ScreenWidth
        basicDataArray.append(bottom)
        
        collectionView.reloadData()
        bottomView.basicDataSouce = goodsData
    }
}

// MARK: - UICollectionViewDataSource
extension GoodsDetailsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GoodsDetailsHeadDelegate {
    
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
        case .groupPurchaseDetails:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupPurchaseCell", forIndexPath: indexPath) as! GroupPurchaseCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.reloadDataSouce(basic.groupPurchaseDetails!)
            return cell
        case .evaluate:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EvaluateCell", forIndexPath: indexPath) as! EvaluateCell
            cell.evaluateDataSouce = self.reviewsJson
            return cell
        case .evaluateParticulars:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EvaluateParticularsCell", forIndexPath: indexPath) as! EvaluateParticularsCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.evaluateParticularsDataSouce = basic.evaluateInformation!
            return cell
        case .store:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StoreCell", forIndexPath: indexPath) as! StoreCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.storeDataSouce = basic.shopMation!
            return cell
        case .image:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
            cell.backgroundColor = UIColor.cyanColor()
            cell.imageDataSouce = basic.imagesInformn!
            return cell
        case .mayLove:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MayLoveCell", forIndexPath: indexPath) as! MayLoveCell
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        case .recommendedGoods:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecommendedGoodsCell", forIndexPath: indexPath) as! RecommendedGoodsCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.recommend = basic.recommendInformn!
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BottomCell", forIndexPath: indexPath) as! BottomCell
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var basic = basicInformation()
        basic = basicDataArray[indexPath.row]
        return CGSizeMake(basic.cellWidth ,basic.cellHeight)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: ScreenWidth, height: 230)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            headView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "GoodsDetailsHeadView", forIndexPath: indexPath) as! GoodsDetailsHeadView
            headView.reloadData(scrollerImageArray)
            headView.delegate = self
            return headView
            
        case UICollectionElementKindSectionFooter:
            
            return UICollectionReusableView()
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var basic = basicInformation()
        basic = basicDataArray[indexPath.row]
        
        switch basic.cellType {
        case .groupPurchaseDetails:///团购详情
            
            print(basic.groupPurchaseDetails)
            
        case .evaluate:///用户评价
            
            let evaluateView = ProductEvaluationViewController()
            evaluateView.goodsId = goodsId
            evaluateView.average = String(self.reviewsJson["average"])
            evaluateView.number = String(self.reviewsJson["number"])
            self.navigationController?.pushViewController(evaluateView, animated: true)
            
        case .store:///店铺信息
            
            if isStoreInformationGoInto == true {
                
                self.navigationController?.popViewControllerAnimated(true)
                
            }else {
                
                let homeSubject = HomeSubjectViewController()
                homeSubject.StoreInformation = self.mallJson
                homeSubject.isGoodsDetailsGoInto = true
                homeSubject.title = String(self.mallJson["mall_name"])
                self.navigationController?.pushViewController(homeSubject, animated: true)
                
            }
            
            
        case .recommendedGoods:///推荐的商品
            
            let goodsSubject = GoodsDetailsViewController()
            goodsSubject.title = basic.recommendInformn!.goods_name
            goodsSubject.goodsId = basic.recommendInformn!.goods_id
            goodsSubject.mallId = basic.recommendInformn!.mall_id
            goodsSubject.isSearchGoInto = false
            goodsSubject.isStoreInformationGoInto = false
            self.navigationController?.pushViewController(goodsSubject, animated: true)
            
        default:
            return
        }
    }
    
    
    func GoodsDetailsHeadRequestResult(page:Int) {
        
        var images = [SKPhoto]()
        
        for i in 0 ..< scrollerImageArray.count {
            var showImage = imagesInformation()
            showImage = scrollerImageArray[i]
            let photo = SKPhoto.photoWithImageURL(showImage.url!)
            photo.shouldCachePhotoURLImage = false
            images.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(page)
        browser.displayBackAndForwardButton = false   //回/前进按钮将被隐藏
        browser.displayAction = false //操作按钮将被隐藏
        presentViewController(browser, animated: true, completion: {})
        
    }
}

// MARK: - 无数据时展示
extension GoodsDetailsViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    func customViewForEmptyDataSet(scrollView: UIScrollView!) -> UIView! {
        
            let emptyViewGound = UIView(frame: CGRectMake(0,0,ScreenWidth,ScreenHeight))
            emptyViewGound.backgroundColor = UIColor.whiteColor()
            return emptyViewGound
    }
}

