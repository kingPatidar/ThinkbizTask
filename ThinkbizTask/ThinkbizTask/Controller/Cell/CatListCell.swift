//
//  CatListCell.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import UIKit

class CatListCell: UITableViewCell {
    
    @IBOutlet weak var objCallView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var seeMoreControl: UIControl!
    
    var arrData = [Data]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populate(objData: CategoryBaseModel) {
        lblTitle.text = objData.categoryName
        if let catData = objData.data {
            self.arrData = catData
            self.objCallView.reloadData()
        }
    }
}

//MARK: CollectionView DataSource and Delegate Methods

extension CatListCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func registerCell() {
        self.objCallView.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionCell")
        self.objCallView.dataSource = self
        self.objCallView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionCell
        cell = objCallView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        cell.populate(objData: arrData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    
}
