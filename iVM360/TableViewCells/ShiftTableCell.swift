//
//  ShiftTableCell.swift
//  iVM360
//
//  Created by 1707 on 16/07/24.
//

import UIKit

class ShiftTableCell: UITableViewCell {
    @IBOutlet weak var shiftsNamelist: UILabel!
    @IBOutlet weak var serialshiftLbl: UILabel!
    @IBOutlet weak var shiftSelectimageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
