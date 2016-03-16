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
}
