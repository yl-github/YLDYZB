//
//  YLBaseViewModel.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/18.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLBaseViewModel {
    //MARK:- 懒加载属性（创建数组来存放数据模型）
    lazy var anchorGroupArr : [YLAnchorGroupModel] = [YLAnchorGroupModel]();
}

extension YLBaseViewModel {
    // 发送请求
    func requestBaseAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finisedCallback : @escaping () -> ()){
        YLNetWorkTools.requestData(.get, URLString: URLString, parameters: parameters as! [String : NSString]?) { (result) in
            
            // 将结果转换成字典
            guard let resultDict = result as? [String : Any] else { return }
            // 根据key值得到数组
            guard let dataArr = resultDict["data"] as? [[String : Any]] else { return }
            
            // 这里可能请求到的数据格式不一样，所以这里做个判断（判断data里面是组，还是直接是字典数据）
            if isGroupData {
                // 遍历数组，将数组中的字典转换成字典模型
                for dict in dataArr {
                    self.anchorGroupArr.append(YLAnchorGroupModel(dict: dict));
                }
            }else {
                // 创建一个主播组模型
                let anchorGroup = YLAnchorGroupModel();
                // 遍历dataArray中的所有字典
                for dict in dataArr {
                    anchorGroup.anchorsArr.append(YLAnchorModel(dict: dict));
                }
                self.anchorGroupArr.append(anchorGroup);
            }
            
            // 告诉外界请求数据完成
            finisedCallback();
            
        }
    }

}
