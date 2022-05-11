//
//  MMPreferentMainController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit

class MMPreferentMainController: MMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

    }
    

    override func setupUI() {

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func bind() {

        self.tableView.MMHead = RefreshHeader{ [weak self] in
            guard self != nil else { return }
            self?.requsetTipsDataIsMore()
        }
        
        self.tableView.MMFoot = RefreshFooter{ [weak self] in
            guard self != nil else { return }
            self?.requsetTipsDataIsMore(isMore: true)
        }
        
        self.tableView.MMHead?.beginRefreshing()
    }

    private func  requsetTipsDataIsMore(isMore: Bool = false) {
        
        if !isMore {
            self.currentPage = 1
            self.tableView.MMFoot?.resetNoMoreData()
            self.listDatas.removeAll()
        }
        
        _ = kHomeApiProvider.yn_request(.HomelistTipOff(pageId: self.currentPage)).subscribe(onNext: { [weak self] (json) in
            self?.tableView.endRefreshing()
            NSLog(json)
            guard let _result = MMPreferentMainListModel.deserialize(from: json) else { return }
            self?.listDatas.append(contentsOf: _result.list ?? [MMPreferentMainModel]())
            self?.tableView.reloadData()
            
            if (self?.listDatas.count ?? 0) >= (_result.totalNum ?? 0) {
                self?.tableView.MMFoot?.endRefreshingWithNoMoreData()
            } else { self?.currentPage = +1 }
            
        }, onError: { error in
            
        })
    }
    
    
   private lazy var tableView: UITableView = {
        let _tab = UITableView(frame: .zero, style: .grouped)
        _tab.backgroundColor = UIColor.clear
        _tab.delegate = self
        _tab.dataSource = self
        _tab.register(MMPreferentMainTableCell.self, forCellReuseIdentifier: "MMPreferentMainTableCell")
        _tab.estimatedRowHeight = 120
        _tab.rowHeight = UITableView.automaticDimension
        _tab.showsVerticalScrollIndicator = false
        _tab.showsHorizontalScrollIndicator = false
        _tab.separatorStyle = .none
        _tab.tableHeaderView = UIView()
        _tab.tableFooterView = UIView()
        return _tab
    }()
    
    private var listDatas = [MMPreferentMainModel]()
    /// 当前页面
    private var currentPage: Int = 1
    
}


extension MMPreferentMainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMPreferentMainTableCell", for: indexPath) as! MMPreferentMainTableCell
        if self.listDatas.count > indexPath.row {
            cell.item = self.listDatas[indexPath.row]
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
