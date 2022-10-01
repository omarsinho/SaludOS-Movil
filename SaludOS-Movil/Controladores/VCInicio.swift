//
//  VCInicio.swift
//  SaludOS-Movil
//
//  Created by Invitado on 18/09/22.
//

import UIKit

class VCInicio: UIViewController {

    @IBOutlet weak var lbSugerencia: UILabel!
    @IBOutlet weak var lbTomaDiaria: UILabel!
    @IBOutlet weak var imgSugerencia: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbSugerencia.text = GetBD(choice: 1)
    }
    
    // MARK: -- Falta GETS SUGE, TOMA y GRAFICA
    

    func GetBD(choice: Int) -> String {
        if choice == 1 {
            let sugerenciaDiaria = "nicht" // Get BD
            return "Sugerencia Diaria: " + sugerenciaDiaria
        } else {
            let tomaPendiente = "" // Get BD
            return "Toma Diaria: " + tomaPendiente
        }
    }
    

}
