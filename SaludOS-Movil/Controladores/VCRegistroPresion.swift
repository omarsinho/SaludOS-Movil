//
//  VCRegistroPresion.swift
//  SaludOS-Movil
//
//  Created by Alumno on 29/09/22.
//

import UIKit
import FirebaseAuth
import Firebase

//extension Float {
//    func truncate(places : Int) -> Float {
//        return Float(floor(pow(10.0, Double(places)) * self)/pow(10.0, Float(places)))
//    }
//}

class VCRegistroPresion: UIViewController {
    
    @IBOutlet weak var switchEjercicio: UISwitch!
    @IBOutlet weak var tfPresionSYS: UITextField!
    @IBOutlet weak var tfPresionDIA: UITextField!
    @IBOutlet weak var tfPulso: UITextField!
    @IBOutlet weak var sldrEmocional: UISlider!
    @IBOutlet weak var tfComentarios: UITextField!
    
    @IBOutlet weak var lbMedidor: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMedidor.text = "¿Como te sientes del 1 al 10? ###"
    }
    
    func hicisteEjercicio() -> Bool {
        if switchEjercicio.isOn {
            return true
        }
        return false
    }
    
    
    @IBAction func CambiaValor(_ sender: UISlider) {
        let emo = Double(Int(self.sldrEmocional.value * 1000)) / 100
        lbMedidor.text = "¿Como te sientes del 1 al 10? " + "\(emo)"
    }
    
    
    @IBAction func SubmitPresion(_ sender: UIButton) {
        if tfPresionSYS.text?.isEmpty == true || tfPresionDIA.text?.isEmpty == true || tfPulso.text?.isEmpty == true {
            let alerta = UIAlertController(title: "Error", message: "Los campos de presión sistólica, presión diastólica, y pulso deben tener valores.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel)
            alerta.addAction(accion)
            present(alerta, animated: true)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "yyyy-MM-dd"
            
            let emo = Double(Int(self.sldrEmocional.value * 1000)) / 100

            db.collection("RegistroPresion").document(formatter.string(from: Date()) + " - \(Auth.auth().currentUser!.uid)").setData(["comentarios": tfComentarios.text!,"fechayHoraToma": formatter.string(from: Date()), "hicisteEjercicio": self.hicisteEjercicio(), "medidorEmocional": emo, "presionDiastolica": Int(self.tfPresionDIA.text!)!, "presionSistolica": Int(self.tfPresionSYS.text!)!, "pulso": Int(tfPulso.text!)!, "uidPaciente": Auth.auth().currentUser!.uid]) {
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
    }
    
    @IBAction func cierraView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
