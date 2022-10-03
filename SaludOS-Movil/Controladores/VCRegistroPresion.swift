//
//  VCRegistroPresion.swift
//  SaludOS-Movil
//
//  Created by Alumno on 29/09/22.
//

import UIKit
import Firebase

class VCRegistroPresion: UIViewController {
    
    @IBOutlet weak var switchEjercicio: UISwitch!
    @IBOutlet weak var tfPresionSYS: UITextField!
    @IBOutlet weak var tfPresionDIA: UITextField!
    @IBOutlet weak var tfPulso: UITextField!
    
    @IBOutlet weak var tfComentarios: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cierraView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}
