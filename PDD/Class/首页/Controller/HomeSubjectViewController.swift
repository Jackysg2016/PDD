//
//  HomeSubjectViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/28.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页滚动广告视图控制器

import UIKit

class HomeSubjectViewController: BaseViewController,homeSubjectDataDelegate {

    var subjectID = String?()
    var tableView:UITableView?
    var dataArray = [HomeModel]()
    var bgImageString:String!
    var homeSubjecRequest = HomeSubjectRequest()

    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.cyanColor()
        
        homeSubjecRequest.homeSubjectRequest(subjectID!)
        self.showHUD()
        homeSubjecRequest.delegate = self
        
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView!.registerClass(HomeMainTableViewCell.self, forCellReuseIdentifier:"HomeMainTableViewCell")
        tableView?.tableFooterView = UIView()
        
        let headerView = HomeSubjectHeaderView(frame: CGRectMake(0,0,ScreenWidth,200))
        tableView?.tableHeaderView = headerView
        headerView.reloadImage(bgImageString)
        self.view.addSubview(tableView!)
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(RankingTableViewController.headerRefresh))
        header.lastUpdatedTimeLabel!.hidden = true
        header.stateLabel!.hidden = true
        tableView!.mj_header = header
        
    }
    
    // 顶部刷新
    func headerRefresh(){
        
        homeSubjecRequest.homeSubjectRequest(subjectID!)
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

}