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
    
    @IBOutlet weak var lbAlimentacion: UILabel!
    @IBOutlet weak var lbEjercicio: UILabel!
    @IBOutlet weak var lbEmocional: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        
        lbAlimentacion.text = "¿Cómo te has alimentado esta semana? 5.0"
        sldrAlimentacion.value = 0.5
        lbEjercicio.text = "¿Haz hecho ejercicio esta semana? 5.0"
        sldrEjercicio.value = 0.5
        lbEmocional.text = "¿Como te has sentido esta semana? 5.0"
        sldrEmocional.value = 0.5
    }
    
    
    @IBAction func CambiaValorAlim(_ sender: UISlider) {
        let ali = Double(Int(self.sldrAlimentacion.value * 1000)) / 100
        lbAlimentacion.text = "¿Cómo te has alimentado esta semana? " + "\(ali)"
    }
    
    @IBAction func CambiaValorEjercicio(_ sender: UISlider) {
        let eje = Double(Int(self.sldrEjercicio.value * 1000)) / 100
        lbEjercicio.text = "¿Haz hecho ejercicio esta semana? " + "\(eje)"
    }
    
    
    @IBAction func CambiaValorEmocional(_ sender: UISlider) {
        let emo = Double(Int(self.sldrEmocional.value * 1000)) / 100
        lbEmocional.text = "¿Como te has sentido esta semana? " + "\(emo)"
    }
    
    @IBAction func SubmitCuestionario(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let ali = Double(Int(self.sldrAlimentacion.value * 1000)) / 100
        let eje = Double(Int(self.sldrEjercicio.value * 1000)) / 100
        let emo = Double(Int(self.sldrEmocional.value * 1000)) / 100
        
        
        
        db.collection("CuestionarioSemanal").document(formatter.string(from: Date()) + " - \(Auth.auth().currentUser!.uid)").setData(["fechaCuestionario": formatter.string(from: Date()), "medidorAlimentacion": ali, "medidorEjercicio": eje, "medidorEmocional": emo, "uidPaciente": Auth.auth().currentUser!.uid]) {
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
