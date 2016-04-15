//
//  GoodsDetailsViewModel.swift
//  PDD
//
//  Created by 周磊 on 16/4/15.
//  Copyright © 2016年 ZL. All rights reserved.
//  MVVM 网络请求和逻辑处理在这里

import UIKit
import SwiftyJSON

class GoodsDetailsViewModel: NSObject {

    var goodsJson:JSON!
    var mallJson:JSON!
    var reviewsJson:JSON!
    var recommendationJson:JSON!
    var lucky_drawJson:JSON!
    let goodsRequest = GoodsDetailsrequest()
    var basicDataArray = [basicInformation]()
    var scrollerImageArray = [imagesInformation]()
    var imageArray = [imagesInformation]()
    
    
    func request(goodsId:String, mallId:String,isSearchGoInto:Bool,successBlock:(goodsJson:JSON,mallJson:JSON,reviewsJson:JSON,recommendationJson:JSON!,lucky_drawJson:JSON,basicDataArray:[basicInformation],scrollerImageArray:[imagesInformation],imageArray:[imagesInformation])->Void,errorBlock:(error:NSError)->Void) {
        
        /**主要数据*/
        goodsRequest.goodsDetailsrequest(goodsId, successBlock: { (successJson) in
            self.goodsJson = successJson
            /**评价信息*/
            self.goodsRequest.goodsDetailsReviewsRequest(goodsId, successBlock: { (successJson) in
                self.reviewsJson = successJson
                /**抽奖信息*/
                self.goodsRequest.goodsDetailslucky_drawRequest(goodsId, successBlock: { (successJson) in
                    self.lucky_drawJson = successJson
                    /**可能喜欢*/
                    self.goodsRequest.goodsDetailsRecommendationRequest(goodsId, successBlock: { (successJson) in
                        
                        self.recommendationJson = successJson
                        
                        let mall_id:String = isSearchGoInto == true  ? String(self.goodsJson["mall_id"]) : mallId
                        /**店铺信息 */
                        self.goodsRequest.goodsDetailsmallRequest(mall_id, successBlock: { (successJson) in
                            
                            self.mallJson = successJson
                            
                            self.processData(self.goodsJson, mallData: self.mallJson, reviewsData: self.reviewsJson, recommendationData: self.recommendationJson, lucky_drawData: self.lucky_drawJson)
                            
                            
                            successBlock(goodsJson: self.goodsJson,mallJson: self.mallJson,reviewsJson: self.reviewsJson,recommendationJson: self.recommendationJson,lucky_drawJson: self.lucky_drawJson,basicDataArray: self.basicDataArray,scrollerImageArray: self.scrollerImageArray,imageArray: self.imageArray)
                            
                            
                            
                            }, errorBlock: { (error) in
                                
                                errorBlock(error: error)

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
        
        
    }
}
/*
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

 */
