//
//  YLCustomNavController.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/20.
//  Copyright © 2016年 yl. All rights reserved.
//

/////////////////***** 实现全屏pop手势，这里的思想是：利用运行时机制： *****///////////////////
/***            首先我们要先获取到系统帮助我们添加的手势和手势所添加在的那个View上            ***/
/***                      一个系统的手势肯定是有target And action                     ***/
/***            所以这里我们通过运行时机制获取到系统给添加的手势的target 和 action          ***/
/***                    然后来自定义我们的pan手势，并将其添加到view上                    ***/
/***            然后给我们的创建的手势添加获取系统原来手势的target 和 action              ***/

import UIKit

class YLCustomNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的哪个View
        guard let gesView = interactivePopGestureRecognizer?.view else { return }
        
        // 3.获取系统pop手势的target/action
        // 3.1.利用运行时机制查看手势的所有属性名称（class_copyIvarList 是获取属性列表）
        /*
        var outCount : UInt32 = 0 // 这里的outCount可以理解为，是来存放属性的一个数组个数(有多少个属性)
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &outCount)!;
        for i in 0..<outCount {
            let ivar = ivars[Int(i)];
            let name = ivar_getName(ivar);
            print(String(cString: name!));
        }
        */
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]; // 这里打印一下可以知道targets是个数组,里面存放的是对象
        guard let targetObjc = targets?.first else { return }
//        print(targetObjc);
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
//        print(target);
        
        // 3.3.取出action
        let action = Selector(("handleNavigationTransition:"));
        
        // 3.4.创建pan手势
        let panGes = UIPanGestureRecognizer();
        gesView.addGestureRecognizer(panGes);
        panGes.addTarget(target, action: action);
        
    }
}

extension YLCustomNavController {
    // 只要是push都会执这个方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 1.隐藏tabbar (应该在push之前隐藏)
        viewController.hidesBottomBarWhenPushed = true;
        
        // 执行pushViewController这个方法，要调用父类
        super.pushViewController(viewController, animated: true);
        
    }
}
