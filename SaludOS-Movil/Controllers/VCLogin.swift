//
//  VCLogin.swift
//  SaludOS-Movil
//
//  Created by Alumno on 20/09/22.
//

import UIKit
import FirebaseAuth
import Firebase

class VCLogin: UIViewController {
    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnIniciaSesion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Autenticación"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //checkUserInfo()
    }
    
    //MARK: - Navigation
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Login" {
            // Verifica que el campo de texto no esté vacío.
            if let email = tfEmail.text,
               let password = tfPassword.text {
                Auth.auth().signIn(withEmail: email, password: password) {
                    (result, error) in
                    
                    if let result = result, error == nil {
                        print("Hola")
                        self.dismiss(animated: true)
                    }
                    else {
                        let alerta = UIAlertController(title: "Error", message: "Debe haber texto en el campo", preferredStyle: .alert)
                        let accion = UIAlertAction(title: "OK", style: .cancel)
                        alerta.addAction(accion)
                        self.present(alerta, animated: true)
                    }
                }
            }
            
        }
    }*/
    
    @IBAction func IniciarSesion(_ sender: UIButton) {
        print("Pulsé el botón")
        validarTextFields()
        /*// Validate Text Fields
        
        // Create cleaned versions of the text field
        /*let email = tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         let password = tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
         // Iniciando sesión
         Auth.auth().signIn(withEmail: email, password: password) {
         (result, error) in
         }*/
        if let email = tfEmail.text,
           let password = tfPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                
                if let result = result, error == nil {
                    return true
                }
                else {
                    return false
                }
            }
        }
        dismiss(animated: true)*/
    }
    
    func validarTextFields() {
        if tfEmail.text?.isEmpty == true {
            print("No email text")
            let alerta = UIAlertController(title: "Error", message: "Debe haber texto en el campo", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel)
            alerta.addAction(accion)
            present(alerta, animated: true)
        }
        if tfPassword.text?.isEmpty == true {
            print("No password")
            let alerta = UIAlertController(title: "Error", message: "Debe haber texto en el campo", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel)
            alerta.addAction(accion)
            present(alerta, animated: true)
        }
        
        login()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) {
            [weak self] authResult, err in
            guard let strongSelf = self else {return}
                if let err = err {
                    print(err.localizedDescription)
                }
            else {
                print("Hola, sí funciona")
            }
                //self!.checkUserInfo()
        /*Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Inicio", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "VCInicio")
            vc.modalPresentationStyle = overFullScreen
            present(vc, animated: true)*/
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Inicio")
            present(vc, animated: true)
        }
    }
}
