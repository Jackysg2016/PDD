//
//  Theme.swift
//  PDD
//
//  Created by 周磊 on 16/3/14.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

// MARK: - 全局常用属性
public let NavigationH: CGFloat = 64
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds: CGRect = UIScreen.mainScreen().bounds

// MARK: - URL
public let HomeUrl:String = "http://apiv2.yangkeduo.com/v2/goods"  //首页
public let SubjectsUrl:String = "http://apiv2.yangkeduo.com/subjects" //滚动图片广告
public let RanklistUrl:String = "http://apiv2.yangkeduo.com/v2/ranklist" // 热榜 － 大家都在买
public let NewlistUrl:String = "http://apiv2.yangkeduo.com/v2/newlist" // 热榜 － 最新
public let RandlistUrl:String = "http://apiv2.yangkeduo.com/v2/randlist" // 热榜 － 猜你喜欢
public let HaitaoUrl:String = "http://apiv2.yangkeduo.com/v2/haitaov2?page=1&size=200" // 海淘
public let OperationsUrl:String = "http://apiv2.yangkeduo.com/operations" // 搜索
public let UserUrl:String = "http://apiv2.yangkeduo.com/user/me" // 个人中心


// MARK: - 全局常用颜色
public let BgColor:UIColor = UIColor(colorLiteralRed: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
public let BorderColor:UIColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1.00)


// MARK: - 首页cell类型
enum CellType {
    case group
    case common
    case advertisement
}
