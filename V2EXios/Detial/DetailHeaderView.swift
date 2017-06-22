//
//  DetailHeaderView.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/22.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import YYText
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import Result
class DetailHeaderView: UIView {
    fileprivate var titleLab : UILabel
    fileprivate var contentLab : YYLabel
    fileprivate var avatarView : UIImageView
    fileprivate var userLab : UILabel
    fileprivate var timeLab : UILabel
    
    fileprivate let heightObset : Observer<CGFloat,NoError>
    let hetightSignal : Signal<CGFloat,NoError>
    
    var viewModel:DetailViewModel!{
        didSet{
            titleLab.text = viewModel.model.title
            avatarView.sd_setImage(with: URL.init(string:viewModel.model.member?.avatar_large ?? ""), placeholderImage: placeholder_Image)
            userLab.text = viewModel.model.member?.username
            timeLab.text = Date.returnTimeString(WithTimestamp: Int(viewModel.model.created))
           
            //异步布局排版
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    let layout = self.viewModel.caculateLayOut()
                    let size = self.viewModel.model.title?.sizeWithFont(UIFont.systemFont(ofSize: 14))
                    self.contentLab.textLayout = layout
                    self.heightObset.send(value: (layout.textBoundingSize.height) + (size?.height)! + 110)
                }
                
            }
            
        }
    }
    
    override init(frame: CGRect) {
        titleLab = UILabel()
        contentLab = YYLabel()
        avatarView = UIImageView()
        userLab = UILabel()
        timeLab = UILabel()
        let (signal,observe) = Signal<CGFloat,NoError>.pipe()
        self.heightObset = observe
        self.hetightSignal = signal

        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.autoresizesSubviews = true 
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints({
            $0.left.equalTo(25)
            $0.right.equalTo(-25)
            $0.top.equalTo(15)
            $0.height.greaterThanOrEqualTo(20).priority(.low)
        })
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.textColor = UIColor.black
        titleLab.numberOfLines = 0
        self.addSubview(contentLab)
        contentLab.snp.makeConstraints({
            $0.left.equalTo(25)
            $0.top.equalTo(titleLab.snp.bottom).inset(-15)
            $0.right.equalTo(-25)
        })
        contentLab.displaysAsynchronously = true
        contentLab.ignoreCommonProperties = true
        
        self.addSubview(avatarView)
        avatarView.snp.makeConstraints({
            $0.left.equalTo(15)
            $0.bottom.equalTo(-15)
            $0.top.equalTo(contentLab.snp.bottom).inset(-15)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        })
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 15
        
        self.addSubview(userLab)
        userLab.snp.makeConstraints({
            $0.left.equalTo(avatarView.snp.right).inset(-10)
            $0.centerY.equalTo(avatarView)
        })
        userLab.font = UIFont.systemFont(ofSize: 12)
        userLab.textColor = UIColor.black
        
        self.addSubview(timeLab)
        timeLab.snp.makeConstraints({
            $0.right.equalTo(-15)
            $0.centerY.equalTo(avatarView)
        })
        timeLab.font = UIFont.systemFont(ofSize: 12)
        timeLab.textColor = UIColor.gray

    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
