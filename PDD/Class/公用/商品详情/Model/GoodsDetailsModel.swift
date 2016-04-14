//
//  GoodsDetailsModel.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import SwiftyJSON


class GoodsDetailsModel: NSObject {
    
    
}

/**基本信息*/
class basicInformation: NSObject {
        /// 现价
    var nowPrice:String!
        /// 原价
    var market_price:JSON!
        /// 销售数量
    var salesNumber:JSON!
        /// 商品名称
    var goodsName:JSON!
        /// 商品说明
    var goods_desc:JSON!
        /// 进口说明
    var countryDesc:String!
        /// 团购说明
    var groupDesc:JSON!
        /// cell类型
    var cellType = GoodsDetailsCellType.goodsName
        /// 团购详情
    var groupPurchaseDetails:String?
        /// 评价详情
    var evaluateInformation:JSON?
    
    /// 图片信息
    var imagesInformn:imagesInformation?
        /// 推荐信息
    var recommendInformn:recommendInformation?
    /// 店铺信息
    var shopMation:shopInformation?
    
    var cellHeight:CGFloat!
    var cellWidth:CGFloat!

    var basicDataSouce:JSON = [] {
        
        didSet {
        
            salesNumber = basicDataSouce["sales"]
            goods_desc = basicDataSouce["goods_desc"]
            goodsName = basicDataSouce["goods_name"]
            if basicDataSouce["country"] != nil {
                countryDesc = "\(basicDataSouce["country"])进口 \(basicDataSouce["warehouse"])发货"
            }
            
            let price:String?
            if basicDataSouce["event_type"] == 2 {
                price = String(basicDataSouce["group"][0]["price"])
            }else {
                price = String(basicDataSouce["group"][1]["price"])
            }
            
            let floatPrice = Float(price!)!/100
            nowPrice = String(format: "%.2f", floatPrice)
        }
    }
    
}


/**店铺信息*/
struct shopInformation {

    var logo:String?
    var mall_name:String?
    var mall_sales:String?
    var id:String?
    
}

/**图片信息*/
struct imagesInformation {

    var goods_id:String?
    var height:String?
    var id:String?
    var priority:Int?
    var type:String?
    var url:String?
    var width:String?
    
}

/**推荐信息*/
struct recommendInformation {

    var goods_id:String?
    var thumb_url:String?
    var goods_name:String?
    var mall_id:String?
    var price:String?
}
/**商品评价*/
struct productEvaluation {
    
    var avatar:String?
    var comment:String?
    var name:String?
    var stars:String?
    var time:String?
    
    mutating func mapping(map: JSON) {
        
        avatar = String(map["avatar"])
        comment = String(map["comment"])
        name = String(map["name"])
        stars = String(map["stars"])
        time = String(map["time"])
        
    }
}
