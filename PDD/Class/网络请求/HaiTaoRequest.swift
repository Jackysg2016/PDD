//
//  HaiTaoRequest.swift
//  PDD
//
//  Created by zhoulei on 16/3/20.
//  Copyright © 2016年 ZL. All rights reserved.
//  海淘数据请求

import UIKit

class HaiTaoRequest: NSObject {
    
    weak var delegate:haiTaoRequestDataDelegate?

    func haiTaoRequest() {
        
        request.defaultInstance().GetRequest(HaitaoUrl).responseJSON { response in
            
            switch response.result {
                
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let country_list = JsonData["country_list"] as? NSArray
                let promotion_list = JsonData["promotion_list"] as? NSArray
                let goods_list = JsonData["goods_list"] as? NSArray
                let home_recommend = JsonData["home_recommend_subjects"] as? NSArray

                var country_listArray = [HomeRollModel]()
                var promotion_listArray = [HomeRollModel]()
                var goods_listArray = [HomeModel]()
                var home_recommendArray = [home_recommend_subjectsModel]()
                var haiTaoDataArray = [HaiTaoDataModel]()

                ///国家信息
                for country in country_list! {
                    let countryInformation = HomeRollModel()
                    countryInformation.mapping(country as! Dictionary<String, AnyObject>)
                    country_listArray.append(countryInformation)
                }
                ///促销信息－滚动的广告
                for promotion in promotion_list! {
                    let promotionData = HomeRollModel()
                    promotionData.mapping(promotion as! Dictionary<String, AnyObject>)
                    promotion_listArray.append(promotionData)
                }
                
                ///主要的商品信息
                for  goods_list_dict in goods_list! {
                    let dataJieXi = HomeModel()
                    dataJieXi.mapping(goods_list_dict as! Dictionary<String, AnyObject>)
                    goods_listArray.append(dataJieXi)
                }
                ///中间插播的广告信息
                for  home_recommend_dict in home_recommend! {
                    var home_recommend = home_recommend_subjectsModel()
                    home_recommend.mapping(home_recommend_dict as! Dictionary<String, AnyObject>)
                    home_recommendArray.append(home_recommend)
                }
                
                    let country = HaiTaoDataModel()
                    country.cellType = CellType.group
                    haiTaoDataArray.append(country)


                for goods in goods_listArray {
                    let haiTaoTotal = HaiTaoDataModel()
                    haiTaoTotal.good_list = goods
                    haiTaoTotal.cellType = CellType.common
                    haiTaoDataArray.append(haiTaoTotal)
                }
                
                
                for var i = 0;i<home_recommendArray.count;i++ {
                    let haiTaoTotal = HaiTaoDataModel()
                    haiTaoTotal.home_recommend = home_recommendArray[i]
                    haiTaoTotal.cellType = CellType.advertisement
                    haiTaoDataArray.insert(haiTaoTotal, atIndex: (i+1)*5)
                }
                
                self.delegate?.haiTapRequest(haiTaoDataArray, promotionData: promotion_listArray, countryData: country_listArray)
                
                
            case .Failure(let error):
                
                print(error)
            }
        }
    }
    
}
protocol haiTaoRequestDataDelegate: NSObjectProtocol {
    
    func haiTapRequest(haiTaoTotalArray:NSArray,promotionData:[HomeRollModel],countryData:[HomeRollModel])
    
}