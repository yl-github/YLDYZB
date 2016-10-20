//
//  YLBaseViewController.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/19.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLBaseViewController: UIViewController {
    // 用来接收collectionview
    var contentView : UIView?
    
    fileprivate lazy var imageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named:"img_loading_1"));
        imageView.center = self.view.center;
        imageView.animationImages = [UIImage(named:"img_loading_1")!,UIImage(named:"img_loading_2")!];
        imageView.animationDuration = 0.5;
        imageView.animationRepeatCount = LONG_MAX;
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin];
        return imageView;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
}
extension YLBaseViewController {
    func setupUI(){
        // 1.隐藏contentview
        contentView?.isHidden = true;
        // 2.添加imageView
        view.addSubview(imageView);
        // 3.设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250);
        // 4.开始动画
        imageView.startAnimating();
    }
    func loadDataFinished(){
        // 1.停止动画
        imageView.stopAnimating();
        // 2.隐藏imageView
        imageView.isHidden = true;
        // 3.显示contentView
        contentView?.isHidden = false;
    }
}
