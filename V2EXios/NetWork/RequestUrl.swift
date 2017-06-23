//
//  RequestUrl.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation

struct UrlRoute {
    
    static let rootUrl = "https://www.v2ex.com/api/"
    
    
    static let hotTopics = "topics/hot.json" //最热主题
    static let latestTopics = "topics/latest.json" //最新主题
    
    /**  主题回复
     *  parameters:
     *   topic_id : Int  主题ID *
     */
    static let showComment = "replies/show.json" //主题回复
 
}
