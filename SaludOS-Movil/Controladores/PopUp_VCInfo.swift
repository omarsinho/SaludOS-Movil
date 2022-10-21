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
                
            guard let videoURL = URL(string: "https://youtu.be/8p0N5wN_FcY")
            else { return } //works with vimeo as well
            let request = URLRequest(url: videoURL)
                webPlayer.load(request)
            }
        
        }
    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
