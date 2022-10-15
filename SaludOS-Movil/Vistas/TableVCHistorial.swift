//
//  TableVCHistorial.swift
//  SaludOS-Movil
//
//  Created by user220808 on 10/15/22.
//

import UIKit

class TableVCHistorial: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    

    var secciones=[Secciones]()
    var listaRegistros = [Registro]()
    
    //let registro = Registro(comentarios: <#T##String#>, fechayHoraToma: <#T##Date#>, hicisteEjercicio: <#T##Bool#>, medidorEmocional: <#T##Double#>, presionDiastolica: <#T##Double#>, presionSistolica: <#T##Double#>, pulso: <#T##Double#>)
    
    
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

}