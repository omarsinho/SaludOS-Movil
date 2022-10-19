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

class VCRegistroPresion: UIViewController /*UITabBarController*/ {
    
    @IBOutlet weak var switchEjercicio: UISwitch!
    @IBOutlet weak var tfPresionSYS: UITextField!
    @IBOutlet weak var tfPresionDIA: UITextField!
    @IBOutlet weak var tfPulso: UITextField!
    @IBOutlet weak var sldrEmocional: UISlider!
    @IBOutlet weak var tfComentarios: UITextField!
    
    @IBOutlet weak var lbMedidor: UILabel!
    @IBOutlet weak var lbEjercicio: UILabel!
    
    @IBOutlet weak var imgSad: UIImageView!
    @IBOutlet weak var imgHappy: UIImageView!
    
    var veces: Double = 0
    var presionSistolica: Double = 0
    var presionDiastolica: Double = 0
    var pulso: Double = 0
    
    var titulo = ""
    var mensaje = ""
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMedidor.text = "¿Como te sientes del 1 al 10? ###"
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        
//        self.view.exchangeSubview(at: 2, withSubviewAt: 0)
        
        veces = 0
        tfComentarios.isHidden = false
        switchEjercicio.isHidden = false
        lbMedidor.isHidden = false
        sldrEmocional.isHidden = false
        lbEjercicio.isHidden = false
        imgSad.isHidden = false
        imgHappy.isHidden = false
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
            var emo : Double
            if self.sldrEmocional.value.isNormal {
                emo = Double(Int(self.sldrEmocional.value * 1000)) / 100
            } else {
                emo = 0.0
            }
            
            presionSistolica += Double(tfPresionSYS.text!)!
            presionDiastolica += Double(tfPresionDIA.text!)!
            pulso += Double(tfPulso.text!)!
            veces += 1
            
            if veces <= 2 {
                if veces == 1 {
                    titulo = "Aviso: ¿Quieres volver a tomarte la presión arterial?"
                    mensaje = "Esto es con el propósito por si al tomarte la presión nuevamente hay una ligera variación en los resultados. Al final se hará un promedio de todas las veces que te tomaste la presión arterial en esta sesión."
                }
                else {
                    titulo = "Aviso: Este es tu segundo intento. ¿Quieres volver a tomarte la presión arterial?"
                    mensaje = "Si oprimes 'Sí' nuevamente, solamente podrás ingresar los datos una vez más."
                }
                let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
                let accion1 = UIAlertAction(title: "No", style: .cancel) { (accion1) in
                    self.db.collection("RegistroPresion").document(formatter.string(from: Date()) + " - \(Auth.auth().currentUser!.uid)").setData(["comentarios": self.tfComentarios.text!,"fechayHoraToma": formatter.string(from: Date()), "hicisteEjercicio": self.hicisteEjercicio(), "medidorEmocional": emo, "presionDiastolica": self.presionDiastolica / self.veces, "presionSistolica": self.presionSistolica / self.veces, "pulso": self.pulso / self.veces, "uidPaciente": Auth.auth().currentUser!.uid]) {
                        (error) in
                        
                        if error != nil {
                            let alerta = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                            let accion = UIAlertAction(title: "OK", style: .cancel)
                            alerta.addAction(accion)
                            self.present(alerta, animated: true)
                        }
                        else {
                            //                            self.dismiss(animated: true, completion: nil)
                            //                            self.view.exchangeSubview(at: 2, withSubviewAt: 1)
                            self.tabBarController?.view.removeFromSuperview()

                            
                         }
                    }
                }
                let accion2 = UIAlertAction(title: "Sí", style: .default) { (accion2) in
                    self.tfPresionSYS.text = ""
                    self.tfPresionDIA.text = ""
                    self.tfPulso.text = ""
                    self.tfComentarios.isHidden = true
                    self.switchEjercicio.isHidden = true
                    self.lbMedidor.isHidden = true
                    self.sldrEmocional.isHidden = true
                    self.lbEjercicio.isHidden = true
                    self.imgSad.isHidden = true
                    self.imgHappy.isHidden = true
                }
                alerta.addAction(accion1)
                alerta.addAction(accion2)
                present(alerta, animated: true)
            } else {
                db.collection("RegistroPresion").document(formatter.string(from: Date()) + " - \(Auth.auth().currentUser!.uid)").setData(["comentarios": self.tfComentarios.text!,"fechayHoraToma": formatter.string(from: Date()), "hicisteEjercicio": self.hicisteEjercicio(), "medidorEmocional": emo, "presionDiastolica": self.presionDiastolica / self.veces, "presionSistolica": self.presionSistolica / self.veces, "pulso": self.pulso / self.veces, "uidPaciente": Auth.auth().currentUser!.uid]) {
                    (error) in
                    
                    if error != nil {
                        let alerta = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                        let accion = UIAlertAction(title: "OK", style: .cancel)
                        alerta.addAction(accion)
                        self.present(alerta, animated: true)
                    } else {
//                        self.dismiss(animated: true, completion: nil)
//                        self.view.exchangeSubview(at: 2, withSubviewAt: 1)
//                        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "VCInicio") as! VCInicio
//                        VC1.tabBarController?.selectedIndex = 0
//                        self.navigationController!.pushViewController(VC1, animated: true)
//                        self.tabBarController?.view.willMove(toSuperview: <#T##UIView?#>)

                     }
                }
            }
        }
    }

    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
