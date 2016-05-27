//
//  PersonageViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonageViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var collectionView:UICollectionView?
    var personage = PersonageModel()
    let header = MJRefreshNormalHeader()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BgColor
        setUpConnectionView()
        
    }
    
    func setUpConnectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight),collectionViewLayout: flowLayout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = BgColor
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.registerClass(PersonTypeCellOne.self, forCellWithReuseIdentifier: "PersonTypeCellOne")
        collectionView?.registerClass(PersonTypeCellTwo.self, forCellWithReuseIdentifier: "PersonTypeCellTwo")
        collectionView?.registerClass(PersonTypeCellThree.self, forCellWithReuseIdentifier: "PersonTypeCellThree")
        collectionView?.registerClass(PersonTypeCellFour.self, forCellWithReuseIdentifier: "PersonTypeCellFour")
        self.view.addSubview(collectionView!)
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(RankingTableViewController.headerRefresh))
        header.lastUpdatedTimeLabel!.hidden = true
        header.stateLabel!.hidden = true
        collectionView!.mj_header = header
        
    }
    
    func headerRefresh(){
        
        collectionView!.mj_header.endRefreshing()

    }
    
    
    func lalalalala(collection:BaseViewController,dataArray:[String],dataDict:[String:AnyObject]) {
        
        
    }
    
    
    
    
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if (indexPath.section == 0) {
            return CGSizeMake(ScreenWidth ,120)
        }
        else if (indexPath.section == 1) {
            return CGSizeMake(ScreenWidth ,50);
        }else if indexPath.section == 2 {
            return CGSizeMake((ScreenWidth-4)/4 ,70);
            
        }else if indexPath.section == 3 {
            
            return CGSizeMake((ScreenWidth-4)/4 ,100)
        }else {
            return CGSizeMake(ScreenWidth ,50)
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        
        return 5
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        if section==0 || section==1 {
            
            return 1
            
        }else if section == 2  {
            
            return personage.segmentTitleArray.count
            
        }else if section == 3 {
            
            return personage.itemNameArray.count
            
        }else {
            return 1
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if (section == 1) {
            return CGSizeMake(0, 2)
        }
        else {
            return CGSizeMake(ScreenWidth, 10)
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section==1 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonTypeCellTwo", forIndexPath: indexPath) as! PersonTypeCellTwo
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        }  else if indexPath.section==2 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonTypeCellThree", forIndexPath: indexPath) as! PersonTypeCellThree
            cell.backgroundColor = UIColor.whiteColor()
            cell.typeCellThreeReloadData(personage.segmentTitleArray[indexPath.row], imageName: personage.segmentImageArray[indexPath.row],section: indexPath.section)
            
            return cell
        } else if indexPath.section == 3 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonTypeCellThree", forIndexPath: indexPath) as! PersonTypeCellThree
            cell.backgroundColor = UIColor.whiteColor()
            cell.typeCellThreeReloadData(personage.itemNameArray[indexPath.row], imageName: personage.itemImageArray[indexPath.row],section: indexPath.section)
            
            return cell
            
        }else if indexPath.section == 4 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonTypeCellFour", forIndexPath: indexPath) as! PersonTypeCellFour
            cell.backgroundColor = UIColor.whiteColor()
            
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonTypeCellOne", forIndexPath: indexPath) as! PersonTypeCellOne
            cell.backgroundColor = UIColor.whiteColor()
            
            cell.reloadData("\(indexPath.row)")
            
            return cell
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
            
        case 0:///点击头像登录
            print(indexPath.section)
            
            let pop = UIPopoverListView.init(frame: CGRectMake(10, 100, ScreenWidth-100, 200))
            pop.center = self.view.center
            pop.listView.scrollEnabled = false
            pop.titleView.text = "选择不喜欢的理由"
            pop.show()
            
        case 1:///我的订单
            
            print(indexPath.section)
            let webView = WebViewController()
            
            self.navigationController?.pushViewController(webView, animated: true)
            
            

        case 2:
            
            switch indexPath.row {
            case 0:///代付款
                print(indexPath.row)
                
            case 1:///代发货
                print(indexPath.row)
                
            case 2:///待收货
                print(indexPath.row)
                
            default:///待评价
                print(indexPath.row)
                
            }
            
        case 3:
            
            switch indexPath.row {
            case 0:///我的团
                print(indexPath.row)
            case 1:///我的抽奖
                print(indexPath.row)
            case 2:///我的收藏
                print(indexPath.row)
            case 3:///我的优惠券
                print(indexPath.row)
            case 4:///收货地址
                print(indexPath.row)
            case 5:///我的消息
                print(indexPath.row)
            default:///常见问题
                print(indexPath.row)
                
            }
        
        default:///点击登录
            print(indexPath.section)

        }
    }
    
}

