//
//  ViewRoute.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation
import UIKit
struct ViewRoute {
    
    static let hotVc : HotViewController  = {
        let vc = ViewRoute.getStoryBoardWith(name: "Hot").instantiateViewController(withIdentifier: "HotViewController")
        return vc as! HotViewController
    }()
    
   static func getStoryBoardWith(name:String)->UIStoryboard{
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard
    }
}
