//
//  GoodsDetailsViewController.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品详情

import UIKit
import SwiftyJSON

class GoodsDetailsViewController: BaseViewController {
    
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
        self.showHUD()

        request()
        
    }
    
    
    
    func request() {
        /**主要数据*/
        goodsRequest.goodsDetailsrequest(goodsId, successBlock: { (successJson) in
            self.hideHUD()
            self.goodsJson = successJson
            
        }) { (error) in
            
            print(error)
            
        }

         /**店铺信息*/
        goodsRequest.goodsDetailsmallRequest(mallId, successBlock: { (successJson) in
            
            self.mallJson = successJson

            
        }) { (error) in
            
            print(error)
            
        }

        /**评价信息*/
        goodsRequest.goodsDetailsReviewsRequest(goodsId, successBlock: { (successJson) in
            
            self.reviewsJson = successJson

            
        }) { (error) in
            
            print(error)
            
        }
 
        /**可能喜欢*/
        goodsRequest.goodsDetailsRecommendationRequest(goodsId, successBlock: { (successJson) in
            
            self.recommendationJson = successJson

            
        }) { (error) in
            
            print(error)
            
        }

        /**抽奖信息*/
        goodsRequest.goodsDetailslucky_drawRequest(goodsId, successBlock: { (successJson) in
            
            self.lucky_drawJson = successJson
            
            }) { (error) in
                
                print(error)
                
        }
        
        
        
        
    }
    
}
