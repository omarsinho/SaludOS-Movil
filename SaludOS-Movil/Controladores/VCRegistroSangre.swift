//
//  VCRegistroSangre.swift
//  SaludOS-Movil
//
//  Created by Alumno on 20/09/22.
//

import UIKit

class VCRegistroSangre: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func AbrirEncuestaSemanal(_ sender: UIButton) {
        let date = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .month, .year, .weekday], from: date as Date)
        if components.weekday != 1 { // Si no es domigno, marca error
            let alerta = UIAlertController(title: "Error", message: "Sólo se puede contestar la encuesta semanal cada domingo.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel)
            alerta.addAction(accion)
            present(alerta, animated: true)
        }
    }
    
  

}
