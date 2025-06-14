//
//  Leave_Status_TableCell.swift
//  iVM360
//
//  Created by 1707 on 03/09/24.
//

import UIKit

class Leave_Status_TableCell: UITableViewCell {

    @IBOutlet weak var leaveTypeLbl: UILabel!
    @IBOutlet weak var leaveDateLbl: UILabel!
    @IBOutlet weak var leaveApplyLbl: UILabel!
    @IBOutlet weak var leaveStatuLbl: UILabel!
    @IBOutlet weak var LeavebackgroundView: UIView!
    @IBOutlet weak var deletebtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
