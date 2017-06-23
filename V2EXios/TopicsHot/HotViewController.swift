//
//  HostViewController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result
import ReactiveSwift
class HotViewController: UIViewController,MJAndDZDelegate{
    internal var MJTableView: UITableView?
//    internal var MJTableView: UITableView?
    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var viewModel : HotViewModel = {
        return HotViewModel()
    }()
    fileprivate lazy var cellIdentifier = "HotTopicsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "V2EX"
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        self.MJTableView = tableView
        addMJToTablView()
        bindingSignalAndAddMenuView()

    }
    func bindingSignalAndAddMenuView(){
        let menuView = SliderMenuView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDH, height: 44))
        self.view.addSubview(menuView)
        menuView.menuNameArray = viewModel.menuArray
        
        viewModel.dataType  <~   menuView.signl
        
        viewModel.reloadSignal
            .observe(on: UIScheduler())
            .observeValues({
                [weak self] reload in
                self?.enMjRefresh()
                self?.tableView.reloadData()
                !reload ? self?.showNoMoreData() : nil
            })
    }

    func loadMoreData() {
        viewModel.requestObserver.send(value: true)
    }
    func refreshData() {
        viewModel.requestObserver.send(value: false)
    }

}
extension HotViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellFor(tablView: tableView, indexpath: indexPath, WithIdentifier: cellIdentifier)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.hotModelAtIndexpath(indepath: indexPath)
        let detailModel = DetailViewModel(WithModel: model)
        let vc = DetailViewController.initWith(viewModel:  detailModel)
        pushViewController(ViewController: vc)
        self.hidesBottomBarWhenPushed = false
    }
    
}

