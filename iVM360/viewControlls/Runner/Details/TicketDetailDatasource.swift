//
//  TicketDetailDatasource.swift
//  DexgoHousekeeping
//
//  Created by Apple on 07/07/23.
//

import UIKit

extension TicketDetailVC {
    // --- collection hight adjust -------------------------
        override func viewWillLayoutSubviews() {
            super.updateViewConstraints()
            self.recollacrionHeight?.constant = self.detailimageCollectionView.contentSize.height
        }
}

extension TicketDetailVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    if addImages.count == 0{
//        return 1
//    }else{
//        return addImages.count + 1
//    }
    return 4
}
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketDetailImagecellectionCell", for: indexPath) as! TicketDetailImagecellectionCell
    cell.detailImageBackGroundView.setCorner(radius: 5)
    cell.detailImageView.setCorner(radius: 5)
     return cell
   }
}
