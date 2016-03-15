//
//  FDDSYViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/14.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import Alamofire

class FDDSYViewController: UIViewController, RequestDataDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyanColor()
        self.title = "哈哈哈哈"
        
        let image = UIImage(named: "sprite_item-0ddc923383")
        var imageArray = [UIImage]()
        let imageRef = image?.CGImage
        for var i=0;i<10;i++ {
            let rect = CGRectMake(CGFloat(i) * 66, 0, 66, 66)
            let newImageRef = CGImageCreateWithImageInRect(imageRef, rect)
            let newImage = UIImage(CGImage: newImageRef!)
            imageArray.append(newImage)
        }
        
        let imageView = UIImageView(frame: CGRectMake(10, 10, 40, 40))
        imageView.image = imageArray[1]
        view.addSubview(imageView)

        let homeRequest = RequestData()
        homeRequest.delegate = self
        homeRequest.requestData()
        
    }
    
   
    func request(goods_listArray:NSArray){
    
        print("---------\(goods_listArray.count)")
    
    }


}


