//
//  HotListModel.swift
//  PDD
//
//  Created by 周磊 on 16/3/18.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit


class HotListModel: NSObject {
    
    var time:NSInteger?
    var cnt:String?
    var event_type:String?
    var goods_id:String?
    var goods_name:String?
    var group:NSDictionary?
    var hd_thumb_url:String?
    var image_url:String?
    var is_app:String?
    var list_desc:String?
    var logo:String?
    var mall_id:String?
    var market_price:String?
    var thumb_url:String?

    
    var customer_num:String?
    var price:String?
    
    
    func mapping(map:Dictionary<String,AnyObject>){
        
        time = map["time"] as? NSInteger
        cnt = map["cnt"] as? String
        event_type = map["event_type"] as? String
        goods_id = map["goods_id"] as? String
        goods_name = map["goods_name"] as? String
        group = map["group"] as? NSDictionary
        hd_thumb_url = map["hd_thumb_url"] as? String
        image_url = map["image_url"] as? String
        is_app = map["is_app"] as? String
        list_desc = map["list_desc"] as? String
        logo = map["logo"] as? String
        mall_id = map["mall_id"] as? String
        market_price = map["market_price"] as? String
        thumb_url = map["thumb_url"] as? String

        customer_num = group!["customer_num"] as? String
        price = group!["price"] as? String
        
    }

}
