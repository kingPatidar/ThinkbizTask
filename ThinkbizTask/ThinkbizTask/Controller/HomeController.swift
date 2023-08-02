//
//  HomeController.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var categoryViewModel: CategoryViewModel!
    var arrCatData = [CategoryBaseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        getCategoryData()
    }
    
    func getCategoryData() {
        if categoryViewModel == nil {
            self.categoryViewModel = CategoryViewModel()
        }
        self.categoryViewModel.getCategoryDetails()
        self.categoryViewModel.categoryDetail.bind { catData in
            if let data = catData {
                self.arrCatData.removeAll()
                self.arrCatData.append(contentsOf: data)
                self.tblView.reloadData()
            }
        }
        self.categoryViewModel.errorMessage.bind { error in
            Alert.shared.showAlert(message: error?.localizedDescription ?? "")
        }
    }
    
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func registerNib() {
        tblView.register(UINib(nibName: "CatListCell", bundle: nil), forCellReuseIdentifier: "CatListCell")
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if #available(iOS 15.0, *) {
            tblView.sectionHeaderTopPadding = 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CatListCell
        cell = tblView.dequeueReusableCell(withIdentifier: "CatListCell") as! CatListCell
        cell.populate(objData: arrCatData[indexPath.row])
        cell.tag = indexPath.row
        cell.seeMoreControl.addTarget(self, action: #selector(btnSeeMoreTapped(_ :)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func btnSeeMoreTapped(_ sender: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objDetailController = storyboard.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        if let data = arrCatData[sender.tag].data {
            objDetailController.arrData = data
            objDetailController.strTitle = arrCatData[sender.tag].categoryName ?? ""
        }
        self.navigationController?.pushViewController(objDetailController, animated: true)
    }
    
}
