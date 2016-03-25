//
//  HomeViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var tableView:UITableView?
    var dataArray = [HomeTotalData]()
    var homeRollArray = [HomeRollModel]()
    var homeHeaderView = HomeHeaderView()
    
    var homeRecommendDataArray = [home_recommend_subjectsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()        
        view.backgroundColor = BgColor
        
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = BgColor
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView!.registerClass(HomeMainTableViewCell.self, forCellReuseIdentifier:"HomeMainTableViewCell")
        tableView!.registerClass(HomeFirstTableViewCell.self, forCellReuseIdentifier:"HomeFirstTableViewCell")
        tableView?.registerClass(HomeAdTableViewCell.self, forCellReuseIdentifier: "HomeAdTableViewCell")
        homeHeaderView = HomeHeaderView(frame: CGRectMake(0, 0, ScreenWidth, 200))
        homeHeaderView.delegate = self
        tableView!.tableHeaderView = homeHeaderView;
        view.addSubview(tableView!)
        
        let homeRequest = RequestData()
        homeRequest.delegate = self
        self.showHUD()
        homeRequest.requestData()
    }
}

// MARK: - 获取数据
extension  HomeViewController:RequestDataDelegate,HomeRollDataDelegate {

    func request(goods_listArray:NSArray){
        dataArray = goods_listArray as! [HomeTotalData]
        tableView?.reloadData()
        let homeRoll = HomeRollData()
        homeRoll.delegate = self
        homeRoll.requestData()
    }
   
    func requestResult(homeRollDataArray:NSArray) {
        self.hideHUD()
        homeRollArray = homeRollDataArray as! [HomeRollModel]
        homeHeaderView.reloadData(homeRollArray)
    }
}
// MARK: - UITableViewDelegate
extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var home = HomeTotalData()
        home = dataArray[indexPath.row]
        
        switch home.cellType {
        case .group:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("HomeFirstTableViewCell", forIndexPath: indexPath) as! HomeFirstTableViewCell
            cell.backgroundColor = BgColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.releaseData(home)
            return cell
            
        case .common:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeMainTableViewCell", forIndexPath: indexPath) as! HomeMainTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = BgColor
            cell.removeObj()
            cell.releaseData(home.good_list,secton:indexPath.row)

            return cell
            
        default:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("HomeAdTableViewCell", forIndexPath: indexPath) as! HomeAdTableViewCell
            cell.backgroundColor = BgColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.releaseHomeAdData(home.home_recommend, homeRecommend: home.home_recommend.goodsList)
            cell.delegate = self
            return cell
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var home = HomeTotalData()
        home = dataArray[indexPath.row]
        
        switch home.cellType {
        case .group:
            return 80
        case .common:
            let  height=home.good_list.goods_name!.stringHeightWith(15,width:(ScreenWidth-20))
            return (180 + 85 + height)
        default:
            return 280
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("\(indexPath.row)")
        
    }
}

// MARK: - 中间广告点击事件
extension  HomeViewController:ClickCollectionCallbackDelegate {
    
    func requestResult(home_recommend_goodlist:home_recommend_goodlistModel) {
        
        print(home_recommend_goodlist.goods_name)
    }
}
// MARK: - 滚动图片点击事件
extension  HomeViewController:HomeHeaderDelegate {
    
    func homeHeaderRequestResult(homeRollData:HomeRollModel) {
        
        print(homeRollData.subject)
    }
}

