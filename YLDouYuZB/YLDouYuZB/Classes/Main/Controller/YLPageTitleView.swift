//
//  YLPageTitleView.swift
//  YLDouYuZB
//
//  Created by yl on 16/9/21.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kScrollLineH : CGFloat = 2;

class YLPageTitleView: UIView {

    // 定义属性
    private var titles:[String];
    
    // 懒加载属性
    private lazy var titleScrollView:UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        scrollView.bounces = false;
        return scrollView;
    }();
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIScrollView();
        scrollLine.backgroundColor = UIColor.orangeColor();
        return scrollLine;
    }();
    
    private lazy var titleLabels : [UILabel] = [UILabel]();
    
    /**
     *  自定义构造函数  (swfit中自定义构造函数的时候必须重写init?coder函数(required init?(coder aDecoder: NSCoder)))
     */
    init(frame: CGRect,titles:[String]) {
        self.titles = titles;
        
        super.init(frame: frame);
        
        // 设置UI界面
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YLPageTitleView{
    
    private func setupUI(){
        // 1.添加UIScrollView
        addSubview(titleScrollView);
        titleScrollView.frame = bounds;
        
        // 2.添加title对应的Label
        setupTitleLables();
        
        // 3. 设置底线和滚动的滑块
        setupBottomLineAndScrollLine();
    }
    
    private func setupTitleLables(){
        // 0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count);
        let labelH : CGFloat = frame.height - kScrollLineH;
        let labelY : CGFloat = 0;
        
        for (index,title) in titles.enumerate() {
            // 1.创建UILabel
            let label = UILabel();
            
            // 2.设置Label的属性
            label.text = title;
            label.tag = index;
            label.font = UIFont.systemFontOfSize(16.0);
            label.textColor = UIColor.darkGrayColor();
            label.textAlignment = .Center;
            
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index);
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH);
            
            // 4.将label添加到scrollView中
            titleScrollView.addSubview(label);
            titleLabels.append(label);
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        // 1.添加底线
        let bottomLine = UIView();
        bottomLine.backgroundColor = UIColor.lightGrayColor();
        let lineH : CGFloat = 0.5;
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH);
        addSubview(bottomLine);
        
        // 2.添加scrollLine
        // 2.1获取第一个label (guard和if else相似，但不同)
        guard let firstLabel = titleLabels.first else{ return };
        
        firstLabel.textColor = UIColor.orangeColor();
        // 2.2设置添加scrollLine
        titleScrollView.addSubview(scrollLine);
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH);
    }
}