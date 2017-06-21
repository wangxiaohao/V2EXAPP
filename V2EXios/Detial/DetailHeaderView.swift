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
    
    var model:HotModel!{
        didSet{
            titleLab.text = model.title
            avatarView.sd_setImage(with: URL.init(string: model.member?.avatar_large ?? ""), placeholderImage: placeholder_Image)
            userLab.text = model.member?.username
            timeLab.text = Date.returnTimeString(WithTimestamp: Int(model.created))
            DispatchQueue.global().async {
                let text = NSMutableAttributedString.init(string: self.model.content!)
                text.yy_font = UIFont.systemFont(ofSize: 14)
                text.yy_color = UIColor.gray
                let container = YYTextContainer()
                container.size = CGSize(width: SCREEN_WIDH - 50, height: CGFloat.greatestFiniteMagnitude)
                container.maximumNumberOfRows = 0
                let layout = YYTextLayout(container: container, text: text)
                
                DispatchQueue.main.async {
                    self.contentLab.textLayout = layout
                    self.heightObset.send(value: (layout?.textBoundingSize.height)! + 130)
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
        titleLab.numberOfLines = 2
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
        
        self.addSubview(userLab)
        userLab.snp.makeConstraints({
            $0.left.equalTo(avatarView.snp.right).inset(-10)
            $0.bottom.equalTo(avatarView.snp.bottom)
        })
        userLab.font = UIFont.systemFont(ofSize: 12)
        userLab.textColor = UIColor.black
        
        self.addSubview(timeLab)
        timeLab.snp.makeConstraints({
            $0.right.equalTo(-15)
            $0.bottom.equalTo(userLab.snp.bottom)
        })
        timeLab.font = UIFont.systemFont(ofSize: 12)
        timeLab.textColor = UIColor.black

    
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
