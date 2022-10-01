//
//  VCSignUp_1.swift
//  SaludOS-Movil
//
//  Created by Alumno on 20/09/22.
//

import UIKit

class VCSignUp_1: UIViewController {

    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfApellidoP: UITextField!
    @IBOutlet weak var tfApellidoM: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfContrasena: UITextField!
    @IBOutlet weak var tfConfContrasena: UITextField!
    @IBOutlet weak var tfFechaNac: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        tfFechaNac.inputView = datePicker
        //tfFechaNac.text = formatDate(date: Date()) // La fecha de hoy
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        tfFechaNac.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp1-a-2" {
            let vistaSignUp2 = segue.destination as! VCSignUp_2
            vistaSignUp2.nombreRecibido = tfNombre.text
            vistaSignUp2.apellidoPRecibido = tfApellidoP.text
            vistaSignUp2.apellidoMRecibido = tfApellidoM.text
            vistaSignUp2.emailRecibido = tfEmail.text
            vistaSignUp2.contrasenaRecibida = tfContrasena.text
            vistaSignUp2.fechaNacRecibida = tfFechaNac.text
        }
    }
    
    static func isPasswordValid(contrasenia: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: contrasenia)
    }
    
    
    @IBAction func ContinuarASignUp2(_ sender: UIButton) {
        if tfNombre.text?.isEmpty == true || tfApellidoP.text?.isEmpty == true || tfApellidoM.text?.isEmpty == true || tfEmail.text?.isEmpty == true || tfContrasena.text?.isEmpty == true || tfConfContrasena.text?.isEmpty == true || tfFechaNac.text?.isEmpty == true {
            presentaAlerta(mensaje: "NO debe quedar ningún campo vacío.")
        }
        if VCSignUp_1.isPasswordValid(contrasenia: tfContrasena.text!) == false {
            presentaAlerta(mensaje: "Por favor asegurese que la contraseña tenga al menos 8 carácteres, un carácter especial, y un número.")
        }
        if tfContrasena.text != tfConfContrasena.text {
            presentaAlerta(mensaje: "Las contraseñas deben ser iguales.")
        }
        performSegue(withIdentifier: "SignUp1-a-2", sender: self)
    }
    
    func presentaAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel)
            alerta.addAction(accion)
        present(alerta, animated: true)
    }
    
    @IBAction func Regresar(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
