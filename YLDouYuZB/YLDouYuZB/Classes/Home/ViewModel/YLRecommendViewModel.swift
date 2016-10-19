//
//  YLRecommendViewModel.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/10.
//  Copyright © 2016年 yl. All rights reserved.
//

/********************** dispatch_group 的介绍和作用  ： *************************************/

/********************* 
 
 dispatch_group的作用：创建一个任务组，然后异步执行加入group的每个任务。比如如果用group管理3个任务的执行，那么这3个任务的执行顺序会同时执行。
 dispatch_enter的作用：创建好任务组后，执行加入任务组的操作代码。dispatch_enter和dispatch_leave要成对出现，否则奔溃
 
 *********************/

import UIKit

class YLRecommendViewModel : YLBaseViewModel{
    //MARK:- 懒加载属性
    /** 存放轮播数据的数组 */
    lazy var cycleArr : [YLCycleModel] = [YLCycleModel]();
    
    // 创建组（Model类型）,将热门和颜值中的数据存放到组的数组当中
    fileprivate let hotGroup : YLAnchorGroupModel = YLAnchorGroupModel();
    fileprivate let prettyGroup : YLAnchorGroupModel = YLAnchorGroupModel();
}

//MARK:- 发送网络请求
extension YLRecommendViewModel {
    // 发送请求----请求推荐页面不带轮播图的数据
    func requestData(_ finishCallback : @escaping ()->()){
        // 0.参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()];
        
        // 1.因为我们现在不确定这三个请求的数据哪个会先请求完成，所以我们在这边创建一个组队列，等三个请求都完成之后我们在对这三个数据进行排序。
        let dispatchGroup = DispatchGroup();
        
        // 请求开始之前将组队列进入组中
        dispatchGroup.enter();
        
        // 第一部分：请求推荐数据
            YLNetWorkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime() as NSString]) { (request) in
                
                // 1.这里的reqest是个AnyObject类型,所以要先将request转换成字典
                guard let dataDict = request as? [String : NSObject] else{ return }
                
                // 2.获取字典中的数组
                guard let dataArray = dataDict["data"] as? [[String : NSObject]] else{ return }
                
                // 3.遍历数组，得到数组中的字典，然后将字典转换成字典模型
                // 3.1 设置初始值属性
                self.hotGroup.tag_name = "热门";
                self.hotGroup.icon_name = "home_header_hot";
                
                for dict in dataArray {
                    
                    let anchorModel = YLAnchorModel(dict: dict);
                    self.hotGroup.anchorsArr.append(anchorModel);
                }
                
                // 4.请求完之后，离开任务组
                dispatchGroup.leave();
            }
        
        // 请求开始之前将组队列放入当中
        dispatchGroup.enter();
        // 第二部分：请求颜值数据
        YLNetWorkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters as [String : NSString]?) { (request) in
            
            // 1.这里的reqest是个AnyObject类型,所以要先将request转换成字典
            guard let dataDict = request as? [String : NSObject] else{return}
            
            // 2.获取字典中的数组
            guard let dataArray = dataDict["data"] as? [[String : NSObject]] else{ return }
            
            // 3.遍历数组，得到数组中的字典，然后将字典转换成字典模型
            // 3.1 设置初始值属性
            self.prettyGroup.tag_name = "颜值";
            self.prettyGroup.icon_name = "home_header_phone";
            
            for dict in dataArray {
                
                let anchorModel = YLAnchorModel(dict: dict);
                self.prettyGroup.anchorsArr.append(anchorModel);
            }
            
            // 4.求完之后，离开任务组
            dispatchGroup.leave();
        }
        
        // 请求开始之前将组队列放入当中
        dispatchGroup.enter();
        // 第三部分：请求其他游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1476080122
        requestBaseAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            
            dispatchGroup.leave();
        }
        
        // 所有的数据都请求到之后，对数据进行一个排序
        // dispatch_group_notify 监听所有的异步请求全部请求到
        dispatchGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroupArr.insert(self.prettyGroup, at: 0);
            self.anchorGroupArr.insert(self.hotGroup, at: 0);
            
            finishCallback();
        }
        
    }
    
    // 请求无限轮播图的数据
    func requestCycleViewData(_ finishCallback : @escaping ()->()){
        // http://www.douyutv.com/api/v1/slide/6?version=2.303
        YLNetWorkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.303"]) { (request) in
            
            // 将request转换成字典类型 (这里因为是选择链，所以校验一下是否有值，没有直接return出去)
            guard let resultDict = request as? [String : NSObject] else { return }
            
            // 根据key值获取data数组 （这里也需要校验一下是否有值）
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 便利数组得到数据
            for dict in dataArray {
                let cycleM = YLCycleModel(dict: dict);
                self.cycleArr.append(cycleM);
            }
            
            // 告诉外界，已经请求完成 ( 闭包回调)
            finishCallback();
        }
    }
    
}

























