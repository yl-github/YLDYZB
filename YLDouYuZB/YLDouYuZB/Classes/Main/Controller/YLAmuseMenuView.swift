//
//  YLAmuseMenuView.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/18.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

private let kAmuseCellID = "kAmuseCellID"
class YLAmuseMenuView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK:- 定义属性
    var anchorGroupsMArr : [YLAnchorGroupModel]? {
        didSet {
            collectionView.reloadData();
        }
    }
    
    //MARK:- xib加载
    override func awakeFromNib() {
        super.awakeFromNib();
        
        autoresizingMask = UIViewAutoresizing();
        collectionView.register(UINib(nibName: "YLCollectionAmuseCell", bundle: nil), forCellWithReuseIdentifier: kAmuseCellID)
    }
    // 在layoutSubviews里才可以拿到collectionview真实的大小
    override func layoutSubviews() {
        super.layoutSubviews();
        let layout  = collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.itemSize = collectionView.bounds.size;
    }
}

//MARK:- 快速创建
extension YLAmuseMenuView {
    class func amuseMenuView() -> YLAmuseMenuView{
        return Bundle.main.loadNibNamed("YLAmuseMenuView", owner: nil, options: nil)?.first as! YLAmuseMenuView;
    }
}

//MARK:- 代理协议
extension YLAmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if anchorGroupsMArr == nil {
            return 0;
        }
        let pageNum = (anchorGroupsMArr!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum;
        return pageNum;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseCellID, for: indexPath) as! YLCollectionAmuseCell;
        // 2.给cell设置数据
//        cell.anchorGroupsMArr = anchorGroupsMArr;
        setupCellDataWithCell(cell: cell, indexPath: indexPath);
        
        return cell
    }
    
    //MARK:- ******* 因为涉及到两页数据的问题，所以这里抽出这样一个方法来传递数据 *******
    private func setupCellDataWithCell(cell : YLCollectionAmuseCell, indexPath : IndexPath){
        // 第0页: 0-7个item
        // 第1页: 8-15个item
        // 第2页: 16-23个item
        // 1.取出起始位置和终点位置
        let startIndex = indexPath.item * 8;
        var endIndex = (indexPath.item + 1) * 8 - 1;
        
        // 2.判断越界问题
        if endIndex > anchorGroupsMArr!.count - 1{
            endIndex = anchorGroupsMArr!.count - 1;
        }
        
        // 3.取出数据，并且复制给cell
        cell.anchorGroupsMArr = Array(anchorGroupsMArr![startIndex...endIndex]);
    }
}

//MARK:- 遵守代理协议
extension YLAmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int((scrollView.contentOffset.x + scrollView.bounds.width * 0.5) / scrollView.bounds.width);
    }
}
