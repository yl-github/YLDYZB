//
//  UIColor-Extension.swift
//  YLDouYuZB
//
//  Created by yl on 16/9/26.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0);
    }
}
