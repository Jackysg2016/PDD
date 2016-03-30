
//
//  SearchModel.swift
//  PDD
//
//  Created by 周磊 on 16/3/21.
//  Copyright © 2016年 ZL. All rights reserved.
//  搜索Model

import UIKit

class SearchModel: NSObject {

    var children:NSArray?
    var id:String?
    var image_url:String?
    var is_highlight:String?
    var hd_thumb_url:String?
    var opt_desc:String?
    var opt_id:String?
    var opt_id_1:String?
    var opt_id_2:String?
    var opt_id_3:String?
    var opt_name:String?
    var priority:String?
    
    func mapping(map:Dictionary<String,AnyObject>){
        
        children = map["children"] as? NSArray
        id = map["id"] as? String
        image_url = map["image_url"] as? String
        is_highlight = map["is_highlight"] as? String
        opt_desc = map["opt_desc"] as? String
        hd_thumb_url = map["hd_thumb_url"] as? String
        opt_id = map["opt_id"] as? String
        opt_id_1 = map["opt_id_1"] as? String
        opt_id_2 = map["opt_id_2"] as? String
        priority = map["priority"] as? String
        opt_id_3 = map["opt_id_3"] as? String
        opt_name = map["opt_name"] as? String
        
    }
}


struct childrenModel {
    
    var id:String?
    var image_url:String?
    var is_highlight:String?
    var hd_thumb_url:String?
    var opt_desc:String?
    var opt_id:String?
    var opt_id_1:String?
    var opt_id_2:String?
    var opt_id_3:String?
    var opt_name:String?
    var priority:String?
    
    mutating func mapping(map: Dictionary<String, AnyObject>) {
        
        id = map["id"] as? String
        image_url = map["image_url"] as? String
        is_highlight = map["is_highlight"] as? String
        opt_desc = map["opt_desc"] as? String
        hd_thumb_url = map["hd_thumb_url"] as? String
        opt_id = map["opt_id"] as? String
        opt_id_1 = map["opt_id_1"] as? String
        opt_id_2 = map["opt_id_2"] as? String
        priority = map["priority"] as? String
        opt_id_3 = map["opt_id_3"] as? String
        opt_name = map["opt_name"] as? String
    
    }
}


struct SearchDetailsGoods_listModel {
    
    var goods_id:String?
    var goods_name:String?
    var group:NSDictionary?
    var image_url:String?
    var market_price:String?
    var thumb_url:String?
    
    var customer_num:String?
    var price:String?
    
    mutating func mapping(map:Dictionary<String,AnyObject>){
        
        goods_id = map["goods_id"] as? String
        goods_name = map["goods_name"] as? String
        group = map["group"] as? NSDictionary
        image_url = map["image_url"] as? String
        market_price = map["market_price"] as? String
        thumb_url = map["thumb_url"] as? String

        customer_num = group!["customer_num"] as? String
        price = group!["price"] as? String
        
    }
    
}

struct SearchDetailsOpt_infosModel {
    
    var id:String?
    var opt_name:String?
    var priority:String?
    
    mutating func mapping(map:Dictionary<String,AnyObject>){
        
        id = map["id"] as? String
        opt_name = map["opt_name"] as? String
        priority = map["priority"] as? String
        
    }
}



