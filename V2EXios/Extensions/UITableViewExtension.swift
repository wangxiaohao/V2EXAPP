
//
//  UITableViewExtension.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func  cellWith(Identifier: String, indexpath:IndexPath)->UITableViewCell{
        let cell = self.dequeueReusableCell(withIdentifier: Identifier, for: indexpath)
        return cell
    }
//    func loadMoreData() {
//        
//    }
//    func refreshData() {
//        
//    }

}


