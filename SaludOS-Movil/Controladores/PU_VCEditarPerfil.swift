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
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tfTipoSangre.delegate = self
        tipoSangrePicker.delegate = self
        tipoSangrePicker.dataSource = self
        
        setTipoSangrePicker()
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

