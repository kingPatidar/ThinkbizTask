//
//  DetailController.swift
//  ThinkbizTask
//
//  Created by MacBook on 02/08/23.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var objCollView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var arrData = [Data]()
    var strTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        lblTitle.text = strTitle
    }
    
    @IBAction func btnBackTapped(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: CollectionView DataSource and Delegate Methods

extension DetailController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func registerCell() {
        self.objCollView.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionCell")
        self.objCollView.dataSource = self
        self.objCollView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionCell
        cell = objCollView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        cell.populate(objData: arrData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (objCollView.bounds.width - 30) / 3
        return CGSize(width: width, height: 150)
    }
    
    
}
