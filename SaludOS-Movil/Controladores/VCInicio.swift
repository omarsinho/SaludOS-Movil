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
    
    
    
    @IBSegueAction func showGrafica(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: VistaGrafica())    }
    
}
