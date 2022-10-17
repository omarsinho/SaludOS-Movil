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
    @IBOutlet weak var lbToma: UIButton!
    @IBOutlet weak var btnLblSugerenciaDiaria: UIButton!
    
    var arregloFechayHoraToma: Array<String> = []
    
    var listSugerenciaDiariaText = ["Nueces", "Brócoli", "Chocolate Negro", "Fresas", "Curry", "Té Verde", "Aceite de Oliva", "Salmón", "Vino Tinto", "Legumbres"]
    var listSugerenciaDiariaImages = ["nueces", "brocoli", "choco", "fresas", "curry", "te", "aceite", "salmon", "vino", "legu"]
    
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
        
        sugerenciaDiaria()
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
        calculoToma()
    }
    
    func sugerenciaDiaria() {
            let rand = Int(arc4random_uniform(10))
            let str = "Sugerencia Diaria: " + listSugerenciaDiariaText[rand]
            btnLblSugerenciaDiaria.titleLabel?.text = str
            btnLblSugerenciaDiaria.imageView?.image =
            UIImage(named: listSugerenciaDiariaImages[rand])
            return
    }
        
    func calculoToma() {
        // EJEMPLO STRING: 2022-10-15 13:04:59
        var strDB : String!
        
        // Get String from DB and change current variable
        strDB = "2022-10-15 18:04:59"
        var auxTwo = strDB.components(separatedBy: " ")
        let auxDateDB = auxTwo[0].components(separatedBy: "-")
        let auxTimeDB = auxTwo[1].components(separatedBy: ":")
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        if let yearComparison = Int(auxDateDB[0]),
            let monthComparison = Int(auxDateDB[1]),
            let dayComparison = Int(auxDateDB[2]) {
            if (yearComparison > year) || (monthComparison > month) {
                lbToma.titleLabel?.text = "Toma Pendiente"
            } else {
                var calculo : Int!
                var tiempo = 1
                if day > dayComparison {
                    tiempo = day - dayComparison
                }
                calculo = ( 24 * tiempo ) - hour
                lbToma.titleLabel?.text = "Siguiente Toma: " + String(calculo) + " horas..."
            }
        }
        return
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
