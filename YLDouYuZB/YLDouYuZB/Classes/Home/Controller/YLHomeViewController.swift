//
//  YLHomeViewController.swift
//  YLDouYuZB
//
//  Created by pj-Macmini on 16/9/20.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        setupUI();
    }
   
}


// MARK:- 设置UI界面
extension YLHomeViewController {
    private func setupUI(){
    
        // 1. 设置导航栏
        setupNavigationBar();
    }
    private func setupNavigationBar(){
        
        // 1.设置左侧的Item
        let btn = UIButton();
        btn.setImage(UIImage(named: "logo"), forState: .Normal);
        btn.sizeToFit();
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn);
        
        
        // 2.设置左侧的Item
        let size = CGSize(width: 40, height: 40);
        
        let historyBtn = UIButton();
        historyBtn.setImage(UIImage(named: "image_my_history"), forState: .Normal);
        historyBtn.setImage(UIImage(named: "Image_my_history_click"), forState: .Highlighted);
        historyBtn.frame = CGRect(origin: CGPointZero, size: size);
        let historyItem = UIBarButtonItem(customView: historyBtn);
        
        let searchBtn = UIButton();
        searchBtn.setImage(UIImage(named: "btn_search"), forState: .Normal);
        searchBtn.setImage(UIImage(named: "btn_search_clicked"), forState: .Highlighted);
        searchBtn.frame = CGRect(origin: CGPointZero, size: size);
        let searchItem = UIBarButtonItem(customView: searchBtn);
        
        let qrcodeBtn = UIButton();
        qrcodeBtn.setImage(UIImage(named: "Image_scan"), forState: .Normal);
        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), forState: .Highlighted);
        qrcodeBtn.frame = CGRect(origin: CGPointZero, size: size);
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn);
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
    }
    
}