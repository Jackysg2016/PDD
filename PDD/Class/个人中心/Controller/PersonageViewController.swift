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
        
        print(ScreenWidth)
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
        self.view.addSubview(collectionView!)
        
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(RankingTableViewController.headerRefresh))
        header.lastUpdatedTimeLabel!.hidden = true
        header.stateLabel!.hidden = true
        collectionView!.mj_header = header
        
    }
    
    func headerRefresh(){
        
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
            cell.typeCellThreeReloadData(personage.segmentTitleArray[indexPath.row], imageName: personage.segmentImageArray[indexPath.row])
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonTypeCellOne", forIndexPath: indexPath) as! PersonTypeCellOne
            cell.backgroundColor = UIColor.whiteColor()
            
            cell.reloadData("\(indexPath.row)")
            
            return cell
        }
    
        
        
    }
    
}

