//
//  YLCollectionAmuseCell.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/18.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kGameCellID = "kGameCellID"

class YLCollectionAmuseCell: UICollectionViewCell {
    //MARK:- 设置属性
    var anchorGroupsMArr : [YLAnchorGroupModel]?{
        didSet {
            collcetionView.reloadData();
        }
    }
    
    @IBOutlet weak var collcetionView: UICollectionView!
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collcetionView.register(UINib(nibName: "YLCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let layout = collcetionView.collectionViewLayout as! UICollectionViewFlowLayout;
        let itemW = collcetionView.bounds.width / 4;
        let itemH = collcetionView.bounds.height / 2;
        layout.itemSize = CGSize(width: itemW, height: itemH);
    }
}

extension YLCollectionAmuseCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return anchorGroupsMArr?.count ?? 0;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! YLCollectionGameCell;
        // 2.设置数据
        cell.gameGroupM = anchorGroupsMArr?[indexPath.item];
        cell.clipsToBounds = true;
        return cell;
        
    }
}
