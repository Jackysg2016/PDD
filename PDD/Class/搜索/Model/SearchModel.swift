
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



