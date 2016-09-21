//
//  UIBarButtonItem-Extension.swift
//  YLDouYuZB
//
//  Created by pj-Macmini on 16/9/20.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    // 方法1.直接扩展类方法
//    class func createItem(imageName : String, highImageName : String,size : CGSize) -> UIBarButtonItem{
//        let btn = UIButton();
//        btn.setImage(UIImage(named:imageName), forState: .Normal);
//        btn.setImage(UIImage(named:highImageName), forState: .Highlighted);
//        btn.frame = CGRect(origin: CGPointZero, size: size);
//        return UIBarButtonItem(customView: btn);
//    }
    
    // 方法2.用便利构造器方法
    convenience init(imageName : String, highImageName : String = "",size : CGSize = CGSizeZero) {
        let btn = UIButton();
        btn.setImage(UIImage(named: imageName), forState: .Normal);
        if highImageName != "" {
            
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted);
        }
        if size == CGSizeZero {
            btn.sizeToFit();
        }else {
            btn.frame = CGRect(origin: CGPointZero, size: size);
        }
        self.init(customView:btn);
    }
}