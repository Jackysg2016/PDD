//
//  HomeModel.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页数据

import UIKit


class HomeModel: NSObject {
    
    var event_type:String?
    var goods_id:String?
    var goods_name:String?
    var group:NSDictionary?
    var image_url:String?
    var is_app:String?
    var list_desc:String?
    var logo:String?
    var mall_id:String?
    var market_price:String?
    
    var customer_num:String?
    var price:String?

    func mapping(map:Dictionary<String,AnyObject>){
        event_type = map["event_type"] as? String
        goods_id = map["goods_id"] as? String
        goods_name = map["goods_name"] as? String
        group = map["group"] as? NSDictionary
        image_url = map["image_url"] as? String
        is_app = map["is_app"] as? String
        list_desc = map["list_desc"] as? String
        logo = map["logo"] as? String
        mall_id = map["mall_id"] as? String
        market_price = map["market_price"] as? String
        
        customer_num = group!["customer_num"] as? String
        price = group!["price"] as? String

    }
    
}
struct home_recommend_subjectsModel {
    var desc:String?
    var goods_list:NSArray?
    var home_banner:String?
    var position:String?
    var subject:String?
    var subject_id:String?
    var type:String?
    var goodsList = [home_recommend_goodlistModel]()
    
    mutating func mapping(map: Dictionary<String, AnyObject>) {
        
        desc = map["desc"] as? String
        goods_list = map["goods_list"] as? NSArray
        home_banner = map["home_banner"] as? String
        position = map["position"] as? String
        subject = map["subject"] as? String
        subject_id = map["subject_id"] as? String
        type = map["type"] as? String
        
        for  goods_list_dict in goods_list! {
            var mobile = home_recommend_goodlistModel()
            mobile.mapping(goods_list_dict as! Dictionary<String, AnyObject>)
            goodsList.append(mobile)
        }
    }
}

struct mobile_app_groups_Model {
    var banner:String?
    var desc:String?
    var end_time:String?
    var goods_id:String?
    var goods_name:String?
    var group_id:String?
    var start_time:String?
    var thumb_url:String?
    
    mutating func mapping(map: Dictionary<String, AnyObject>) {
        banner = map["banner"] as? String
        desc = map["desc"] as? String
        end_time = map["end_time"] as? String
        goods_id = map["goods_id"] as? String
        goods_name = map["goods_name"] as? String
        group_id = map["group_id"] as? String
        start_time = map["start_time"] as? String
        thumb_url = map["thumb_url"] as? String
    }
}


struct home_recommend_goodlistModel {
    
    var customer_num:String?
    var event_type:String?
    var goods_id:String?
    var goods_name:String?
    var hd_thumb_url:String?
    var image_url:String?
    var is_app:String?
    var list_desc:String?
    var logo:String?
    var mall_id:String?
    var market_price:String?
    var price:String?
    var thumb_url:String?
    
    
    mutating func mapping(map: Dictionary<String, AnyObject>) {
        
        customer_num = map["customer_num"] as? String
        event_type = map["event_type"] as? String
        goods_id = map["goods_id"] as? String
        goods_name = map["goods_name"] as? String
        hd_thumb_url = map["hd_thumb_url"] as? String
        image_url = map["image_url"] as? String
        is_app = map["is_app"] as? String
        list_desc = map["list_desc"] as? String
        logo = map["logo"] as? String
        mall_id = map["mall_id"] as? String
        market_price = map["market_price"] as? String
        price = map["price"] as? String
        thumb_url = map["thumb_url"] as? String
    }
}




class HomeTotalData:NSObject {
    
    var good_list = HomeModel()
    
    var home_recommend = home_recommend_subjectsModel()
    
    var mobile_app = mobile_app_groups_Model()
    
    var cellType = CellType.group

}




