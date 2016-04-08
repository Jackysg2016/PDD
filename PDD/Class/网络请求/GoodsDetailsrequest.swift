//
//  GoodsDetailsrequest.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoodsDetailsrequest: NSObject {

    
    // http://apiv2.yangkeduo.com/recommendation?goods_id=18029&referrer=goods 可能喜欢
    //http://apiv2.yangkeduo.com/reviews/18029?page=1&size=2 评价
    //http://apiv2.yangkeduo.com/goods/18029 主要数据
    //http://apiv2.yangkeduo.com/mall/896/info 店铺信息
    //http://apiv2.yangkeduo.com/lucky_draw/18029 抽奖信息

    var goodsJson:JSON!
    var mallJson:JSON?
    var reviewsJson:JSON?
    var recommendationJson:JSON?
    
    
    func goodsDetailsrequest(goodsId:String,successBlock:(successJson:JSON)->Void,errorBlock:(error:NSError)->Void){
        
        let goodsUrl = "http://apiv2.yangkeduo.com/goods/\(goodsId)"
        
        request.defaultInstance().GetRequest(goodsUrl).responseData { response in
            
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let json = JSON(data: JsonData)
                 successBlock(successJson: json)
            case .Failure(let error):
                
                errorBlock(error: error)
            }
            
        }
    }
    
    
    func goodsDetailsmallRequest(mallId:String,successBlock:(successJson:JSON)->Void,errorBlock:(error:NSError)->Void) {
        
        let mallUrl = "http://apiv2.yangkeduo.com/mall/\(mallId)/info"

        request.defaultInstance().GetRequest(mallUrl).responseData { response in
            
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let json = JSON(data: JsonData)
                successBlock(successJson: json)
            case .Failure(let error):
                
               errorBlock(error: error)
            }
        }
        
    }
    
    func goodsDetailsReviewsRequest(goodsId:String,successBlock:(successJson:JSON)->Void,errorBlock:(error:NSError)->Void) {
        
        let reviewsUrl = "http://apiv2.yangkeduo.com/reviews/\(goodsId)?page=1&size=2"
        request.defaultInstance().GetRequest(reviewsUrl).responseData { response in
            
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let json = JSON(data: JsonData)
                 successBlock(successJson: json)
            case .Failure(let error):
                
                errorBlock(error: error)
            }
        }

    }
    
    func goodsDetailsRecommendationRequest(goodsId:String,successBlock:(successJson:JSON)->Void,errorBlock:(error:NSError)->Void) {
        
        let recommendationUrl = "http://apiv2.yangkeduo.com/recommendation?goods_id=\(goodsId)&referrer=goods"
        request.defaultInstance().GetRequest(recommendationUrl).responseData { response in
            
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let json = JSON(data: JsonData)
                 successBlock(successJson: json)
                
            case .Failure(let error):
                
                errorBlock(error: error)
            }
        }

    }
    
    func goodsDetailslucky_drawRequest(goodsId:String,successBlock:(successJson:JSON)->Void,errorBlock:(error:NSError)->Void) {
        
        let lucky_drawUrl = "http://apiv2.yangkeduo.com/lucky_draw/\(goodsId)"
        request.defaultInstance().GetRequest(lucky_drawUrl).responseData { response in
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let json = JSON(data: JsonData)
                
                successBlock(successJson: json)
                
            case .Failure(let error):
                
                errorBlock(error: error)
                
            }
            
        }

    }
    
}
