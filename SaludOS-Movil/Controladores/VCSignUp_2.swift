//
//  VCSignUp_2.swift
//  SaludOS-Movil
//
//  Created by Alumno on 20/09/22.
//

import UIKit
import FirebaseAuth
import Firebase

class VCSignUp_2: UIViewController {
    
    var nombreRecibido: String!
    var apellidoPRecibido: String!
    var apellidoMRecibido: String!
    var emailRecibido: String!
    var contrasenaRecibida: String!
    var fechaNacRecibida: String!
    
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var tfPeso: UITextField!
    @IBOutlet weak var tfTipoSangre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Bienvenido")
        print(nombreRecibido!)
        
    }
    
    @IBAction func CrearCuenta(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: nombreRecibido!, password: contrasenaRecibida!) {
            (result, err) in
            if err != nil {
                let alerta = UIAlertController(title: "Error", message: err!.localizedDescription, preferredStyle: .alert)
                let accion = UIAlertAction(title: "OK", style: .cancel)
                    alerta.addAction(accion)
                self.present(alerta, animated: true)
            }
            else {
                // El usuario fue creado exitosamente, ahora almacenar sus datos en la base de datos.
                let db = Firestore.firestore()
                
                var altura: Float
                var peso: Float
                var tipoSangre: String
                
                if self.tfAltura.text?.isEmpty == true {
                    altura = -1
                }
                else {
                    altura = Float(self.tfAltura.text!)!
                }
                
                if self.tfPeso.text?.isEmpty == true {
                    peso = -1
                }
                else {
                    peso = Float(self.tfPeso.text!)!
                }
                
                if self.tfTipoSangre.text?.isEmpty == true {
                    tipoSangre = ""
                }
                else {
                    tipoSangre = self.tfTipoSangre.text!
                }
                
                print("Datos Sign Up 2: ")
                print(altura)
                print(peso)
                print(tipoSangre)
                
                db.collection("Paciente").addDocument(data: ["altura": altura, "apellidoMaterno": self.apellidoMRecibido!, "apellidoPaterno": self.apellidoPRecibido!, "fechaNacimiento": self.fechaNacRecibida!, "nombrePila": self.nombreRecibido!, "peso": peso, "tipoSangre": tipoSangre, "uid": result!.user.uid]) {
                    (error) in
                    
                    if error != nil {
                        let alerta = UIAlertController(title: "Error", message: err!.localizedDescription, preferredStyle: .alert)
                        let accion = UIAlertAction(title: "OK", style: .cancel)
                            alerta.addAction(accion)
                        self.present(alerta, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
