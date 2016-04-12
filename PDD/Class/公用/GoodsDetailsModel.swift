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
    
    var groupPurchaseDetails:String?

    var cellHeight:CGFloat!
    
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


/**团购信息*/
struct groupInformation {
    
    var cellType = GoodsDetailsCellType.groupBuying

}



/**评价信息*/
struct evaluateInformation {
    
    var cellType = GoodsDetailsCellType.evaluateParticulars

}



/**店铺信息*/
struct shopInformation {
    var cellType = GoodsDetailsCellType.store

}


/**图片信息*/
struct imagesInformation {
    var cellType = GoodsDetailsCellType.image

}


/**推荐信息*/
struct recommendInformation {

}
