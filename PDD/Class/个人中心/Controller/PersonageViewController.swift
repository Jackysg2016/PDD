//
//  PersonageViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonageViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var collectionView:UICollectionView?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func setUpConnectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.itemSize = CGSizeMake(80,80)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        collectionView?.collectionViewLayout = flowLayout
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.registerClass(PersonCollectionViewCell.self, forCellWithReuseIdentifier: "PersonCollectionViewCell")

        self.view.addSubview(collectionView!)
        
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonCollectionViewCell", forIndexPath: indexPath) as! PersonCollectionViewCell
        cell.backgroundColor = UIColor.cyanColor()
        cell.nameLabel.text = "\(indexPath.row)"
        return cell
        
    }
    
}

