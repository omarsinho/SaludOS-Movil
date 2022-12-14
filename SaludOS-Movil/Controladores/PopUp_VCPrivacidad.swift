//
//  PopUp_VCPrivacidad.swift
//  SaludOS-Movil
//
//  Created by Alumno on 10/10/22.
//

import UIKit
import WebKit

class PopUp_VCPrivacidad: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "privacidad", ofType: "pdf")
        let urL = URL(fileURLWithPath: path!)
        let request = URLRequest(url: urL)
        
        webView.load(request)
    }
    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
