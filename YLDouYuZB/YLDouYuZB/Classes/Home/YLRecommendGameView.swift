//
//  YLRecommendGameView.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/14.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class YLRecommendGameView: UIView {
    //MARK:- 定义属性
    var anchorGroupMArr : [YLAnchorGroupModel]?{
        didSet {
            // 删除组中的前两个数据 （热门和颜值）
            anchorGroupMArr?.removeFirst();
            anchorGroupMArr?.removeFirst();
            
            // 添加更多组
            let moreGroup = YLAnchorGroupModel();
            moreGroup.tag_name = "更多";
            anchorGroupMArr?.append(moreGroup);
            
            // 刷新界面
            collectionView.reloadData();
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- 系统回调方法
    override func awakeFromNib() {
        // 1.移除aotoresizing  ,不让控件随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing();
        
        // 2.注册cell
        collectionView.register(UINib(nibName: "YLCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID);
        
        // 3.设置collectionview的内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin);
    }
}

//MARK:- 定义一个快速创建的gameView的方法
extension YLRecommendGameView {
    class func recommendGameView() -> YLRecommendGameView{
        return Bundle.main.loadNibNamed("YLRecommendGameView", owner: nil, options: nil)!.first as! YLRecommendGameView;
    }
}

//MARK:- 数据源代理方法
extension YLRecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroupMArr?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! YLCollectionGameCell;
        cell.anchorGroupM = anchorGroupMArr![(indexPath as NSIndexPath).item];
        
        return cell;
    }
}
