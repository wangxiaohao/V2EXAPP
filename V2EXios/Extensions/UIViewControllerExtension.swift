//
//  UIViewControllerExtension.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet
extension UIViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func pushViewController(ViewController:UIViewController){
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "如你所见，就是啥都没有🙄🙄🙄"
        let arrttibuts = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.darkGray]
        return NSAttributedString(string: text, attributes: arrttibuts)
    }

}
