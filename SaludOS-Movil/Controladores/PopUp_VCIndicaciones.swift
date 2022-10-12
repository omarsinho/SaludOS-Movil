//
//  PopUp_VCIndicaciones.swift
//  SaludOS-Movil
//
//  Created by Alumno on 01/10/22.
//

import UIKit
import FirebaseAuth
import Firebase

class PopUp_VCIndicaciones: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbMedico: UILabel!
    
    @IBOutlet weak var stpMedicos: UIStepper!
    @IBOutlet weak var pageControlMedicos: UIPageControl!
    @IBOutlet weak var textViewIndicaciones: UITextView!
    
    let db = Firestore.firestore()
    
    var listaMedicos: Array<String> = []
    var listaIndicaciones: Array<String> = []
    
    var listaMedicamentos = [Medicamento]() //Idea: Crear clase Medicina para incluir en el table view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).getDocument {
            (documentSnapshot, error) in
            if let document = documentSnapshot, error == nil {
                if let idMedicos = document.get("uidMedicos") as? Array<String> {
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
            db.collection("Medico").document(ids[id]).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, error == nil {
                    if let nombrePila = document.get("nombrePila") as? String, let apellidoP = document.get("apellidoPaterno") as? String, let apellidoM = document.get("apellidoMaterno") as? String {
                        self.listaMedicos.append(nombrePila + " " + apellidoP + " " + apellidoM)
                        self.getIndicaciones(medicos: ids)
                    }
                    else {
                        self.presentaAlerta(mensaje: error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getIndicaciones(medicos: Array<String>) {
        for medico in stride(from: 0, to: medicos.count, by: 1) {
            db.collection("RegistroSalud").whereField("uidPaciente", isEqualTo: Auth.auth().currentUser!.uid).whereField("uidMedico", isEqualTo: medicos[medico]).getDocuments() {
                (querySnapshot, err) in
                if let err = err {
                    self.presentaAlerta(mensaje: err.localizedDescription)
                }
                else {
                    guard let querySnapshot = querySnapshot else {
                        self.presentaAlerta(mensaje: "Error Desconocido")
                        return
                    }
                    
                    for document in querySnapshot.documents {
                        if let indicaciones = document.get("indicaciones") as? String {
                            self.listaIndicaciones.append(indicaciones)
                        }
                        else {
                            self.presentaAlerta(mensaje: "Error desconocido")
                        }
                    }
                    self.pageControlMedicos.numberOfPages = self.listaMedicos.count
                    self.stpMedicos.maximumValue = Double(self.listaMedicos.count - 1)
                    self.lbMedico.text = self.listaMedicos[0]
                    self.textViewIndicaciones.text = self.listaIndicaciones[0]
                }
            }
        }
    }
    
    func cambiaDatos(pos:Int){
        lbMedico.text = listaMedicos[pos]
        textViewIndicaciones.text = listaIndicaciones[pos]
        // listaMedicinas = se hace get de las medicinas que receta el Médico encargado
        tableView.reloadData()
    }
    
    @IBAction func cambiaStepper(_ sender: UIStepper) {
        cambiaDatos(pos: Int(stpMedicos.value))
        pageControlMedicos.currentPage = Int(stpMedicos.value)
    }
    
    @IBAction func cambiaPage(_ sender: UIPageControl) {
        stpMedicos.value = Double(pageControlMedicos.currentPage)
    }
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var secciones=[Secciones]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listaMedicamentos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let seccion = secciones[section]
        if seccion.abierto{
            return seccion.opciones.count+1
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
            secciones[indexPath.section].abierto = !secciones[indexPath.section].abierto
            tableView.reloadSections([indexPath.section], with: .none)
        }
       
    }
    
    func presentaAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(accion)
        present(alerta, animated: true)
    }

}
