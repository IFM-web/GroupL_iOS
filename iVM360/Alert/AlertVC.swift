//
//  AlertVC.swift
//  DexgoHousekeeping
//
//  Created by Apple on 27/08/22.
//

import UIKit


protocol CustomAlertDelegate{
    func okTapBtn(islogout:Int, text : String)
    func canceltapBtn()
}


class AlertVC: UIViewController, UITextViewDelegate {
    
    //===========================================================
    //MARK: - IBOutlet
    //===========================================================
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var massageLbl: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var logoutCodeTextView: UITextView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleDetailView: UIView!
    @IBOutlet weak var logoutcodeView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    //===========================================================
    //MARK: - create instance
    //===========================================================
    var delegate :CustomAlertDelegate? = nil
    var titlestring:String!
    var massage:String!
    var textview:String!
    var hideBut = false
    var login = false
    var onofflineBut = false
    var logoutBut = false
    
    
    
    //===========================================================
    //MARK: - VC Life Cycle
    //===========================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBtn.setCorner(radius: 0)
        self.rightBtn.setCorner(radius: 0)
        self.backgroundView.setCorner(radius: 15)
        self.logoutCodeTextView.delegate = self
        if hideBut == true{
          self.leftBtn.isHidden = true
            titleLbl.text = titlestring
            massageLbl.text = massage
            titleDetailView.isHidden = false
            logoutcodeView.isHidden = true
        }
        
        else if onofflineBut == true{
            titleLbl.text = titlestring
            massageLbl.text = massage
            logoutcodeView.isHidden = true
            titleDetailView.isHidden = false
            
        }
        else if logoutBut == true{
            titleLbl.text = titlestring
            logoutCodeTextView.text = textview
            titleDetailView.isHidden = true
            logoutcodeView.isHidden = false

            
            
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.logoutCodeTextView.text = ""
    }

    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupview() {
        backgroundView.layer.cornerRadius = 10
        
    }
    func animateView() {
        backgroundView.alpha = 0;
        self.backgroundView.frame.origin.y = self.backgroundView.frame.origin.y + 0
        UIView.animate(withDuration: 0.0, animations: { () -> Void in
            self.backgroundView.alpha = 1.0;
            self.backgroundView.frame.origin.y = self.backgroundView.frame.origin.y - 0
    })
    }
//==================
//    Action
//==================
    @IBAction func canceltapBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.canceltapBtn()
        
    }
    
    @IBAction func okTapBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        if logoutBut == true{
            delegate?.okTapBtn(islogout: 1, text: logoutCodeTextView.text)
        }else{
            delegate?.okTapBtn(islogout: 0, text: "")
        }
        
    }
    

  

}
extension UIView {
  func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    func setBorder(width: CGFloat, color: UIColor) {
            layer.borderColor = color.cgColor
            layer.borderWidth = width
        }
}
