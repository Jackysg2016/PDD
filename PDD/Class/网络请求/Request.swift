//
//  Request.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//  网络请求单例基类

import Foundation
import Alamofire

class request {
    
    init(){
        
    }
    class func defaultInstance() -> request {
        struct statics {
            static let instance  = request()
        }
        
        return statics.instance
    }
    
    func GetRequest(url:String)->Request {
        return Alamofire.request(.GET, url)
    }
    
    func PostRequest(url:String)->Request {
        return Alamofire.request(.POST, url)
    }
    
}