//
//  EngAuditTableCell.swift
//  SMCApp
//
//  Created by 1707 on 11/01/24.
//

import UIKit

class EngAuditTableCell: UITableViewCell {
    @IBOutlet weak var searialLbl: UILabel!
    @IBOutlet weak var questionnLbl: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var itemBackGroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemBackGroundView.layer.cornerRadius = 7
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
