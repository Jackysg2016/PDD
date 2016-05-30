//
//  HomeSubjectViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/28.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页滚动广告视图控制器

import UIKit
import SwiftyJSON

class HomeSubjectViewController: BaseViewController,homeSubjectDataDelegate {

    var subjectID:String!
    var tableView:UITableView?
    var dataArray = [HomeModel]()
    var bgImageString:String!
    var homeSubjecRequest = HomeSubjectRequest()

        /// 是否是商品详情页进来的，商详页进来的headerView不一样，数据请求也不一样
    var isGoodsDetailsGoInto:Bool!

        /// 店铺信息
    var StoreInformation:JSON!
    
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.cyanColor()
        
        
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView!.registerClass(HomeMainTableViewCell.self, forCellReuseIdentifier:"HomeMainTableViewCell")
        tableView?.tableFooterView = UIView()
        self.view.addSubview(tableView!)

        if isGoodsDetailsGoInto == false {
            
            homeSubjecRequest.homeSubjectRequest(subjectID!)
            self.showHUD()
            homeSubjecRequest.delegate = self
            
            
            if bgImageString != nil {
                let headerView = HomeSubjectHeaderView(frame: CGRectMake(0,0,ScreenWidth,200))
                tableView?.tableHeaderView = headerView
                headerView.reloadImage(bgImageString)
                
            }else {
                
                homeSubjecRequest.countryGoodsListRequest(subjectID, blockPicture: { (picture) in
                    let headerView = HomeSubjectHeaderView(frame: CGRectMake(0,0,ScreenWidth,200))
                    self.tableView?.tableHeaderView = headerView
                    headerView.reloadImage(picture)
                })

            }
        }else {
            
            homeSubjecRequest.StoreInformationRequest(String(StoreInformation["mall_id"]))
            self.showHUD()
            homeSubjecRequest.delegate = self
             
            let headerView = StoreInformationHeaderView(frame: CGRectMake(0,0,ScreenWidth,String(StoreInformation["mall_desc"]).stringHeightWith(13,width:(ScreenWidth-10))+90))
            headerView.backgroundColor = BgColor
            headerView.StoreInformation = StoreInformation
            tableView?.tableHeaderView = headerView
        }
    
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(RankingTableViewController.headerRefresh))
        header.lastUpdatedTimeLabel!.hidden = true
        header.stateLabel!.hidden = true
        tableView!.mj_header = header
        
    }
    
    // 顶部刷新
    func headerRefresh(){
        
        if isGoodsDetailsGoInto == false {
            homeSubjecRequest.homeSubjectRequest(subjectID!)
        }else {
            homeSubjecRequest.StoreInformationRequest(String(StoreInformation["mall_id"]))
        }
    }

    
    func homeSubjectRequest(goods_listArray:NSArray) {
        
        self.hideHUD()
        // 结束刷新
        tableView!.mj_header.endRefreshing()
        dataArray.removeAll()
        
        dataArray = goods_listArray as! [HomeModel]
        tableView?.reloadData()
        
    }
    
}
extension HomeSubjectViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var homeSubject = HomeModel()
        homeSubject = dataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeMainTableViewCell", forIndexPath: indexPath) as! HomeMainTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = BgColor
        cell.removeObj()
        cell.releaseData(homeSubject, secton: indexPath.row)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var homeSubject = HomeModel()
        homeSubject = dataArray[indexPath.row]
        
        let  height=homeSubject.goods_name!.stringHeightWith(15,width:(ScreenWidth-20))
        return (180 + 85 + height)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var homeSubject = HomeModel()
        homeSubject = dataArray[indexPath.row]
        
            let goodsSubject = GoodsDetailsViewController()
            goodsSubject.title = homeSubject.goods_name
            goodsSubject.goodsId = homeSubject.goods_id
       
        
        if homeSubject.mall_id == nil {
            homeSubject.mall_id = "1"
        }
            goodsSubject.mallId = homeSubject.mall_id
            goodsSubject.isSearchGoInto = false

        if isGoodsDetailsGoInto == true {
            
            goodsSubject.isStoreInformationGoInto = true
        }else {
            goodsSubject.isStoreInformationGoInto = false

        }
            self.navigationController?.pushViewController(goodsSubject, animated: true)
    }
}