//
//  NavigationProtrol.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation

protocol NavigationDelegate {
    func customBarTintColorAndTitle()
}
extension NavigationDelegate where Self:UINavigationController{
  
    func customBarTintColorAndTitle(){
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.automaticallyAdjustsScrollViewInsets = false
    }

    
}
