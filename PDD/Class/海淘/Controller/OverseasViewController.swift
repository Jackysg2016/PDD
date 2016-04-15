//
//  OverseasViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class OverseasViewController: BaseViewController {
    
    var tableView:UITableView?
    var homeHeaderView = HomeHeaderView()
    var dataArray = [HaiTaoDataModel]()
    var countryArray = [HomeRollModel]()
    var promotionArray = [HomeRollModel]()
    let header = MJRefreshNormalHeader()
    let haiTaorequset = HaiTaoRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = BgColor
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView!.registerClass(HomeMainTableViewCell.self, forCellReuseIdentifier:"HomeMainTableViewCell")
        tableView!.registerClass(HomeFirstTableViewCell.self, forCellReuseIdentifier:"HomeFirstTableViewCell")
        tableView?.registerClass(HomeAdTableViewCell.self, forCellReuseIdentifier: "HomeAdTableViewCell")
        tableView?.registerClass(HaiTaoCountryTableViewCell.self, forCellReuseIdentifier: "HaiTaoCountryTableViewCell")

        homeHeaderView = HomeHeaderView(frame: CGRectMake(0, 0, ScreenWidth, 200))
        homeHeaderView.delegate = self
        tableView!.tableHeaderView = homeHeaderView;
        view.addSubview(tableView!)

        header.setRefreshingTarget(self, refreshingAction: #selector(RankingTableViewController.headerRefresh))
        tableView!.mj_header = header
        header.lastUpdatedTimeLabel!.hidden = true
        header.stateLabel!.hidden = true
        
        
        haiTaorequset.delegate = self
        tableView!.mj_header.beginRefreshing()
        haiTaorequset.haiTaoRequest()
    }
    
    // 顶部刷新
    func headerRefresh(){
        haiTaorequset.haiTaoRequest()
    }

}

// MARK: - 处理数据
extension OverseasViewController: haiTaoRequestDataDelegate {
    
    func haiTapRequest(haiTaoTotalArray:NSArray,promotionData:[HomeRollModel],countryData:[HomeRollModel]) {
        
        tableView!.mj_header.endRefreshing()
        dataArray = haiTaoTotalArray as! [HaiTaoDataModel]
        promotionArray = promotionData
        countryArray = countryData
        homeHeaderView.reloadData(promotionArray)
        tableView?.reloadData()
        
    }
}

// MARK: - UITableViewDelegate
extension OverseasViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var haiTao = HaiTaoDataModel()
        haiTao = dataArray[indexPath.row]
        
        switch haiTao.cellType {
        case .group:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("HaiTaoCountryTableViewCell", forIndexPath: indexPath) as! HaiTaoCountryTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = BgColor
            cell.releaseData(countryArray)
            
            cell.setBackMyClosure({ (tempClosure) in
                
                self.goToHomeSubjectView(tempClosure)
            })
            
            return cell
            
            
        case .common:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("HomeMainTableViewCell", forIndexPath: indexPath) as! HomeMainTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = BgColor
            cell.removeObj()
            cell.releaseData(haiTao.good_list,secton: indexPath.row)
            
            return cell
            
        default:
            
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("HomeAdTableViewCell", forIndexPath: indexPath) as! HomeAdTableViewCell
            cell.backgroundColor = BgColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.releaseHomeAdData(haiTao.home_recommend, homeRecommend: haiTao.home_recommend.goodsList)
            cell.delegate = self
            return cell
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var haitao = HaiTaoDataModel()
        haitao = dataArray[indexPath.row]
        
        switch haitao.cellType {
        case .group:
            return 100
        case .common:
            let  height=haitao.good_list.goods_name!.stringHeightWith(15,width:(ScreenWidth-20))
            return (180 + 85 + height)
            
        default:
            return 280
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var haitao = HaiTaoDataModel()
        haitao = dataArray[indexPath.row]
        
        if haitao.cellType == .common {
            
            let goodsSubject = GoodsDetailsViewController()
            goodsSubject.title = haitao.good_list.goods_name
            goodsSubject.goodsId = haitao.good_list.goods_id
            goodsSubject.mallId = haitao.good_list.mall_id
            goodsSubject.isSearchGoInto = false
            goodsSubject.isStoreInformationGoInto = false
            self.navigationController?.pushViewController(goodsSubject, animated: true)
            
        }else if haitao.cellType == .advertisement{
            
            let homeSubject = HomeSubjectViewController()
            
            homeSubject.title = haitao.home_recommend.subject!
            homeSubject.subjectID = haitao.home_recommend.subject_id!
            homeSubject.bgImageString = nil
            homeSubject.isGoodsDetailsGoInto = false
            self.navigationController?.pushViewController(homeSubject, animated: true)
            
        }else {
            
            return
        }

    }

    
    
    func goToHomeSubjectView(homeRoll:HomeRollModel) {
        
        let homeSubject = HomeSubjectViewController()
        homeSubject.title = homeRoll.subject
        homeSubject.subjectID = homeRoll.subject_id
        homeSubject.bgImageString = nil
        homeSubject.isGoodsDetailsGoInto = false
        self.navigationController?.pushViewController(homeSubject, animated: true)
        
    }
}

// MARK: - 中间广告点击事件
extension OverseasViewController: ClickCollectionCallbackDelegate {
    
    func requestResult(home_recommend_goodlist:home_recommend_goodlistModel) {
        
        let goodsSubject = GoodsDetailsViewController()
        goodsSubject.title = home_recommend_goodlist.goods_name
        goodsSubject.goodsId = home_recommend_goodlist.goods_id
        goodsSubject.mallId = home_recommend_goodlist.mall_id
        goodsSubject.isSearchGoInto = false
        goodsSubject.isStoreInformationGoInto = false
        self.navigationController?.pushViewController(goodsSubject, animated: true)
        
    }
}
// MARK: - 滚动图片点击事件
extension OverseasViewController: HomeHeaderDelegate {
    
    func homeHeaderRequestResult(homeRollData:HomeRollModel) {
        
        let homeSubject = HomeSubjectViewController()
        homeSubject.title = homeRollData.subject
        homeSubject.subjectID = homeRollData.subject_id
        homeSubject.bgImageString = homeRollData.home_banner
        homeSubject.isGoodsDetailsGoInto = false
        self.navigationController?.pushViewController(homeSubject, animated: true)
    }
}



