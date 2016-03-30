//
//  HotListRequestData.swift
//  PDD
//
//  Created by 周磊 on 16/3/18.
//  Copyright © 2016年 ZL. All rights reserved.
//  热榜网络请求

import UIKit

class HotListRequestData: NSObject {

    weak var delegate:hotListRequestDataDelegate?

    func requestData(parameter:String) {
        
        let url = "http://apiv2.yangkeduo.com/v2/\(parameter)"
        
        request.defaultInstance().GetRequest(url).responseJSON { response in
            
            switch response.result {
                
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let goods_list = JsonData["goods_list"] as? NSArray
                
                var goods_listArray = [HotListModel]()

                for  goods_list_dict in goods_list! {
                    
                    let hotList = HotListModel()
                    hotList.mapping(goods_list_dict as! Dictionary<String, AnyObject>)
                    goods_listArray.append(hotList)
                }
                
                self.delegate?.hotListRequest(goods_listArray)
                
            case .Failure(let error):
                
                print(error)
            }
        }
        
    }
    
}
protocol hotListRequestDataDelegate: NSObjectProtocol {
    
    func hotListRequest(goods_listArray:NSArray)
    
}