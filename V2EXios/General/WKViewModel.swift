//
//  WKViewModel.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation

class WKViewModel{
    let title : String
    var isHidden:Bool{
        return hiddenToolBar()
    }
    fileprivate let url : String
    
    var request : URLRequest{
        get{
            return returnRequest()
        }
    }
    init(title : String ,url : String) {
        self.title = title
        self.url = url
    }
    private func returnRequest()->URLRequest{
        let url = URL(string: self.url)
        let request = URLRequest(url: url!)
        return request
    }
    private func hiddenToolBar()->Bool{
        if title == "外部链接"{
            return true
        }
        return false
    }
}
