//
//  VCRegistroPresion.swift
//  SaludOS-Movil
//
//  Created by Alumno on 29/09/22.
//

import UIKit
import FirebaseAuth
import Firebase



class VCRegistroPresion: UIViewController {
    
    @IBOutlet weak var switchEjercicio: UISwitch!
    @IBOutlet weak var tfPresionSYS: UITextField!
    @IBOutlet weak var tfPresionDIA: UITextField!
    @IBOutlet weak var tfPulso: UITextField!
    @IBOutlet weak var sldrEmocional: UISlider!
    @IBOutlet weak var tfComentarios: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func hicisteEjercicio() -> Bool {
        if switchEjercicio.isOn {
            return true
        }
        return false
    }
    
    
    @IBAction func SubmitPresion(_ sender: UIButton) {
        if tfPresionSYS.text?.isEmpty == true || tfPresionDIA.text?.isEmpty == true || tfPulso.text?.isEmpty == true {
            let alerta = UIAlertController(title: "Error", message: "Los campos de presión sistólica, presión diastólica, y pulso deben tener valores.", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel)
            alerta.addAction(accion)
            present(alerta, animated: true)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).collection("RegistroPresion").document(formatter.string(from: Date())).setData(["comentarios": tfComentarios.text!,"fechayHoraToma": formatter.string(from: Date()), "hicisteEjercicio": self.hicisteEjercicio(), "medidorEmocional": self.sldrEmocional.value, "presionDiastolica": Int(self.tfPresionDIA.text!)!, "presionSistolica": Int(self.tfPresionSYS.text!)!, "pulso": Int(tfPulso.text!)!]) {
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
    
    
    @IBAction func cierraView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
