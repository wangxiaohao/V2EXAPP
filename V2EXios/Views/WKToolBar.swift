//
//  WKToolBar.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

enum ToolBarSelectType {
    case goBack
    case goAhead
    case reload
}
class WKToolBar: UIToolbar {
   
    fileprivate var butObserVe : Observer<ToolBarSelectType,NoError>
    var butSinal : Signal<ToolBarSelectType,NoError>
    
    override init(frame: CGRect) {
        let (signal,observe) = Signal<ToolBarSelectType,NoError>.pipe()
        self.butObserVe = observe
        self.butSinal = signal
        
        super.init(frame: frame)
        
        self.barTintColor = UIColor.black
        self.tintColor = UIColor.white
        self.isTranslucent = false 
        let leftBut  = UIBarButtonItem(image: UIImage.init(named: "left"), style: .done, target: self, action: #selector(WKToolBar.goBack))
        
        let rightBut = UIBarButtonItem(image: UIImage.init(named: "right"), style: .done, target: self, action: #selector(WKToolBar.goAhead))
        
        let spaceBut =  UIBarButtonItem(barButtonSystemItem:.flexibleSpace,
                                       target:nil,
                                       action:nil)
        
        let reloadBut = UIBarButtonItem(image: UIImage.init(named: "reload"), style: .plain, target: self, action: #selector(WKToolBar.reloadWebView))
        self.items = [leftBut,rightBut,spaceBut,reloadBut]
        
       
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func goBack(){
        butObserVe.send(value: ToolBarSelectType.goBack)
    }
    func goAhead(){
        butObserVe.send(value: ToolBarSelectType.goAhead)
    }
    func reloadWebView(){
        butObserVe.send(value: ToolBarSelectType.reload)

        
    }
    deinit {
        
    }

}
