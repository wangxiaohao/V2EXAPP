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
class HotViewModel{
    fileprivate var dataArray : [HotModel]
    private let refreshObserver : Observer<Bool,NoError>
    let reloadSignal : Signal<Bool, NoError>

    
    init() {
        self.dataArray = []
        let (reloadSignl,reloadob) = Signal<Bool,NoError>.pipe()
        self.reloadSignal = reloadSignl
        self.refreshObserver = reloadob
    }
    func requestData(){
        AFN.sharedState.getRequestData(url: UrlRoute.hotTopics, model: "HotModel", dataCompletionHandler: {
          [weak self]  status,value in
            guard status > 0 else {
               return
            }
            self?.dataArray = value as! [HotModel]
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
        cell.model = self.dataArray[indexpath.row]
        return cell
    }
    func hotModelAtIndexpath(indepath:NSIndexPath) -> HotModel {
        let model = self.dataArray[indepath.row]
        return model
    }
}
