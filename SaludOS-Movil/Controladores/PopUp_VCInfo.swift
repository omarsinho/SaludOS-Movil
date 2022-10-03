//
//  PopUp_VCInfo.swift
//  SaludOS-Movil
//
//  Created by Alumno on 01/10/22.
//
import WebKit
import UIKit

class PopUp_VCInfo: UIViewController {
    
    
    @IBOutlet weak var ytview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        webButton.addTarget(self, action: "didTap", forControlEvent: .touchUpInside)
        
        let webConf = WKWebViewConfiguration()
        webConf.allowsInlineMediaPlayback = true
        DispatchQueue.main.async {
            let webPlayer = WKWebView(frame: self.ytview.bounds, configuration: webConf)
            self.ytview.addSubview(webPlayer)
                
            guard let videoURL = URL(string: "https://youtu.be/UnIhRpIT7nc")
            else { return } //works with vimeo as well
            let request = URLRequest(url: videoURL)
                webPlayer.load(request)
            }
        
        }
        
    
    // NO JALA TT
    @IBAction func btnContactanosWeb(_ sender: UIButton) {
        if let url = URL(string: "www.google.com") {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url, options: [:])
//            } else {
//                UIApplication.shared.openURL(url)
//            }
            UIApplication.shared.open(url, options: [:])
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
