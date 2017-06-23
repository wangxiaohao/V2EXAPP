//
//  NSObjcet.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/22.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation

extension String {
    
     func sizeWithFont(_ font : UIFont) -> CGSize {
        
        let attrs = [NSFontAttributeName : font]
        return (self as NSString).boundingRect(with: CGSize.init(width: SCREEN_WIDH - 50, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil).size
        
     }
    
     func pages(page:Int)->String{
        var str = self
        str += "?page=\(page)&page_size=10"
        return str
    }
    
}
