//
//  GoodsDetailsViewController.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品详情

import UIKit
import SwiftyJSON
import SKPhotoBrowser

class GoodsDetailsViewController: BaseViewController {
    
        /// 是否是搜索页进来的，搜索页的商家id是在请求后得来的
    var isSearchGoInto:Bool!
    
    /// 判断是不是从店铺信息界面跳转进来的，如果是从店铺信息页跳转进来的，再次点击店铺信息的时候要返回上一层
    var isStoreInformationGoInto:Bool!
    
    
    /// 商品id
    var goodsId:String!
    /// 商家id
    var mallId:String!
    let goodsRequest = GoodsDetailsrequest()
    let goodsDetailsModel = GoodsDetailsModel()

    var goodsJson:JSON!
    var mallJson:JSON!
    var reviewsJson:JSON!
    var recommendationJson:JSON!
    var lucky_drawJson:JSON!
    var collectionSection:Int?
    var basicDataArray = [basicInformation]()
    var basic = basicInformation()
    
    var scrollerImageArray = [imagesInformation]()
    var imageArray = [imagesInformation]()
    
    var headView = GoodsDetailsHeadView()
    
    lazy var bottomView:GoodsDetailsBottomView = {
        let bottomView = GoodsDetailsBottomView(frame:CGRectMake(0,ScreenHeight-45,ScreenWidth,45))
        bottomView.setclickblockClosure {
            print("团购")
        }
        bottomView.setaloneClickblockClosure {
            print("单独购买")
        }
        bottomView.setbuttonBlockClosure { (value) in
            switch value {
            case 1:///首页
                self.navigationController?.popToRootViewControllerAnimated(true)
            case 2:
                print("收藏")
            default:
                print("客服")
            }
        }
        return bottomView
    }()

    lazy var collectionView:UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-45),collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        collectionView.backgroundColor = BgColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.registerClass(PricesAndSalesCell.self, forCellWithReuseIdentifier: "PricesAndSalesCell")
        collectionView.registerClass(GoodsNameCell.self, forCellWithReuseIdentifier: "GoodsNameCell")
        collectionView.registerClass(GoodsDescCell.self, forCellWithReuseIdentifier: "GoodsDescCell")
        collectionView.registerClass(LotteryRulesCell.self, forCellWithReuseIdentifier: "LotteryRulesCell")
        collectionView.registerClass(ImportedGoodsCell.self, forCellWithReuseIdentifier: "ImportedGoodsCell")
        collectionView.registerClass(AllowedRegionCell.self, forCellWithReuseIdentifier: "AllowedRegionCell")
        collectionView.registerClass(GroupSpecificationCell.self, forCellWithReuseIdentifier: "GroupSpecificationCell")
        collectionView.registerClass(GroupBuyingCell.self, forCellWithReuseIdentifier: "GroupBuyingCell")
        collectionView.registerClass(GroupPurchaseCell.self, forCellWithReuseIdentifier: "GroupPurchaseCell")
        collectionView.registerClass(EvaluateCell.self, forCellWithReuseIdentifier: "EvaluateCell")
        collectionView.registerClass(EvaluateParticularsCell.self, forCellWithReuseIdentifier: "EvaluateParticularsCell")
        collectionView.registerClass(StoreCell.self, forCellWithReuseIdentifier: "StoreCell")
        collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.registerClass(GoodsDetailsHeadView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "GoodsDetailsHeadView")
        collectionView.registerClass(MayLoveCell.self, forCellWithReuseIdentifier: "MayLoveCell")
        collectionView.registerClass(RecommendedGoodsCell.self, forCellWithReuseIdentifier: "RecommendedGoodsCell")
        collectionView.registerClass(BottomCell.self, forCellWithReuseIdentifier: "BottomCell")

        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        self.showHUD()
        dataAccess()
    }
    
    func dataAccess() {
        
        let goodsViewModel = GoodsDetailsViewModel()
        
        goodsViewModel.request(self.goodsId, mallId: self.mallId, isSearchGoInto: self.isSearchGoInto, successBlock: { (goodsJson, mallJson, reviewsJson, recommendationJson, lucky_drawJson, basicDataArray, scrollerImageArray, imageArray) in
            
            self.hideHUD()
            self.view.addSubview(self.bottomView)

            self.basicDataArray.removeAll()
            self.basicDataArray = basicDataArray
            self.scrollerImageArray.removeAll()
            self.scrollerImageArray = scrollerImageArray
            self.imageArray.removeAll()
            self.imageArray = imageArray
            self.goodsJson = goodsJson
            self.mallJson = mallJson
            self.reviewsJson = reviewsJson
            self.recommendationJson = recommendationJson
            self.lucky_drawJson = lucky_drawJson
            
            dispatch_async(dispatch_get_main_queue(), { 
                
                self.collectionView.reloadData()
                self.bottomView.basicDataSouce = goodsJson
            })
            
            }) { (error) in
                self.showErrorAllTextDialog("出错了")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension GoodsDetailsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GoodsDetailsHeadDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return basicDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var basic = basicInformation()
        basic = basicDataArray[indexPath.row]
        
        switch basic.cellType {
        case .pricesAndSales:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PricesAndSalesCell", forIndexPath: indexPath) as! PricesAndSalesCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
            
        case .goodsName:
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GoodsNameCell", forIndexPath: indexPath) as! GoodsNameCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
            
        case .goodsDesc:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GoodsDescCell", forIndexPath: indexPath) as! GoodsDescCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .lotteryRules:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LotteryRulesCell", forIndexPath: indexPath) as! LotteryRulesCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .importedGoods:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImportedGoodsCell", forIndexPath: indexPath) as! ImportedGoodsCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .allowedRegion:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AllowedRegionCell", forIndexPath: indexPath) as! AllowedRegionCell
            cell.backgroundColor = BgColor
            return cell
        case .groupSpecification:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupSpecificationCell", forIndexPath: indexPath) as! GroupSpecificationCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.basicDataSouce = self.goodsJson
            return cell
        case .groupBuying:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupBuyingCell", forIndexPath: indexPath) as! GroupBuyingCell
            cell.backgroundColor = BgColor
            return cell
        case .groupPurchaseDetails:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupPurchaseCell", forIndexPath: indexPath) as! GroupPurchaseCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.reloadDataSouce(basic.groupPurchaseDetails!)
            return cell
        case .evaluate:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EvaluateCell", forIndexPath: indexPath) as! EvaluateCell
            cell.evaluateDataSouce = self.reviewsJson
            return cell
        case .evaluateParticulars:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EvaluateParticularsCell", forIndexPath: indexPath) as! EvaluateParticularsCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.evaluateParticularsDataSouce = basic.evaluateInformation!
            return cell
        case .store:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StoreCell", forIndexPath: indexPath) as! StoreCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.storeDataSouce = basic.shopMation!
            return cell
        case .image:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
            cell.backgroundColor = UIColor.cyanColor()
            cell.imageDataSouce = basic.imagesInformn!
            return cell
        case .mayLove:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MayLoveCell", forIndexPath: indexPath) as! MayLoveCell
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        case .recommendedGoods:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecommendedGoodsCell", forIndexPath: indexPath) as! RecommendedGoodsCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.recommend = basic.recommendInformn!
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BottomCell", forIndexPath: indexPath) as! BottomCell
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var basic = basicInformation()
        basic = basicDataArray[indexPath.row]
        return CGSizeMake(basic.cellWidth ,basic.cellHeight)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: ScreenWidth, height: 230)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            headView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "GoodsDetailsHeadView", forIndexPath: indexPath) as! GoodsDetailsHeadView
            headView.reloadData(scrollerImageArray)
            headView.delegate = self
            return headView
            
        case UICollectionElementKindSectionFooter:
            
            return UICollectionReusableView()
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var basic = basicInformation()
        basic = basicDataArray[indexPath.row]
        
        switch basic.cellType {
        case .groupPurchaseDetails:///团购详情
            
            print(basic.groupPurchaseDetails)
            
        case .evaluate:///用户评价
            
            let evaluateView = ProductEvaluationViewController()
            evaluateView.goodsId = goodsId
            evaluateView.average = String(self.reviewsJson["average"])
            evaluateView.number = String(self.reviewsJson["number"])
            self.navigationController?.pushViewController(evaluateView, animated: true)
            
        case .store:///店铺信息
            
            if isStoreInformationGoInto == true {
                
                self.navigationController?.popViewControllerAnimated(true)
                
            }else {
                
                let homeSubject = HomeSubjectViewController()
                homeSubject.StoreInformation = self.mallJson
                homeSubject.isGoodsDetailsGoInto = true
                homeSubject.title = String(self.mallJson["mall_name"])
                self.navigationController?.pushViewController(homeSubject, animated: true)
                
            }
            
            
        case .recommendedGoods:///推荐的商品
            
            let goodsSubject = GoodsDetailsViewController()
            goodsSubject.title = basic.recommendInformn!.goods_name
            goodsSubject.goodsId = basic.recommendInformn!.goods_id
            goodsSubject.mallId = basic.recommendInformn!.mall_id
            goodsSubject.isSearchGoInto = false
            goodsSubject.isStoreInformationGoInto = false
            self.navigationController?.pushViewController(goodsSubject, animated: true)
            
        default:
            return
        }
    }
    
    
    func GoodsDetailsHeadRequestResult(page:Int) {
        
        var images = [SKPhoto]()
        
        for i in 0 ..< scrollerImageArray.count {
            var showImage = imagesInformation()
            showImage = scrollerImageArray[i]
            let photo = SKPhoto.photoWithImageURL(showImage.url!)
            photo.shouldCachePhotoURLImage = false
            images.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(page)
        browser.displayBackAndForwardButton = false   //回/前进按钮将被隐藏
        browser.displayAction = false //操作按钮将被隐藏
        presentViewController(browser, animated: true, completion: {})
        
    }
}

// MARK: - 无数据时展示
extension GoodsDetailsViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    func customViewForEmptyDataSet(scrollView: UIScrollView!) -> UIView! {
        
            let emptyViewGound = UIView(frame: CGRectMake(0,0,ScreenWidth,ScreenHeight))
            emptyViewGound.backgroundColor = UIColor.whiteColor()
            return emptyViewGound
    }
}

