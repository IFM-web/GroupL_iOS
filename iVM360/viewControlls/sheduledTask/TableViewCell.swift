//
//  TableViewCell.swift
//  iVM360
//
//  Created by 1707 on 02/08/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var custormerNameLbl: UILabel!
    @IBOutlet weak var serialNumberLbl: UILabel!
    @IBOutlet weak var checklistNameLbl: UILabel!
    @IBOutlet weak var checkListDateLbl: UILabel!
    @IBOutlet weak var cliskImageView: UIImageView!
    @IBOutlet weak var NameBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

   
    }
    
}
