//
//  Loader.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import UIKit

var ARR_states : NSArray = NSArray()
var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
var VW_overlay: UIView = UIView()

class VC_search_Course: UIViewController {

@IBOutlet weak var TBL_states :UITableView!

override func viewDidLoad() {
    super.viewDidLoad()
   
    VW_overlay = UIView(frame: UIScreen.main.bounds)
    VW_overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

    activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    activityIndicatorView.frame = CGRect(x: 0, y: 0, width: activityIndicatorView.bounds.size.width, height: activityIndicatorView.bounds.size.height)
    
   

    activityIndicatorView.center = VW_overlay.center
    VW_overlay.addSubview(activityIndicatorView)
    VW_overlay.center = view.center
    view.addSubview(VW_overlay)

    activityIndicatorView.startAnimating()
    perform(#selector(self.Places_API), with: activityIndicatorView, afterDelay: 0.01)

}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}



@IBAction func button_back(sender: UIButton) {
    self.dismiss(animated: false, completion: nil)
}

    @objc func Places_API()
{
    let STR_url = String(format: "%@/search_by_location")
    let auth_tok = String(format:"%@",UserDefaults.standard.value(forKey:"auth_token") as! CVarArg)
       if let url = NSURL(string:STR_url) {
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(auth_tok, forHTTPHeaderField: "auth_token")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("\(String(describing: error))")
                return
            }

            let temp_dictin: [AnyHashable: Any]? = ((try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [AnyHashable: Any])


            ARR_states = temp_dictin?["course_locations"] as! NSArray
            NSLog("States response %@", ARR_states)

        }
        task.resume()
    }

    activityIndicatorView.stopAnimating()
    VW_overlay.isHidden = true
}
}

