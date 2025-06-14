//
//  MysteryRatingTableCell.swift
//  SMCApp
//
//  Created by 1707 on 31/01/24.
//

import UIKit

class MysteryRatingTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var MysteryRatingquestionLbl:UILabel!
    @IBOutlet weak var MysteryRatingserialNumberLbl: UILabel!
    @IBOutlet weak var MysteryRatingtableCellBackGroundView: UIView!
    
    @IBOutlet weak var mysteryRatingnumberCollaction: UICollectionView!{
        didSet{
            self.mysteryRatingnumberCollaction.delegate = self
            self.mysteryRatingnumberCollaction.dataSource = self
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: 28 , height: 28)
            layout.minimumInteritemSpacing = 7
            layout.minimumLineSpacing = 0
            self.mysteryRatingnumberCollaction.collectionViewLayout = layout
            self.mysteryRatingnumberCollaction.reloadData()
        }
       
    }
    var MysteryratingselectedIndexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mysteryRatingnumberCollaction.allowsMultipleSelection = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberMysteryRatingCollectionCell", for: indexPath) as! NumberMysteryRatingCollectionCell
        cell.mysteryRatingnumberLbl.text = "\(indexPath.row + 1)"
        cell.mysteryRatingnumberView.layer.cornerRadius = 5
        
        if MysteryratingselectedIndexPath?.item ?? -1 <= 2{
            if let selectedIndexPath = MysteryratingselectedIndexPath, indexPath.item <= selectedIndexPath.item {
                        cell.mysteryRatingnumberView.backgroundColor = #colorLiteral(red: 1, green: 0.3568627451, blue: 0.3568627451, alpha: 1)
                
                    } else {
                        cell.mysteryRatingnumberView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
                    }
        }else if MysteryratingselectedIndexPath?.item ?? -1 > 2 && MysteryratingselectedIndexPath?.item ?? -1 <= 5{
            if let selectedIndexPath = MysteryratingselectedIndexPath, indexPath.item <= selectedIndexPath.item {
                        cell.mysteryRatingnumberView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                    } else {
                        cell.mysteryRatingnumberView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
                    }
        }else if MysteryratingselectedIndexPath?.item ?? -1 > 5 {
            if let selectedIndexPath = MysteryratingselectedIndexPath, indexPath.item <= selectedIndexPath.item {
                        cell.mysteryRatingnumberView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                    } else {
                        cell.mysteryRatingnumberView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
                    }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        MysteryratingselectedIndexPath = indexPath
        mysteryRatingnumberCollaction.reloadData()
    }

}
