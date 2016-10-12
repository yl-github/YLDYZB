//
//  YLAnchorGroupModel.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/10.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLAnchorGroupModel: NSObject {
    /** 该组中对应的房间信息（数组）*/
    var room_list : [[String : NSObject]]? {
        
        // didSet属性监听器(监听属性的改变)，一旦监听到属性有改变就执行
        didSet{
            guard let room_list = room_list else{ return }
            for anchorDict in room_list {
                anchorsArr.append(YLAnchorModel(dict: anchorDict));
            }
        }
    }
    
    /** 该组显示的标题 */
    var tag_name : String = ""
    
    /** 该组显示的图标 */
    var icon_url : String = "home_header_normal"
   
    /** 定义主播的对象模型数组 */
    lazy var anchorsArr : [YLAnchorModel] = [YLAnchorModel]();
    
    // 对父类的构造函数重写
    override init() {
        
    }
    // 构造函数
    init(dict : [String : NSObject]) {
        super.init();
        setValuesForKeysWithDictionary(dict);
    }
    
    // 防止多余没用到的属性，在遍历的时候报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
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
}
