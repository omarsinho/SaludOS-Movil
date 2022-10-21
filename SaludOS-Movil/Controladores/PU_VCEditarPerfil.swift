//
//  PU_VCEditarPerfil.swift
//  SaludOS-Movil
//
//  Created by Alumno on 19/10/22.
//

import UIKit
import CoreLocation
import FirebaseAuth
import Firebase

class PU_VCEditarPerfil : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var nombreRecibido: String!
    var apellidoPRecibido: String!
    var apellidoMRecibido: String!
    var emailRecibido: String!
    var contrasenaRecibida: String!
    var fechaNacRecibida: String!
    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfPaterno: UITextField!
    @IBOutlet weak var tfMaterno: UITextField!
    
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var tfPeso: UITextField!
    @IBOutlet weak var tfTipoSangre: UITextField!
    
    var tipoSangrePicker = UIPickerView()
    let tipoSangreValues = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
    var tipoSangreName: String = "NA"
    
    let db = Firestore.firestore()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tfTipoSangre.delegate = self
        tipoSangrePicker.delegate = self
        tipoSangrePicker.dataSource = self
        
        setTipoSangrePicker()
    }
    
    override func viewWillAppear(_: Bool) {
            super.viewWillAppear(true)
            db.collection("Paciente").document(Auth.auth().currentUser!.uid).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, error == nil {
                    if let nombrePila = document.get("nombrePila") as? String, let apellidoP = document.get("apellidoPaterno") as? String, let apellidoM = document.get("apellidoMaterno") as? String, let altura = document.get("altura") as? String, let peso = document.get("peso") as? String, let tipoSangre = document.get("tipoSangre") as? String {
                        self.tfNombre.text = nombrePila
                        self.tfPaterno.text = apellidoP
                        self.tfMaterno.text = apellidoM
                        self.tfAltura.text = altura
                        self.tfPeso.text = peso
                        self.tfTipoSangre.text = tipoSangre
                    }
                }
                else {
                    self.presentaAlerta(mensaje: error!.localizedDescription)
                }
            }
        }
    
    // MARK: - Funciones para el Dropdown
    
    func setTipoSangrePicker() {
        let doneBar = UIToolbar()
        doneBar.tintColor = ShareFunc.UIColorFromHex(rgbValue: 0x348069, alpha: 1.0)
        doneBar.layer.borderWidth = 1
        doneBar.layer.borderColor = ShareFunc.UIColorFromHex(rgbValue: 0xE6E6E6, alpha: 1.0).cgColor
        doneBar.sizeToFit()
        
        let alignSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let listo = UIBarButtonItem(title: "Listo", style: .done, target: nil, action: #selector(TipoSangrePickerDone))
        
        doneBar.setItems([alignSpace, listo], animated: false)
        
        tfTipoSangre.inputView = tipoSangrePicker
        tfTipoSangre.inputAccessoryView = doneBar
        tipoSangrePicker.backgroundColor = UIColor.white
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipoSangreValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipoSangreValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfTipoSangre.text = tipoSangreValues[row]
        tipoSangreName = tipoSangreValues[row]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        TipoSangrePickerDone()
    }
    
    @objc func TipoSangrePickerDone() {
        switch tipoSangreName {
        case "A+":
            tipoSangreName = "A+"
        case "A-":
            tipoSangreName = "A-"
        case "B+":
            tipoSangreName = "B+"
        case "B-":
            tipoSangreName = "B-"
        case "AB+":
            tipoSangreName = "AB+"
        case "AB-":
            tipoSangreName = "AB-"
        case "O+":
            tipoSangreName = "O+"
        case "O-":
            tipoSangreName = "O-"
        default:
            tipoSangreName = ""
        }
        
        tfTipoSangre.resignFirstResponder()
    }
    
    // Estatura, Peso, Tipo de Sangre, Email, Contrasena, Fecha de Nacimiento
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        if tfNombre.text?.isEmpty == true || tfPaterno.text?.isEmpty == true || tfMaterno.text?.isEmpty == true {
            presentaAlerta(mensaje: "NO debe quedar ningún campo vacío.")
        }
        else {
            db.collection("Paciente").document(Auth.auth().currentUser!.uid).setData(["altura": tfAltura.text!, "apellidoMaterno": tfMaterno.text!, "apellidoPaterno": tfPaterno.text!, "nombrePila": tfNombre.text!, "peso": tfPeso.text!, "tipoSangre": tfTipoSangre.text!], merge: true) {
                (error) in
                
                if error != nil {
                    self.presentaAlerta(mensaje: error!.localizedDescription)
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func presentaAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(accion)
        present(alerta, animated: true)
    }

}


// MARK: - Clase auxiliar para el Dropdown
//
//class ShareFunc : UIViewController, CLLocationManagerDelegate {
//
//    class func UIColorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
//        let rojo = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
//        let verde = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
//        let azul = CGFloat(rgbValue & 0xFF)/256.0
//
//        return UIColor(red: rojo, green: verde, blue: azul, alpha: CGFloat(alpha))
//    }
//}

