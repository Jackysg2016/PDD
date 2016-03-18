//
//  RankingTableViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/18.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class RankingTableViewController: UITableViewController,hotListRequestDataDelegate {

    var parameter:String?
    var dataSouce = [HotListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.whiteColor()
        
        tableView.registerClass(HotListTableViewCell.self, forCellReuseIdentifier: "HotListTableViewCell")
        
        let headerView = UIView(frame:CGRectMake(0, 0, ScreenWidth, 5))

        headerView.backgroundColor = BgColor
        
        tableView!.tableHeaderView = headerView;

        
        
        let hotListRequest = HotListRequestData()
        hotListRequest.delegate = self
        self.showHUD()
        hotListRequest.requestData(parameter!)
        
    }
    
    func hotListRequest(goods_listArray:NSArray) {
        
        self.hideHUD()
        
        dataSouce = goods_listArray as! [HotListModel]
        
        tableView.reloadData()
        
    }
    
    
    // MARK: - Table view data source
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSouce.count
    }

    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var hotList = HotListModel()
        hotList = dataSouce[indexPath.row]
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("HotListTableViewCell", forIndexPath: indexPath) as! HotListTableViewCell
    
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.releaseData(hotList, index: "\(indexPath.row+1)")
        
        return cell
        
    }
 
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 150
    }
    
    
    
}
