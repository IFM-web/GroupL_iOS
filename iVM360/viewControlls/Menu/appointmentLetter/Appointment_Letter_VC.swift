//
//  Appointment_Letter_VC.swift
//  iVM360
//
//  Created by 1707 on 04/03/25.
//

import UIKit
import WebKit

class Appointment_Letter_VC: UIViewController, CustomAlertDelegate, WKNavigationDelegate {
    
   
    
    
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
        
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var download_submit_Btn: UIButton!
    var isChecked = false
    
    var appointment_AuthToken = String()
    var pdfURL: String = ""
    var webView: WKWebView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.checkBoxBtn.isEnabled = false
        self.download_submit_Btn.isEnabled = false
        
        checkBoxBtn.setImage(UIImage(systemName: "square"), for: .normal) // Unchecked state
        checkBoxBtn.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
               view.addSubview(checkBoxBtn)
        self.callGenerationService()
          
    }
//    func setupWebView() {
//         webView = WKWebView()
//         webView.translatesAutoresizingMaskIntoConstraints = false
//         view.addSubview(webView)
//         
//         // Set constraints
//         NSLayoutConstraint.activate([
//             webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//             webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//             webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//             webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
//         ])
//     }
//
//      func loadPDF() {
//         guard let url = URL(string: pdfURL) else { return }
//         let request = URLRequest(url: url)
//         webView.load(request)
//     }
     func setupWebView() {
          webView = WKWebView()
          webView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(webView)
          
          NSLayoutConstraint.activate([
              webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
              webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
              webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
          ])
      }

//      private func setupDownloadButton() {
//          downloadButton = UIButton(type: .system)
//          downloadButton.setTitle("Download PDF", for: .normal)
//          downloadButton.addTarget(self, action: #selector(downloadPDF), for: .touchUpInside)
//          downloadButton.translatesAutoresizingMaskIntoConstraints = false
//          view.addSubview(downloadButton)
//          
//          NSLayoutConstraint.activate([
//              downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//              downloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
//              downloadButton.heightAnchor.constraint(equalToConstant: 50)
//          ])
//      }
      
    func loadPDF() {
          guard let url = URL(string: pdfURL) else { return }
          let request = URLRequest(url: url)
          webView.load(request)
      }

//     func downloadPDF() {
//          guard let url = URL(string: pdfURL) else { return }
//          
//          let session = URLSession.shared
//          let task = session.downloadTask(with: url) { (tempURL, response, error) in
//              guard let tempURL = tempURL, error == nil else {
//                  print("Download error:", error?.localizedDescription ?? "Unknown error")
//                  return
//              }
//              
//              // Get file name from response
//              let fileName = response?.suggestedFilename ?? "DownloadedPDF.pdf"
//              let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
//              
//              do {
//                  // Move file from temp location to Documents directory
//                  try FileManager.default.moveItem(at: tempURL, to: destinationURL)
//                  print("PDF saved to: \(destinationURL)")
//                  
//                  // Show share sheet after download
//                  DispatchQueue.main.async {
//                      self.showShareSheet(fileURL: destinationURL)
//                  }
//                
//              } catch {
//                  print("Error saving file:", error.localizedDescription)
//              }
//          }
//          task.resume()
//      }
    func downloadPDF() {
        guard let url = URL(string: pdfURL) else { return }
        
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { (tempURL, response, error) in
            guard let tempURL = tempURL, error == nil else {
                print("Download error:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            // Get file name from response
            let fileName = response?.suggestedFilename ?? "DownloadedPDF.pdf"
            let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
            
            do {
                // Move file from temp location to Documents directory
                try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                print("PDF saved to: \(destinationURL)")
                
                // Open the saved PDF file
                DispatchQueue.main.async {
                    self.openPDF(fileURL: destinationURL)
                }
            } catch {
                print("Error saving file:", error.localizedDescription)
            }
        }
        task.resume()
    }
    func openPDF(fileURL: URL) {
        let documentController = UIDocumentInteractionController(url: fileURL)
        documentController.delegate = self
        documentController.presentPreview(animated: true)  // Open in default viewer
    }
     func showShareSheet(fileURL: URL) {
          let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
          activityVC.popoverPresentationController?.sourceView = self.view
          present(activityVC, animated: true, completion: nil)
      }
    
    
    @objc func toggleCheckbox() {
            isChecked.toggle()
            let imageName = isChecked ? "checkmark.square.fill" : "square"
        checkBoxBtn.setImage(UIImage(systemName: imageName), for: .normal)
        }
    

    @IBAction func clickBack_Btnnn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickDownLoadBtn(_ sender: Any) {
        self.callInsertAppointmentApprovalService()
    }
}
extension Appointment_Letter_VC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
