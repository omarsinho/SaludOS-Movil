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
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).getDocument {
            (documentSnapshot, error) in
            if let document = documentSnapshot, error == nil {
                if let idMedicos = document.get("uidMedicos") as? Array<String> {
                    //self.listaIdMedicos = idMedicos
                    //print("")
                    print(idMedicos)
                    if idMedicos == [] {
                        let alerta = UIAlertController(title: "Error: NO tienes médicos vinculados.", message: "Primero el médico te tiene que agregar ingresando el token que se genera en la sección de perfil, en el ícono de la esquina superior izquierda.", preferredStyle: .alert)
                        let accion = UIAlertAction(title: "OK", style: .cancel) { (accion) in self.dismiss(animated: true)}
                        alerta.addAction(accion)
                        self.present(alerta, animated: true)
                    }
                    else {
                        self.getMedicos(ids: idMedicos)
                    }
                }
            }
            else {
                self.presentaAlerta(mensaje: error!.localizedDescription)
            }
        }
    }
    
    func getMedicos(ids: Array<String>) {
        for id in stride(from: 0, to: ids.count, by: 1) {
            db.collection("Medico").document(ids[id]).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, error == nil {
                    if let nombrePila = document.get("nombrePila") as? String, let apellidoP = document.get("apellidoPaterno") as? String, let apellidoM = document.get("apellidoMaterno") as? String {
                        self.listaNombresMedicos.append(nombrePila + " " + apellidoP + " " + apellidoM)
                    }
                    else {
                        self.presentaAlerta(mensaje: error!.localizedDescription)
                    }
                    if let titulo = document.get("titulo") as? String {
                        self.listaTitulos.append(titulo)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listaNombresMedicos.remove(at: indexPath.row)
            listaTitulos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Quitar Medicos /BD
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let med = listaNombresMedicos[sourceIndexPath.row]
        let titu = listaNombresMedicos[sourceIndexPath.row]

        listaNombresMedicos.remove(at: sourceIndexPath.row)
        listaTitulos.remove(at: sourceIndexPath.row)
        
        listaNombresMedicos.insert(med, at: destinationIndexPath.row)
        listaTitulos.insert(titu, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func presentaAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(accion)
        present(alerta, animated: true)
    }
    
    

}
