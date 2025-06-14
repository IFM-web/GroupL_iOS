//
//  vichle_Type_VC.swift
//  iVM360
//
//  Created by 1707 on 23/01/25.
//

import UIKit

class vichle_Type_VC: UIViewController {

    @IBOutlet weak var self_Vechile_Btn: UIButton!
    @IBOutlet weak var public_Vechile_Btn: UIButton!
    @IBOutlet weak var vechile_TabBackgroundView: UIView!
    
    
    var isCL = false
    var isEL = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.self_Vechile_Btn.layer.cornerRadius = 5
        self.public_Vechile_Btn.layer.cornerRadius = 5
        self.vechile_TabBackgroundView.layer.cornerRadius = 10

        
    }
    
    @IBAction func Click_self_Vechile_Button(_ sender: Any) {
   
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Self_Vehicle_VC") as? Self_Vehicle_VC
      
              self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func Click_public_Vechile_Button(_ sender: Any) {
     
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Public_Vehicle_VC") as? Public_Vehicle_VC
      
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func ClickBack_Button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }


  
}
