//
//  TableVCHistorial.swift
//  SaludOS-Movil
//
//  Created by user220808 on 10/15/22.
//

import UIKit
import FirebaseAuth
import Firebase

class TableVCHistorial: UITableViewController {

    var secciones=[Secciones]()
    var listaRegistros: Array<Registro> = []
    //var listaRegistros = [Registro]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db.collection("RegistroPresion").whereField("uidPaciente", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                self.presentaAlerta(mensaje: err.localizedDescription)
            }
            else {
                guard let querySnapshot = querySnapshot else {
                    print("Error 1")
                    self.presentaAlerta(mensaje: "Error Desconocido")
                    return
                }
                
                if querySnapshot.documents.count == 0 {
                    self.presentaAlerta(mensaje: "No puedes ver tu historial porque todavía no has hecho al menos un registro de presión arterial.")
                }
                
                for document in querySnapshot.documents {
                    if let comentarios = document.get("comentarios") as? String,
                       let fechayHoraToma = document.get("fechayHoraToma") as? String,
                       let hicisteEjercicio = document.get("hicisteEjercicio") as? Bool,
                       let medidorEmocional = document.get("medidorEmocional") as? Double,
                       let presionDiastolica = document.get("presionDiastolica") as? Double,
                       let presionSistolica = document.get("presionSistolica") as? Double,
                       let puslo = document.get("pulso") as? Double {
                        self.listaRegistros.append(Registro(comentarios: comentarios, fechayHoraToma: fechayHoraToma, hicisteEjercicio: hicisteEjercicio, medidorEmocional: medidorEmocional, presionDiastolica: presionDiastolica, presionSistolica: presionSistolica, pulso: puslo))
                    }
                    else {
                        print("Error 2")
                        self.presentaAlerta(mensaje: "Error desconocido")
                    }
                }
                for registro in self.listaRegistros{
                    self.secciones.append(Secciones(titulo: registro.fechayHoraToma, opciones: ["Comentarios: \(registro.comentarios)","Medidor emocional:  \(registro.medidorEmocional)","¿Realicé ejercicio?:  \(registro.hicisteEjercicio ? "Sí" : "No")", "Presión sistólica:  \(registro.presionSistolica)", "Presión diastólica:  \(registro.presionDiastolica)", "Pulso: \(registro.pulso)"]))
                }
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return listaRegistros.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let seccion = secciones[section]
        if seccion.abierto{
            return seccion.opciones.count+1
        }
        else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda",for:indexPath)
        if indexPath.row == 0{
            celda.textLabel?.text = secciones[indexPath.section].titulo
            celda.backgroundColor = .secondarySystemFill
            
        }
        else{
            celda.textLabel?.text = secciones[indexPath.section].opciones[indexPath.row - 1]
            celda.backgroundColor = .tertiarySystemFill
        }
        return celda
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
            secciones[indexPath.section].abierto = !secciones[indexPath.section].abierto
            tableView.reloadSections([indexPath.section], with: .none)
        }
       
    }
    
    func presentaAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Aviso", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel) { accion in self.dismiss(animated: true)}
        alerta.addAction(accion)
        present(alerta, animated: true)
    }

}
