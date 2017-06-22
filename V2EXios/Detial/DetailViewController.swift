//
//  DetailViewController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
class DetailViewController: UIViewController,NavigationDelegate{

    fileprivate var viewModel : DetailViewModel
    fileprivate var tableView : UITableView
    init(WithViewModel:DetailViewModel) {
        self.viewModel = WithViewModel
        self.tableView = UITableView(frame: CGRect(x:0,y:0,width:SCREEN_WIDH,height:SCREEN_HEIGHT-44), style: .plain)
        
        super.init(nibName: nil , bundle: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.backgroundColor = hexStringToColor("f5f5f5")
        self.view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        tableView.register(UINib.init(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        setTableViewHeder()
        customBarTintColorAndTitle()
        bindingSignal()
        // Do any additional setup after loading the view.
    }

    func bindingSignal(){
        viewModel.active <~ MutableProperty(true)
        viewModel.checkSignal
            .observe(on: UIScheduler())
            .observeResult({
              [weak self]  result in
                guard result.error == nil else {
                    return
                }
                self?.pushViewController(ViewController: WKWebViewController(WithViewModel: WKViewModel(title: "外部链接", url: result.value!)))
            })
        
        viewModel.reloadSignal
            .observe(on: UIScheduler())
            .observeValues({
                [weak self] isload in
                isload ? self?.tableView.reloadData() : nil
            })

    }

    
    func setTableViewHeder(){
        let view = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDH, height: 100))
        
        view.viewModel = viewModel
        self.tableView.tableHeaderView = view
        
        view.hetightSignal
            .observe(on: UIScheduler())
            .observeValues {
                [weak self] height in
                let view = self?.tableView.tableHeaderView
                view?.frame.size.height = height
                self?.tableView.beginUpdates()
                self?.tableView.tableHeaderView = view
                self?.tableView.endUpdates()
        }
    }
}
extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      return viewModel.cellFor(tablView: tableView, indexpath: indexPath, WithIdentifier: "CommentTableViewCell")
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
