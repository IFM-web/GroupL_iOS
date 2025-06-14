//
//  Create_View_MultipleImageTableCell.swift
//  iVM360
//
//  Created by 1707 on 08/08/24.
//

import UIKit

class Create_View_MultipleImageTableCell: UITableViewCell {
    @IBOutlet weak var ticketShowGetimageView: UIImageView!
    @IBOutlet weak var imageBackGroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageBackGroundView.layer.cornerRadius = 10
        self.ticketShowGetimageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
