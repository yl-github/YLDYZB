//
//  YLBaseGameModel.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/17.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLBaseGameModel: NSObject {
    
    /** Game标题 */
    var tag_name : String = ""
    
    /** Game图标 */
    var icon_url : String = ""
    
    // 对父类的构造函数重写
    override init() {
        
    }
    // 构造函数
    init(dict : [String : Any]) {
        super.init();
        
        setValuesForKeys(dict);
    }
    /*
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for anchorDict in dataArray {
                    anchorsArr.append(YLAnchorModel(dict: anchorDict));
                }
            }
        }
    }
    */
    
    // 防止多余没用到的属性，在遍历的时候报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
