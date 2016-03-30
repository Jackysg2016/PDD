//
//  SearchDetailsRequest.swift
//  PDD
//
//  Created by 周磊 on 16/3/30.
//  Copyright © 2016年 ZL. All rights reserved.
//  搜索详情数据请求

import UIKit

class SearchDetailsRequest: NSObject {

    weak var delegate:searchDetailsRequestDelegate?
    
    func searchDetailsRequest(optId:String,optType:String){
        
        let url = "http://apiv2.yangkeduo.com/operation/\(optId)/groups?opt_type=\(optType)"
        
        request.defaultInstance().GetRequest(url).responseJSON { response in
            
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let goods_list = JsonData["goods_list"] as? NSArray
                let opt_infos = JsonData["opt_infos"] as? NSArray

                var goods_listArray = [SearchDetailsGoods_listModel]()
                var opt_infosArray = [SearchDetailsOpt_infosModel]()

                for  goods_list_dict in goods_list! {
                    
                    var searchDetailsGoods_list = SearchDetailsGoods_listModel()
                    searchDetailsGoods_list.mapping(goods_list_dict as! Dictionary<String, AnyObject>)
                    goods_listArray.append(searchDetailsGoods_list)
                }
                
                for  opt_infos_dict in opt_infos! {
                    var searchDetailsOpt_infos = SearchDetailsOpt_infosModel()
                    searchDetailsOpt_infos.mapping(opt_infos_dict as! Dictionary<String, AnyObject>)
                    opt_infosArray.append(searchDetailsOpt_infos)
                }
                
                self.delegate?.searchDetailsRequest(goods_listArray,opt_infosArray: opt_infosArray)

            case .Failure(let error):
                
                print(error)
            }
        }
    }
}
protocol searchDetailsRequestDelegate: NSObjectProtocol {
    
    func searchDetailsRequest(goods_listArray:[SearchDetailsGoods_listModel],opt_infosArray:[SearchDetailsOpt_infosModel])
    
}