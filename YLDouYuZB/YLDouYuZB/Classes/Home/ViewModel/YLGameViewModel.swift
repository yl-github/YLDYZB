//
//  YLGameViewModel.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/17.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLGameViewModel {
    /** 存放game所有模型数据的数组 */
    lazy var gameDataArr : [YLGameModel] = [YLGameModel]();
    
}

extension YLGameViewModel {
    // 发送请求
    func loadAllGameData(finishedCallBack: @escaping ()->()){
        YLNetWorkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            // 1.获取数据
            guard let resultDict = result as? [String : Any] else {return};
            guard let dataArr = resultDict["data"] as? [[String : Any]] else{return};
            
            // 2.字典转模型
            for dict in dataArr {
               self.gameDataArr.append(YLGameModel(dict: dict));
            }
            
            // 3.通知外界，已经请求完成
            finishedCallBack();
        }
    }
}
