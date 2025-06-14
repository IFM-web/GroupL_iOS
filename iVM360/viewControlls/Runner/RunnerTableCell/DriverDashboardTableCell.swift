//
//  DriverDashboardTableCell.swift
//  DexgoHousekeeping
//
//  Created by 1707 on 09/04/24.
//

import UIKit

class DriverDashboardTableCell: UITableViewCell {
    @IBOutlet weak var timeDateIdLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var startLocationLbl: UILabel!
    @IBOutlet weak var listSerialNumberLbl: UILabel!
    @IBOutlet weak var listSerialNumberView: UIView!
    @IBOutlet weak var listDetailLbl: UILabel!
    @IBOutlet weak var listBackGroundView: UIView!
    @IBOutlet weak var driverStartendBtn: UIButton!
    @IBOutlet weak var addExpansesBtn: UIButton!

    @IBOutlet weak var doneimageView: UIImageView!
    @IBOutlet weak var notDoneImageView: UIImageView!
    @IBOutlet weak var rejectImageView: UIImageView!
    @IBOutlet weak var extraImageView: UIImageView!
    
    @IBOutlet weak var jobStatusLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
