//
//  VCVistaMedicos.swift
//  SaludOS-Movil
//
//  Created by Alumno on 29/09/22.
//

import UIKit
import FirebaseAuth
import Firebase

class VCVistaMedicos: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listaNombresMedicos : Array<String> = []
    var listaTitulos : Array<String> = []
    
    @IBOutlet weak var tableViewMedicos: UITableView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // @escaping
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).getDocument {
            (documentSnapshot, error) in
            if let document = documentSnapshot, error == nil {
                if let idMedicos = document.get("uidMedicos") as? Array<String> {
                    //self.listaIdMedicos = idMedicos
                    //print("")
                    self.getMedicos(ids: idMedicos)
                }
            }
            else {
                self.presentaAlerta(mensaje: error!.localizedDescription)
            }
        }
    }
    
    func getMedicos(ids: Array<String>) {
        for id in stride(from: 0, to: ids.count, by: 1) {
            print("Hola")
            db.collection("Medico").document(ids[id]).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, error == nil {
                    if let nombrePila = document.get("nombrePila") as? String, let apellidoP = document.get("apellidoPaterno") as? String, let apellidoM = document.get("apellidoMaterno") as? String {
                        self.listaNombresMedicos.append(nombrePila + " " + apellidoP + " " + apellidoM)
                        print(self.listaNombresMedicos[id])
                    }
                    else {
                        self.presentaAlerta(mensaje: error!.localizedDescription)
                    }
                    if let titulo = document.get("titulo") as? String {
                        self.listaTitulos.append(titulo)
                        print(self.listaTitulos[id])
                    }
                    else {
                        self.presentaAlerta(mensaje: error!.localizedDescription)
                    }
                    self.tableViewMedicos.reloadData()
                }
            }
        }
    }
    
    @IBAction func cierraView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaNombresMedicos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "idCell")!
        
        
        
        celda.textLabel?.text = listaNombresMedicos[indexPath.row]
        celda.detailTextLabel?.text = "\(listaTitulos[indexPath.row])"
        celda.imageView?.image = UIImage(named: "medic")
        return celda
    }
    
    func presentaAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(accion)
        present(alerta, animated: true)
    }

}
