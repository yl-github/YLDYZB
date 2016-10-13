//
//  YLRecommendCycleView.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/13.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class YLRecommendCycleView: UIView {
    //MARK:- 定义属性
    var cycleModelArr : [YLCycleModel]? {
        // 当从controller中将模型数据专递到这里的时候，我们需要监听属性的改变
        didSet {
            // 1.这里直接reloadData一下，collectionview将会重新走数据源代理方法（在数据源方法里面赋值即可）
            collectionView.reloadData();
            
            // 2.设置pagecontrol的个数
            pageControl.numberOfPages = cycleModelArr?.count ?? 0;
        }
    }
    
    //MARK:- 设置控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 开始加载XIB文件的时候触发
    override func awakeFromNib() {
        super.awakeFromNib();
        //MARK:- 在这里设置不让View随着父控件的拉伸而拉伸
        autoresizingMask = .None;
        
        // 可以在加载xib文件的时候直接注册cell
        collectionView.registerNib(UINib(nibName: "YLCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID);
    }
    
    // 因为xib中collectionview的大小不是真实的大小，真实的大小是我们在外面自己设置的，所以这边在layoutsubview中设置大小才可以得到真实的大小
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.itemSize = collectionView.bounds.size;
        
        //这些属性都在xib中设置也是可以的
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 0;
//        layout.scrollDirection = .Horizontal;
//        collectionView.pagingEnabled = true;
    }
}

//MARK: -提供一个快速创建YLRecommendCycleView的类方法
extension YLRecommendCycleView {
   class func recommendCycleView() -> YLRecommendCycleView {
        // 在这里直接返回xib文件
        return NSBundle.mainBundle().loadNibNamed("YLRecommendCycleView", owner: nil, options: nil).first as! YLRecommendCycleView;
    }
}

//MARK:- 遵守collectionView的datasource协议
extension YLRecommendCycleView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cycleModelArr?.count ?? 0;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleCellID, forIndexPath: indexPath) as! YLCollectionCycleCell;
        let cycleModel = cycleModelArr![indexPath.item];
        cell.cycleModel = cycleModel;
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.yellowColor();
        return cell;
    }
}

//MARK:- 遵守collectionView的delegate协议
extension YLRecommendCycleView : UICollectionViewDelegate {
    
    //MARK:- 监听collectionView的滚动（scrollView的滚动），来计算下面当前的pageControl
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offSetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5;
        
        // 2.计算pageControl当前的currentIndex
        pageControl.currentPage = Int(offSetX / scrollView.bounds.width);
    }
}