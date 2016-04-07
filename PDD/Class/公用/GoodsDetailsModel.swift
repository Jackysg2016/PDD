//
//  GoodsDetailsModel.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class GoodsDetailsModel: NSObject {
 
    /// 商家保障
    var allowed_region:String?
     /// 来源国家
    var country:String?
     /// 图片数组
    var gallery:NSArray?
     /// 商品说明
    var goods_desc:String?
     /// 商品id
    var goods_id:String?
     /// 商品名称
    var goods_name:String?
     /// 商品状态
    var goods_type:String?
     /// 团购
    var group:NSArray?
     /// 图片地址
    var image_url:String?
     /// 当地团购
    var local_group:NSArray?
     /// 商家id
    var mall_id:String?
     /// 市场价
    var market_price:String?
     /// 销售数量
    var sales:String?
     /// 分享说明
    var share_desc:String?
    /// 库存
    var sku:NSArray?
    var thumb_url:String?
    /// 仓库地址
    var warehouse:String?
    
    var groupArray = [goodsDetailsGroupModel]()

    
    func mapping(map:Dictionary<String,AnyObject>){
        
        allowed_region = map["allowed_region"] as? String
        country = map["country"] as? String
        gallery = map["gallery"] as? NSArray
        goods_desc = map["goods_desc"] as? String
        goods_id = map["goods_id"] as? String
        goods_name = map["goods_name"] as? String
        goods_type = map["goods_type"] as? String
        mall_id = map["mall_id"] as? String
        market_price = map["market_price"] as? String
        group = map["group"] as? NSArray
        image_url = map["image_url"] as? String
        local_group = map["local_group"] as? NSArray
        market_price = map["market_price"] as? String
        sales = map["sales"] as? String
        share_desc = map["share_desc"] as? String
        thumb_url = map["thumb_url"] as? String
        warehouse = map["warehouse"] as? String
        
        
        for detailsgroup in group! {
            
            var goodsDetailsGroup = goodsDetailsGroupModel()
            goodsDetailsGroup.mapping(detailsgroup as! Dictionary<String, AnyObject>)
            groupArray.append(goodsDetailsGroup)
        }
        
    }
    
    
}

struct goodsDetailsGroupModel {
    var buy_limit:String?
    var customer_num:String?
    var duration:String?
    var end_time:String?
    var goods_id:String?
    var group_id:String?
    var id:String?
    var is_open:String?
    var order_limit:String?
    var price:String?
    var start_time:String?

    mutating func mapping(map: Dictionary<String, AnyObject>) {
        
        buy_limit = map["buy_limit"] as? String
        customer_num = map["customer_num"] as? String
        duration = map["duration"] as? String
        end_time = map["end_time"] as? String
        goods_id = map["goods_id"] as? String
        group_id = map["group_id"] as? String
        id = map["id"] as? String
        is_open = map["is_open"] as? String
        order_limit = map["order_limit"] as? String
        price = map["price"] as? String
        start_time = map["start_time"] as? String
        
    }
}

