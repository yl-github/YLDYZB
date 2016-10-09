//
//  YLHomeViewController.swift
//  YLDouYuZB
//
//  Created by pj-Macmini on 16/9/20.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40;
class YLHomeViewController: UIViewController {
    // 懒加载属性  -- ()闭包
    private lazy var pageTitleView : YLPageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y:kStatusBarH + kNavigationBarH , width: kScreenW, height: kTitleViewH);
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let titleView = YLPageTitleView(frame: titleFrame, titles: titles);
        titleView.delegate = self;
        return titleView;
    }();
    
    private lazy var pageContentView : YLPageContentView = {[weak self] in
        // 1.确定内容页面的Frame
        let contentViewH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH;
        let contentViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentViewH);
        
        // 2.添加所有的子控制器
        var childVcs = [UIViewController]();
        childVcs.append(YLRecommendationViewController());
        
        for _ in 0..<3 {
            let vc = UIViewController();
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)));
            childVcs.append(vc);
        }
    
        let pageContentView = YLPageContentView(frame: contentViewFrame, childVcs: childVcs, parentViewControlle: self);
        pageContentView.delegate = self;
    
        return pageContentView;
    }();
    
    
    // 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI();
    }
}

// MARK:- 设置UI界面
extension YLHomeViewController {
    private func setupUI(){
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false;
        
        // 1. 设置导航栏
        setupNavigationBar();
        
        // 2. 添加titleView
        view.addSubview(pageTitleView);
        
        // 3. 添加pageContentView
        pageContentView.backgroundColor = UIColor.redColor();
        view.addSubview(pageContentView);
        
    }
    private func setupNavigationBar(){
        
        // 1.设置左侧的Item
//        let btn = UIButton();
//        btn.setImage(UIImage(named: "logo"), forState: .Normal);
//        btn.sizeToFit();
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40);
        
//        let historyBtn = UIButton();
//        historyBtn.setImage(UIImage(named: "image_my_history"), forState: .Normal);
//        historyBtn.setImage(UIImage(named: "Image_my_history_click"), forState: .Highlighted);
//        historyBtn.frame = CGRect(origin: CGPointZero, size: size);
//        let historyItem = UIBarButtonItem(customView: historyBtn);
//        
//        let searchBtn = UIButton();
//        searchBtn.setImage(UIImage(named: "btn_search"), forState: .Normal);
//        searchBtn.setImage(UIImage(named: "btn_search_clicked"), forState: .Highlighted);
//        searchBtn.frame = CGRect(origin: CGPointZero, size: size);
//        let searchItem = UIBarButtonItem(customView: searchBtn);
//        
//        let qrcodeBtn = UIButton();
//        qrcodeBtn.setImage(UIImage(named: "Image_scan"), forState: .Normal);
//        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), forState: .Highlighted);
//        qrcodeBtn.frame = CGRect(origin: CGPointZero, size: size);
//        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn);
        
        /**
         *  方法1. 使用类方法创建item(自己构造的类方法)
         */
 //        let historyItem = UIBarButtonItem.createItem("image_my_history", highImageName: "Image_my_history_click", size: size);
//        
//        let searchItem = UIBarButtonItem.createItem("btn_search", highImageName: "btn_search_clicked", size: size);
//        
//        let qrcodeItem = UIBarButtonItem.createItem("Image_scan", highImageName: "Image_scan_click", size: size);
        
        /**
         *  方法2. 使用构造函数方法创建item
         */
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size);
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size);
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size);
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
    }
    
}

// MRAK:- 遵守PageTitleViewDelegate协议
extension YLHomeViewController : YLPageTitleViewDelegate {
    func pageTitleView(titleView: YLPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index);
    }
}

// MARK:- 遵YLPageContentViewDelegate协议
extension YLHomeViewController : YLPageContentViewDelegate {
    func pageContentView(contentView: YLPageContentView, progress: CGFloat, beforeTitleIndex: Int, targetTitleIndex: Int) {
        pageTitleView.setTitleChangeWithProgress(progress, beforeTitleIndex: beforeTitleIndex, targetTitleIndex: targetTitleIndex);
    }
}


