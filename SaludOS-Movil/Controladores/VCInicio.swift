//
//  VCInicio.swift
//  SaludOS-Movil
//
//  Created by Invitado on 18/09/22.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftUI

class VCInicio: UIViewController {
    
    
    @IBOutlet weak var lbNombre: UILabel!
    
    var arregloFechayHoraToma: Array<String> = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).getDocument {
            (documentSnapshot, error) in
            if let document = documentSnapshot, error == nil {
                if let nombrePila = document.get("nombrePila") as? String, let apellidoP = document.get("apellidoPaterno") as? String, let apellidoM = document.get("apellidoMaterno") as? String {
                    self.lbNombre.text = nombrePila + " " + apellidoP + " " + apellidoM
                }
            }
            else {
                self.lbNombre.text = error?.localizedDescription
            }
        }
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        
        db.collection("RegistroPresion").whereField("uidPaciente", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            else {
                guard let querySnapshot = querySnapshot else {
                    print("Error Desconocido")
                    return
                }
                
                for document in querySnapshot.documents {
                    if let fechayHoraToma = document.get("fechayHoraToma") as? String {
                        print(fechayHoraToma)
                        print("Hola Fecha")
                        self.arregloFechayHoraToma.append(fechayHoraToma)
                    }
                    else {
                        print("Error desconocido")
                    }
                }
                print(self.arregloFechayHoraToma.last ?? "Hola")
            }
        }
    }
    
    
    @IBSegueAction func showGrafica(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: VistaGrafica())    }
    
    func presentaAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(accion)
        present(alerta, animated: true)
    }
}
