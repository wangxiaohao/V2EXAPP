//
//  HotViewModel.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa
import MBProgressHUD

class HotViewModel{
    
    
    fileprivate var dataArray : [HotModel]
    fileprivate let refreshObserver : Observer<Bool,NoError>
    fileprivate var isLoadMore = false
    fileprivate var current_page = 0
    
    let  requestUrl = MutableProperty<String >("")
    let reloadSignal : Signal<Bool, NoError>
    let requestObserver : Observer<Bool,NoError>
    var dataType = MutableProperty<Int>(0)
    let menuArray = ["最热主题","最新主题"]
    
    init() {
        self.dataArray = operateData.getObjects().sorted{$0.replies > $1.replies}
        let (reloadSignl,reloadob) = Signal<Bool,NoError>.pipe()
        self.reloadSignal = reloadSignl
        self.refreshObserver = reloadob
        let (requestSignl,requestob) = Signal<Bool,NoError>.pipe()
        self.requestObserver = requestob
        
        SignalProducer(requestSignl)
            .startWithValues({
                [weak self]  loadMore  in
                self?.isLoadMore = loadMore
                self?.requestData()
            })


        self.requestUrl <~ dataType.producer
            .map{
                 type in
                
                return type > 0 ? UrlRoute.latestTopics : UrlRoute.hotTopics
        }
        self.requestUrl.producer
            .startWithValues { [weak self] _ in
            self?.current_page = 0
            self?.requestObserver.send(value: false)
        }
        
    }
    private func requestData(){
        current_page += 1
        MBProgressHUD.showLoading()
        AFN.sharedState.getRequestData(url: requestUrl.value.pages(page: current_page), model: "HotModel", dataCompletionHandler: {
          [weak self]  status,value in
          MBProgressHUD.hideHUD()
            guard status > 0 && value as? [HotModel] != nil else {
                self?.current_page -= 1
                self?.dataArray.removeAll()
                if let observe = self?.refreshObserver {
                    observe.send(value: false)
                }
               return
            }
           (self?.isLoadMore)! ? (self?.dataArray += value as! [HotModel]) :  (self?.dataArray =  value as! [HotModel])
            if let observe = self?.refreshObserver {
                 observe.send(value: true)
            }
        })
    }

    func numberOfSection()->Int{
        return self.dataArray.count
    }
    func cellFor(tablView:UITableView,indexpath:IndexPath,WithIdentifier:String) -> UITableViewCell{
        let cell = tablView.cellWith(Identifier: WithIdentifier, indexpath: indexpath) as! HotTopicsTableViewCell
        cell.selectionStyle = .none
        cell.model = self.dataArray[indexpath.row]
        return cell
    }
    func hotModelAtIndexpath(indepath:IndexPath) -> HotModel {
        let model = self.dataArray[indepath.row]
        return model
    }
}
