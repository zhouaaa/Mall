//
//  MMHomeCouponPageController.swift
//  Mall
//
//  Created by iOS on 2022/5/13.
//

import UIKit
import JXPagingView

class MMHomeCouponPageController: MMBaseViewController {

    convenience init(pageConfigModel: MMHomeLargeCouponItemConfigModel) {
        self.init(nibName: nil, bundle: nil)
        self.currentConfigModel = pageConfigModel
        
    }
    
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
            self?.currentPage = 1
            self?.handleListData()
        }
        
        self.tableView.MMFoot = RefreshFooter{ [weak self] in
            guard self != nil else { return }
            self?.handleListData()
        }
        
        self.tableView.MMHead?.beginRefreshing()
    }

    private func handleListData() {
        _ = kHomeApiProvider.yn_request(.HomeCouponPageConfig(pageUrl: self.currentConfigModel.url ?? "", pageId: self.currentPage, pageSize: 20)).subscribe(onNext: {  [weak self] (json) in
            self?.tableView.endRefreshing()
            guard let _result = MMHomeLargeCouponGoodListModel.deserialize(from: json) else { return }
            
            if self?.currentPage == 1 {
                self?.listDatas.removeAll()
            }
            
            self?.listDatas.append(contentsOf: _result.list ?? [MMHomeLargeCouponGoodItemModel]())
            
            self?.tableView.reloadData()
            
            if (self?.listDatas.count ?? 0) > (_result.totalNum) {
                self?.tableView.MMFoot?.endRefreshingWithNoMoreData()
            }
            else
            {
                self?.currentPage += 1
            }
        }, onError: { error in
            self.tableView.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    private lazy var tableView: UITableView = {
         let _tab = UITableView(frame: .zero, style: .grouped)
         _tab.backgroundColor = UIColor.clear
         _tab.delegate = self
         _tab.dataSource = self
        _tab.register(MMHomeCouponPageTableCell.self, forCellReuseIdentifier: MMHomeCouponPageTableCell.reuseId)
         _tab.estimatedRowHeight = 120
         _tab.rowHeight = UITableView.automaticDimension
         _tab.showsVerticalScrollIndicator = false
         _tab.showsHorizontalScrollIndicator = false
         _tab.separatorStyle = .none
         _tab.tableHeaderView = UIView()
         _tab.tableFooterView = UIView()
         return _tab
     }()
    
    private var currentPage: Int = 1
    
    private var listDatas = [MMHomeLargeCouponGoodItemModel]()
    
    private var currentConfigModel = MMHomeLargeCouponItemConfigModel()
    
    private var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
}


extension MMHomeCouponPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MMHomeCouponPageTableCell.reuseId, for: indexPath) as! MMHomeCouponPageTableCell
        
        if self.listDatas.count > indexPath.row {
            cell.handleCellData(itemModel: self.listDatas[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return STtrans(156)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.listDatas.count > indexPath.row {
            self.navigationController?.pushViewController(MMGoodsDetailsTbController(goodId: self.listDatas[indexPath.row].goodsId ?? ""), animated: true)
        }
    }
    
    
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
}

extension MMHomeCouponPageController: JXPagingViewListViewDelegate {
   
    func listView() -> UIView {
        return self.view
    }
    
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    
    
    
}
