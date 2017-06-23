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
class DetailViewController: UIViewController,MJAndDZDelegate{
    internal var MJTableView: UITableView?


    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel : DetailViewModel!
    
    //
    static func initWith(viewModel:DetailViewModel)->DetailViewController{
        let vc = ViewRoute.DetailVC
        vc.viewModel = viewModel
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        tableView.register(UINib.init(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.tableFooterView = UIView()
        setTableViewHeder()
        self.MJTableView = tableView
        addMJToTablView(onlyFoot: true)
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
