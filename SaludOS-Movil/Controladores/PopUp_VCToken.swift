//
//  PopUp_VCToken.swift
//  SaludOS-Movil
//
//  Created by Alumno on 03/10/22.
//

import UIKit
import FirebaseAuth
import Firebase
import Foundation
import CryptoKit

class PopUp_VCToken: UIViewController {

    var token : String!
    
    @IBOutlet weak var lbToken: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = makeDaToken()
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).setData(["token": MD5(string: token!)], merge: true) {
            (error) in
            
            if error != nil {
                self.lbToken.text = "Error, mala conexión"
                let alerta = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                let accion = UIAlertAction(title: "OK", style: .cancel)
                alerta.addAction(accion)
                self.present(alerta, animated: true)
            }
            // "Por favor checar tu internet y volver a intentar mas tarde"
            else {
                self.lbToken.text = self.token
            }
        }
    }
    
    
    func makeDaToken() -> String {
        let part_0 = ["A", "E", "I", "O", "U"].shuffled()
        let part_1 = Int.random(in: 1..<9)
        let part_2 = Int.random(in: 1..<9)
        let part_3 = Int.random(in: 1..<9)
        let part_4 = ["A", "B", "C", "D", "E", "F", "G", "H", "I",
                      "J", "K", "L", "M", "N", "O", "P", "Q", "R",
                      "S", "T", "U", "V", "W", "X", "Y", "Z"].shuffled()

        return "\(part_0[0])" + "\(part_1)" + "\(part_2)" + "\(part_3)" + "\(part_4[0])" + "\(part_4[4])" + "\(part_4[2])"
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    @IBAction func btnShare(_ sender: UIButton) {
        
        let mensaje = lbToken.text
        let share = [mensaje!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: share, applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    
    @IBAction func Regresar(_ sender: UIButton) {
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).updateData(["token": FieldValue.delete()])
        self.dismiss(animated: true, completion: nil)
    }
}
