
//
//  MJRefreshDelegate.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import DZNEmptyDataSet
protocol MJAndDZDelegate{
    
    var MJTableView : UITableView?{set get}
    func refreshData()
    func loadMoreData()
}
extension MJAndDZDelegate where Self:UIViewController {

     func addMJToTablView(onlyFoot:Bool?=false){
        self.MJTableView?.emptyDataSetDelegate = self
        self.MJTableView?.emptyDataSetSource = self
        self.MJTableView?.tableFooterView = UIView()
        let mjfooter = MJRefreshBackNormalFooter() //上拉加载
        self.MJTableView?.mj_footer = mjfooter
        mjfooter.setRefreshingTarget(self, refreshingAction: Selector(("loadMoreData")))
        
        guard !onlyFoot! else {
            return
        }
        let mjheader = MJRefreshGifHeader() //下拉刷新
        self.MJTableView?.mj_header = mjheader
        mjheader.setRefreshingTarget(self, refreshingAction: Selector(("refreshData")))
    }
    func refreshData(){
        print("刷新")
    }
    func loadMoreData(){
        print("加载")
        
    }
    func enMjRefresh() {
        
        if let header = self.MJTableView?.mj_header {
            header.endRefreshing()
        }
        self.MJTableView?.mj_footer.endRefreshing()
    }
    func showNoMoreData(){
        self.MJTableView?.mj_footer.endRefreshingWithNoMoreData()
    }

    

}
