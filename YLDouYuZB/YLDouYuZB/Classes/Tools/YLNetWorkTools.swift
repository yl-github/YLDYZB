//
//  YLNetWorkTools.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/10.
//  Copyright © 2016年 yl. All rights reserved.
// 
//    ---------  封装Alamofire网络请求  ------------

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}
class YLNetWorkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : NSString]? = nil, finishedCallback : @escaping (_ request : Any) -> ()){
        
        // 1.获取类型
        let methods = type == .get ? HTTPMethod.get : HTTPMethod.post;
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: methods, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else{
                print(response.result.error);
                return;
            }
            
            // 4.将结果回调出去
            finishedCallback(result);
        }
    }
}
