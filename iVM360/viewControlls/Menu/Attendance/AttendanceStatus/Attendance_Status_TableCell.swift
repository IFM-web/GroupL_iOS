//
//  Attendance_Status_TableCell.swift
//  iVM360
//
//  Created by 1707 on 04/09/24.
//

import UIKit

class Attendance_Status_TableCell: UITableViewCell {
    @IBOutlet weak var attendanceStatusDateLbl: UILabel!
    @IBOutlet weak var attendanceStatusShiftLbl: UILabel!
    @IBOutlet weak var attendanceStatusSiteLbl: UILabel!
    @IBOutlet weak var attendanceStatusRemarkLbl: UILabel!
    @IBOutlet weak var attendanceStatusCheckInTimeLbl: UILabel!
    @IBOutlet weak var attendanceStatusCheckOutTimeLbl: UILabel!
    @IBOutlet weak var attendanceStatusStatuskLbl: UILabel!
    @IBOutlet weak var attendanceStatusbackgroundView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
