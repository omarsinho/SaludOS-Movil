//
//  PopUp_VCEncuestaSemanal.swift
//  SaludOS-Movil
//
//  Created by Alumno on 01/10/22.
//

import UIKit
import FirebaseAuth
import Firebase

class PopUp_VCEncuestaSemanal: UIViewController {

    @IBOutlet weak var sldrAlimentacion: UISlider!
    @IBOutlet weak var sldrEjercicio: UISlider!
    @IBOutlet weak var sldrEmocional: UISlider!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func SubmitCuestionario(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let ali = Double(Int(self.sldrAlimentacion.value * 1000)) / 100
        let eje = Double(Int(self.sldrEjercicio.value * 1000)) / 100
        let emo = Double(Int(self.sldrEmocional.value * 1000)) / 100
        
        
        db.collection("CuestionarioSemanal").document().setData(["fechaCuestionario": formatter.string(from: Date()), "medidorAlimentacion": ali, "medidorEjercicio": eje, "medidorEmocional": emo, "uidPaciente": Auth.auth().currentUser!.uid]) {
            (error) in
            
            if error != nil {
                let alerta = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                let accion = UIAlertAction(title: "OK", style: .cancel)
                alerta.addAction(accion)
                self.present(alerta, animated: true)
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
