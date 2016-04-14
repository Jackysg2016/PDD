//
//  GoodsDetailsButton.swift
//  PDD
//
//  Created by 周磊 on 16/4/8.
//  Copyright © 2016年 ZL. All rights reserved.
//  自定义button

import UIKit

class GoodsDetailsButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
        return CGRectMake(self.frame.size.width/2-10, contentRect.origin.y+10, 20, 20)
        
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        
        return CGRectMake(self.frame.size.width/2-10, self.frame.size.height-17.5, self.frame.size.width/2, 20)

    }
    
}
