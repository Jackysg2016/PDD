//
//  SearchViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    var tableView:UITableView?
    var request:SearchRequest?
    var dataArray = [SearchModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: UITableViewStyle.Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = BgColor
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView?.registerClass(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        self.view.addSubview(tableView!)
        
        request = SearchRequest()
        request!.searchRequest()
        request!.delegate = self
        self.showHUD()
    }
}
// MARK: - 获取数据
extension SearchViewController:searchRequestDataDelegate {
    
    func searchRequest(searchDataArray:[SearchModel]) {
        self.hideHUD()
        dataArray = searchDataArray
        
        let headerView = SearchHeaderView(frame:CGRectMake(0,0,ScreenWidth,40))
        headerView.backgroundColor = BgColor
        tableView?.tableHeaderView = headerView
        
        tableView?.reloadData()
    }
}

// MARK: - TableView代理
extension SearchViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let searchModel = dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! SearchTableViewCell
        cell.backgroundColor = BgColor
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.reloaddata(searchModel, childrendatasouce: searchModel.children!)
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let searchModel = dataArray[indexPath.row]
        let divide:Float = Float((searchModel.children?.count)!)/4
        let result = Int(ceilf(divide))
        return CGFloat((result*30) + 60)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var searchModel = SearchModel()
        searchModel =  dataArray[indexPath.row]
        
        let searchDetailView = SearchDetailsViewController()
        searchDetailView.title = searchModel.opt_name
        searchDetailView.goodsId = searchModel.id
        searchDetailView.opt_type = "1"
        self.navigationController?.pushViewController(searchDetailView, animated: true)
    }
}
// MARK: - 小单元格点击事件
extension SearchViewController:searchCellDelegate {
    
    func searchCellData(childrenEntity:childrenModel) {
        let searchDetailView = SearchDetailsViewController()
        searchDetailView.title = childrenEntity.opt_name
        searchDetailView.goodsId = childrenEntity.id
        searchDetailView.opt_type = "2"
        self.navigationController?.pushViewController(searchDetailView, animated: true)
    }
}

