//
//  YLCollectionCycleCell.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/13.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
import Kingfisher

class YLCollectionCycleCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var cycleImg: UIImageView!
    @IBOutlet weak var cycleTitleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var cycleModel : YLCycleModel?{
        didSet{
            // 1.设置标题内容
            cycleTitleLabel.text = cycleModel?.title;
            // 2.设置图片
            let imgUrl = URL(string: cycleModel?.pic_url ?? "");
            cycleImg.kf.setImage(with: imgUrl, placeholder: UIImage(named: "Img_default"));
        }
    }
    
}
