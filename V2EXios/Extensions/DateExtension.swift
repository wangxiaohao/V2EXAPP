//
//  DateExtension.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation

extension Date{
    
   static func returnTimeString(WithTimestamp:Int)->String{
        let dataFormater = DateFormatter()
        dataFormater.dateFormat = "yyy-MM-dd"
        
        let time_diff =  Int(Date().timeIntervalSince1970) - WithTimestamp
    
        let diff_hour = time_diff / 3600
        let diff_minute = time_diff % 3600 / 60
        
        if diff_hour > 24  {
            return dataFormater.string(from: Date(timeIntervalSince1970: TimeInterval(WithTimestamp)))
        }
        else if diff_hour > 0  &&  diff_hour < 24 {
            return "\(diff_hour)小时\(diff_minute)分钟前"
        }
        else {
            return "\(diff_minute)分钟前"
        }
   
    }
}
