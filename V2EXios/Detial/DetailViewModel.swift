//
//  DetialViewModel.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation
import YYText
import ReactiveSwift
import Result
class DetailViewModel{
    let model : HotModel
    let checkSignal : Signal<String,NoError>
    let reloadSignal : Signal<Bool, NoError>

    
    fileprivate  var dataArray : [CommentModel]
    fileprivate  var page = 0
    fileprivate let checkObserve : Observer<String,NoError>
    fileprivate let refreshObserver : Observer<Bool,NoError>
    fileprivate let requestObserver : Observer<Void,NoError>


    let active = MutableProperty(false)
    init(WithModel:HotModel) {
        self.model = WithModel
        self.dataArray = []
        let (signal,observe) = Signal<String,NoError>.pipe()
        self.checkSignal = signal
        self.checkObserve = observe
        
        let (reloadSignl,reloadob) = Signal<Bool,NoError>.pipe()
        self.reloadSignal = reloadSignl
        self.refreshObserver = reloadob
        
        let (requestSignl,requestob) = Signal<Void,NoError>.pipe()
        self.requestObserver = requestob
        
        active.producer
            .filter{
                $0
            }
            .map({
                _ in
                ()
            })
            .start(requestObserver)
        
        SignalProducer(requestSignl)
            .startWithValues({
                [weak self]  in
                self?.requestData()
            })

    }
    private func requestData(){
        page += 1
        AFN.sharedState.getRequestData(url: UrlRoute.showComment.pages(page: page) + "&topic_id=\(model.id)", model: "CommentModel", dataCompletionHandler: {
            [weak self]  status,value in
            guard status > 0 else {
                self?.page -= 1
                self?.refreshObserver.send(value: false)
                return
            }
            self?.dataArray += value as! [CommentModel]
            self?.refreshObserver.send(value: true)
        })
      
    }
   
    func numberOfSection()->Int{
        return self.dataArray.count
    }
    func cellFor(tablView:UITableView,indexpath:IndexPath,WithIdentifier:String) -> UITableViewCell{
        let cell = tablView.cellWith(Identifier: WithIdentifier, indexpath: indexpath) as! CommentTableViewCell
        cell.selectionStyle = .none
        cell.model = self.dataArray[indexpath.row]
        return cell
    }
 
    func caculateLayOut()->YYTextLayout{
        
        let text = NSMutableAttributedString.init(string: self.model.content!)
        let font = UIFont.systemFont(ofSize: 14)
        text.yy_font = font
        text.yy_color = UIColor.gray

        
        //图文混排
        while let result = regularTheString(str:text) {
            let imageView = UIImageView(frame: CGRect(x: 25, y: 0, width: SCREEN_WIDH - 50, height: 70))
            imageView.sizeToFit()
            let img_div  = text.attributedSubstring(from: result.range)
            let image_result = (img_div.string as NSString).substring(with: NSRange.init(location: 10, length: img_div.length-5))
            imageView.sd_setImage(with: URL.init(string:image_result))
            let attachment = NSMutableAttributedString.yy_attachmentString(withContent: imageView, contentMode: UIViewContentMode.bottom, attachmentSize: imageView.frame.size, alignTo: font, alignment: .center)
            text.replaceCharacters(in: result.range, with: attachment)
        }
        //超链接
        for sub in regularTheUrl(str: text){
            text.yy_setTextUnderline(YYTextDecoration.init(style: .single), range: sub.range)
        
            text.yy_setTextHighlight(sub.range, color: UIColor.blue, backgroundColor: nil, userInfo: nil, tapAction: {
               [weak self]  action in
                print(action.1.attributedSubstring(from: action.2).string)
                self?.checkObserve.send(value: action.1.attributedSubstring(from: action.2).string)
            }, longPressAction: {
                _ in
            })
        }
       
        let container = YYTextContainer()
        container.size = CGSize(width: SCREEN_WIDH - 50, height: CGFloat.greatestFiniteMagnitude)
        container.maximumNumberOfRows = 0
        let layout = YYTextLayout(container: container, text: text)
        return layout!
    }
    

}
