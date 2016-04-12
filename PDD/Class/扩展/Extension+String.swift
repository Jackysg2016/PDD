//
//  Extension+String.swift
//  PDD
//
//  Created by 周磊 on 16/3/16.
//  Copyright © 2016年 ZL. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    //MARK:获取string内容的高度
    
    func stringHeightWith(fontSize:CGFloat,width:CGFloat)->CGFloat{
        
        let font = UIFont.systemFontOfSize(fontSize)
        
        let size = CGSizeMake(width,CGFloat.max)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self 
        
        let rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }
    
    func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        let timeSta:NSTimeInterval = string.doubleValue
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="MM月dd日HH:mm"
        let date = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.stringFromDate(date)
    }
    
}
extension NSInteger {
    
    //MARK:时间戳转时间
    
    func timeStampToInteger(timeStamp:NSInteger)->NSDate {
        
        let timeSta:NSTimeInterval = Double(timeStamp)
        
        let dfmatter = NSDateFormatter()
        
        dfmatter.dateFormat="yyyy年MM月dd日 HH时mm分ss秒"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return date
        
    }
    
}







