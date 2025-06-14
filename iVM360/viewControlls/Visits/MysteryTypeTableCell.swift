//
//  MysteryTypeTableCell.swift
//  SMCApp
//
//  Created by 1707 on 25/01/24.
//

import UIKit

class MysteryTypeTableCell: UITableViewCell {
    @IBOutlet weak var mysterySerialNumberLbl: UILabel!
    @IBOutlet weak var mysteryquestionLbl: UILabel!
    @IBOutlet weak var mysterYes: UILabel!
    @IBOutlet weak var mysteryNo: UILabel!
    @IBOutlet weak var yesBTN: UIButton!
    @IBOutlet weak var noBTN: UIButton!
    @IBOutlet weak var mysteryremarkTitleLbl: UILabel!
    @IBOutlet weak var mysteryremarkDetailTextView: UITextView!
    @IBOutlet weak var mysteryremarkBackgroundView: UIView!
    @IBOutlet weak var backgroundViewvisits: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextView()
    }
    
    private func setupTextView() {
          // Set up the placeholder text
          mysteryremarkDetailTextView.text = "Enter Remarks"
          mysteryremarkDetailTextView.textColor = UIColor.lightGray
      }
    
    
    
//    func textViewDidChange(_ textView: UITextView) {
//        self.mysteryremarkDetailTextView.text = ""
//        
//        }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//          if self.mysteryremarkDetailTextView.text == "Enter Remarks" {
//              self.mysteryremarkDetailTextView.text = ""
//              self.mysteryremarkDetailTextView.textColor = UIColor.black
//          }
//      }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        


    }
    
}
