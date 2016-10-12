//
//  NSDate-Extension.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/10.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

extension NSDate{
    class func getCurrentTime() -> String{
        // 获取当前的时间
        let nowDate = NSDate();
        // 获取时间戳
        let interval = Int(nowDate.timeIntervalSince1970);
        
        return "\(interval)";
    }
}