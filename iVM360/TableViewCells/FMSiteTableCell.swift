//
//  FMSiteTableCell.swift
//  iVM360
//
//  Created by 1707 on 17/07/24.
//

import UIKit

class FMSiteTableCell: UITableViewCell {
    @IBOutlet weak var fmSitesNamelist: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
