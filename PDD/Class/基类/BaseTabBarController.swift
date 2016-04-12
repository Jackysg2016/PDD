//
//  BaseTabBarController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cutThePicture()
        setUpTabBarViewControllew()
        /**设置title字体颜色*/
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.redColor()], forState:.Selected)
    }
    /**切割图片*/
    func cutThePicture(){
        let image = UIImage(named: "tabbar-0ddc923383")
        let imageRef = image?.CGImage
        for i in 0 ..< 10 {
            let rect = CGRectMake(CGFloat(i) * 66, 0, 66, 66)
            let newImageRef = CGImageCreateWithImageInRect(imageRef, rect)
            let newImage = UIImage(CGImage: newImageRef!)
            
          let imageSmall =   self.ResizeImage(newImage, targetSize: CGSizeMake(25, 25))
            
            imageArray.append(imageSmall)
        }
    }
    /**压缩图片*/
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /**初始化tabbar*/
    func setUpTabBarViewControllew(){
        
        tabBaraAddChildViewController(HomeViewController(), image: imageArray[0], selectedImage: imageArray[1], title: "首页")
        
        tabBaraAddChildViewController(HotListViewController(), image: imageArray[2], selectedImage: imageArray[3], title: "热榜")
        
        tabBaraAddChildViewController(OverseasViewController(), image: imageArray[4], selectedImage: imageArray[5], title: "海淘")
        
        tabBaraAddChildViewController(SearchViewController(), image: imageArray[6], selectedImage: imageArray[7], title: "搜索")
        
        tabBaraAddChildViewController(PersonageViewController(), image: imageArray[8], selectedImage: imageArray[9], title: "个人中心")
    }
    
    /**设置tabbar*/
    func tabBaraAddChildViewController(vc:UIViewController,image:UIImage,selectedImage:UIImage,title:String){
        
        vc.tabBarItem.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.tabBarItem.selectedImage = selectedImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.title = title
        let navi = BaseNavigationController.init(rootViewController: vc)
        self.addChildViewController(navi)
    }
    
    
}
