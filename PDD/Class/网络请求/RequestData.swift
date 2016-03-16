//
//  RequestData.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页网络请求

import UIKit
import Alamofire


class RequestData:NSObject {
    
    weak var delegate:RequestDataDelegate?

     func requestData(){
        
        request.defaultInstance().GetRequest(HomeUrl).responseJSON { response in
      
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let goods_list = JsonData["goods_list"] as? NSArray
                let home_recommend = JsonData["home_recommend_subjects"] as? NSArray
                let mobile_app_groups = JsonData["mobile_app_groups"] as? NSArray
                
                var goods_listArray = [HomeModel]()
                var home_recommendArray = [home_recommend_subjectsModel]()
                var mobile_appArray = [mobile_app_groups_Model]()
                var totalArray = [HomeTotalData]()
                
                for  goods_list_dict in goods_list! {
                    let dataJieXi = HomeModel()
                    dataJieXi.mapping(goods_list_dict as! Dictionary<String, AnyObject>)
                    goods_listArray.append(dataJieXi)
                }
                
                for  home_recommend_dict in home_recommend! {
                    var home_recommend = home_recommend_subjectsModel()
                    home_recommend.mapping(home_recommend_dict as! Dictionary<String, AnyObject>)
                    home_recommendArray.append(home_recommend)
                }
                
                for  mobile_app_dict in mobile_app_groups! {
                    var mobile = mobile_app_groups_Model()
                    mobile.mapping(mobile_app_dict as! Dictionary<String, AnyObject>)
                    mobile_appArray.append(mobile)
                }
            
                for homeTotalData  in mobile_appArray {
                    let homeTotal = HomeTotalData()
                    homeTotal.mobile_app = homeTotalData
                    homeTotal.cellType = CellType.group
                    totalArray.append(homeTotal)
                }
                
                for goods in goods_listArray {
                    let homeTotal = HomeTotalData()
                    homeTotal.good_list = goods
                    homeTotal.cellType = CellType.common
                    totalArray.append(homeTotal)
                }
                
                for var i = 0;i<home_recommendArray.count;i++ {
                    let homeTotal = HomeTotalData()
                    homeTotal.home_recommend = home_recommendArray[i]
                    homeTotal.cellType = CellType.advertisement
                    totalArray.insert(homeTotal, atIndex: (i+1)*5)
                }
                
                self.delegate?.request(totalArray)
            
            case .Failure(let error):
                
                print(error)
            }
        }
    }
}


protocol RequestDataDelegate: NSObjectProtocol {
    
    func request(goods_listArray:NSArray)
    
}