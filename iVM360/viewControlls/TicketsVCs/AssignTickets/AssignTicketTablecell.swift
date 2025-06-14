//
//  AssignTicketTablecell.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//

import UIKit

class AssignTicketTablecell: UITableViewCell {
    @IBOutlet weak var clientNameLbl: UILabel!
    @IBOutlet weak var AssignTicketSerialNumberLbl: UILabel!
    @IBOutlet weak var siteNameLbl: UILabel!
    @IBOutlet weak var ticketNumberLbl: UILabel!
    @IBOutlet weak var ticketTypeLbl: UILabel!
    @IBOutlet weak var ticketCategoryLbl: UILabel!
    @IBOutlet weak var cliskkImageView: UIImageView!
    @IBOutlet weak var assignTicketBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
