//
//  TicketDetailVC.swift
//  DexgoHousekeeping
//
//  Created by Apple on 15/05/23.
//

import UIKit
class TicketDetailVC: UIViewController, UITextViewDelegate, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
    print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var detailtBackgroundView:UIView!
    @IBOutlet weak var detailtitle:UILabel!
    @IBOutlet weak var detailImageDetailetextView:UITextView!
    @IBOutlet weak var detailClickdBtn:UIButton!
    @IBOutlet weak var detailimageCollectionView:UICollectionView!
    @IBOutlet weak var recollacrionHeight: NSLayoutConstraint!
    @IBOutlet weak var ReopenlClickdBtn:UIButton!
    @IBOutlet weak var assinHistoryClickdBtn:UIButton!
    @IBOutlet weak var genratedBackgroundView:UIView!
    @IBOutlet weak var resolvedBackgroundView:UIView!
    @IBOutlet weak var tripid_DateTimeLbl:UILabel!
    @IBOutlet weak var startPoint_AddressLbl:UILabel!
    @IBOutlet weak var endPoint_AddressLbl:UILabel!
    @IBOutlet weak var assignedByLbl:UILabel!
    @IBOutlet weak var start_TimeLbl:UILabel!
    @IBOutlet weak var ent_TimeLbl:UILabel!
    @IBOutlet weak var trip_Name:UILabel!
    @IBOutlet weak var vehicle_Reading:UILabel!
    
    
    
    var tripID_FromBack = Int()
    var detaisl_Data = [DetailsModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailimageCollectionView.isHidden = true
        self.detailtBackgroundView.layer.cornerRadius = 5
        self.resolvedBackgroundView.layer.cornerRadius = 5
        self.genratedBackgroundView.layer.cornerRadius = 5
        self.assinHistoryClickdBtn.layer.cornerRadius = 5
        self.ReopenlClickdBtn.layer.cornerRadius = 5
        self.detailImageDetailetextView.delegate = self
        self.assinHistoryClickdBtn.isHidden = true
        self.ReopenlClickdBtn.isHidden = true
        
        self.callgetRunnerTripDetailsService()
    //----------------------------
    //collection flow
    //----------------------------
        detailimageCollectionView.collectionViewLayout   = ColumnFlowLayout(cellsPerRow: 3,
                        cellHeight: 110,minimumInteritemSpacing: 5,minimumLineSpacing: 5,sectionInset: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5))
                        if #available(iOS 11.0, *) {
                            detailimageCollectionView.contentInsetAdjustmentBehavior = .always
                        } else {
                            
                        }
    }
    @IBAction func clickBackFromdetail(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //------------------------------
    //    text view
    //------------------------------
    func textViewDidBeginEditing(_ textView: UITextView) {
            self.detailImageDetailetextView.text = ""
        }
    
}

