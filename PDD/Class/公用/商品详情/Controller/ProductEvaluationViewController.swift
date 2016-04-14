//
//  ProductEvaluationViewController.swift
//  PDD
//
//  Created by 周磊 on 16/4/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品评价

import UIKit
import SwiftyJSON

class ProductEvaluationViewController: BaseViewController{

    var goodsId:String!
    let evaluationRequest = UserEvaluationRequest()
    let footer = MJRefreshAutoNormalFooter()
    var dataSouceArray = [productEvaluation]()
    var currentPageIndex:Int!
    var average:String!
    var number:String!
    
    
    lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(EvaluateParticularsTableViewCell.self, forCellReuseIdentifier: "EvaluateParticularsTableViewCell")
        tableView.backgroundColor = UIColor.whiteColor()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.title = "用户评价"
        currentPageIndex = 1
        addFooter()
        self.showHUD()
        requestDataSouce()
    }
    
    func addFooter() {
        
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            
            self.getMoreProduct()
        })
    }
    /**请求更多 请求状态*/
    func getMoreProduct() {
        
        tableView.mj_footer.beginRefreshing()
        requestDataSouce()
    }
    
    func hideLoadingMore() {
        tableView.mj_footer.endRefreshing()
        tableView.mj_footer.hidden = true
    }
    
    func requestDataSouce() {
        
        evaluationRequest.userEvaluationRequest(goodsId, page: currentPageIndex, successBlock: { (successJson) in

            self.hideHUD()

            self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {

                self.getMoreProduct()
            })
            
            
            for i in 0..<successJson["data"].count {
                var evaluation = productEvaluation()
                evaluation.mapping(successJson["data"][i])
                self.dataSouceArray.append(evaluation)
            }
        
            self.currentPageIndex = self.currentPageIndex+1
            
            self.tableView.reloadData()
            
            })  { (error) in
                self.hideLoadingMore()
                print(error)
        }
    }
    
}

extension ProductEvaluationViewController:UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSouceArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var evaluation = productEvaluation()
        evaluation = dataSouceArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EvaluateParticularsTableViewCell", forIndexPath: indexPath) as! EvaluateParticularsTableViewCell
        cell.removeObj()
        cell.evaluation = evaluation
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var evaluation = productEvaluation()
        evaluation = dataSouceArray[indexPath.row]
        
        return evaluation.comment!.stringHeightWith(13,width:(ScreenWidth-10))+60
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = AllEvaluationTableViewCell(frame:CGRectMake(0, 0, ScreenWidth, 40))
        headerView.reloadDataSouce(number, average: average)
        return headerView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

}