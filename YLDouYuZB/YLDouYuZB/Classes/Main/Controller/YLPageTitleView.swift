//
//  YLPageTitleView.swift
//  YLDouYuZB
//
//  Created by yl on 16/9/21.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
// 写 :class 主要是表示只想让类遵守这个协议
protocol YLPageTitleViewDelegate : class {
    // 其中selectedIndex是表示一个外部参数，index则表示一个内部参数
    func pageTitleView(titleView : YLPageTitleView,selectedIndex index : Int);
}
private let kScrollLineH : CGFloat = 2;

class YLPageTitleView: UIView {

    // 定义属性 -- 这里的定义属性，相当于OC中的@property(strong,)定义属性
    private var currentIndex : Int = 0;
    private var titles:[String];
    weak var delegate : YLPageTitleViewDelegate?
    
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
            
            // 5.给label添加手势可以进行交互
            label.userInteractionEnabled = true;
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)));
            label.addGestureRecognizer(tapGes);
            
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

//MARK:- 监听label的点击
extension YLPageTitleView{
    // 使用事件处理的时候前面要加上@objc
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        // 1.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {return};
        
        // 2.获取之前的Label
        let afterLabel = titleLabels[currentIndex];
        
        // 3.更改label的字体颜色
        currentLabel.textColor = UIColor.orangeColor();
        afterLabel.textColor = UIColor.grayColor();
        
        // 4.保存最新的label下标值
        currentIndex = currentLabel.tag;
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.size.width;
        UIView.animateWithDuration(0.15) {
            self.scrollLine.frame.origin.x = scrollLineX;
        }
        
        // 6.通知代理做事情
        delegate?.pageTitleView(self, selectedIndex: currentIndex);
    }
}





















