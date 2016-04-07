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
    ///

    func goodsDetailsrequest(goodsId:String,mallId:String){
        
        let goodsUrl = "http://apiv2.yangkeduo.com/goods/\(goodsId)"
        let mallUrl = "http://apiv2.yangkeduo.com/mall/\(mallId)/info"
        let reviewsUrl = "http://apiv2.yangkeduo.com/reviews/\(goodsId)?page=1&size=2"
        let recommendationUrl = "http://apiv2.yangkeduo.com/recommendation?goods_id=\(goodsId)&referrer=goods"

        
//        request.defaultInstance().GetRequest(goodsUrl).responseJSON { response in
//            
//            switch response.result {
//            case .Success:
//                
//                guard let JsonData = response.result.value else { return }
//                
//               
//            case .Failure(let error):
//                
//                print(error)
//            }
//        }
        
        request.defaultInstance().GetRequest(goodsUrl).responseData { response in
            
            guard let JsonData = response.result.value else { return }

            let json = JSON(data: JsonData)

            print(json["gallery"][0]["url"])

            
        }
        
        
//        request.defaultInstance().GetRequest(mallUrl).responseJSON { response in
//            
//            switch response.result {
//            case .Success:
//                
//                guard let JsonData = response.result.value else { return }
//                
//                print("mallUrl----\(JsonData)")
//                
//            case .Failure(let error):
//                
//                print(error)
//            }
//        }
//        
//        request.defaultInstance().GetRequest(reviewsUrl).responseJSON { response in
//            
//            switch response.result {
//            case .Success:
//                
//                guard let JsonData = response.result.value else { return }
//                
//                print("reviewsUrl----\(JsonData)")
//                
//            case .Failure(let error):
//                
//                print(error)
//            }
//        }
//
//        
//        request.defaultInstance().GetRequest(recommendationUrl).responseJSON { response in
//            
//            switch response.result {
//            case .Success:
//                
//                guard let JsonData = response.result.value else { return }
//                
//                print("recommendationUrl----\(JsonData)")
//                
//            case .Failure(let error):
//                
//                print(error)
//            }
//        }
//
    }
}
