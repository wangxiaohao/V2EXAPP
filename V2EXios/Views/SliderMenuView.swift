//
//  SliderMenuView.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/23.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
class SliderMenuView: UIView {

   fileprivate  var scrollView:UIScrollView
   fileprivate  var menuButtonArray:NSMutableArray
   fileprivate var bottomLine : UIView!
    var menuNameArray:[String]{
        willSet (newMenuNameArray) {
        }
        didSet {
            self.addMenuButton()
        }
    }
    fileprivate let observe : Observer<Int,NoError>
    let signl : Signal<Int,NoError>
    override init(frame: CGRect) {
        
        scrollView = UIScrollView.init()
        menuButtonArray = []
        menuNameArray = []
        
        let (selectSignal,selectObserve) = Signal<Int,NoError>.pipe()
        self.signl = selectSignal
        self.observe = selectObserve
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.setViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.height)
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        bottomLine =  UIView.init(frame: CGRect(x: 0, y: self.frame.height - 2, width: SCREEN_WIDH, height: 2) )
        bottomLine.backgroundColor = UIColor.black
        self.addSubview(scrollView)
        scrollView.addSubview(bottomLine)
        
        let  borderLine = UIView.init(frame:CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)  )
        borderLine.backgroundColor = UIColor(colorLiteralRed: 202/255.5, green: 202/255.5, blue: 202/255.5, alpha: 1.0)
        self.addSubview(borderLine)
        
        
        
    }
    
    private func addMenuButton() {
        self.menuButtonArray.enumerateObjects({ (AnyObject, Int, UnsafeMutablePointer) -> Void in
            (AnyObject as AnyObject).removeFromSuperview()
        })
        self.menuButtonArray.removeAllObjects()
        
        bottomLine.frame.size.width = SCREEN_WIDH / CGFloat(menuNameArray.count)
        for index in 0 ..< menuNameArray.count {
            
            let button = UIButton(type: UIButtonType.custom)
            let titleString:String = menuNameArray[index]
            button.setTitle(titleString, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            button .addTarget(self, action: #selector(SliderMenuView.muneItemClick(button:)), for: UIControlEvents.touchUpInside)
            button.tag = index + 1000
            
            let wdt = SCREEN_WIDH/CGFloat (menuNameArray.count)
            
            button.frame = CGRect(x: CGFloat(index) * wdt, y: 0, width: wdt, height: scrollView.frame.height)
            
         
            scrollView .addSubview(button)
            menuButtonArray .add(button)
            
        }
        guard menuNameArray.count > 0 else {
            return
        }
        
        let button:UIButton = self.menuButtonArray.lastObject as! UIButton
        self.scrollView.contentSize = CGSize(width:button.frame.maxX, height:self.scrollView.frame.height)
    }

    func muneItemClick(button:UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomLine.center.x = button.center.x
        })
        observe.send(value: button.tag-1000)
        
        
    }

}
