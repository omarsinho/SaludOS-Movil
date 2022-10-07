//
//  PopUp_VCIndicaciones.swift
//  SaludOS-Movil
//
//  Created by Alumno on 01/10/22.
//

import UIKit

class PopUp_VCIndicaciones: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbMedico: UILabel!
    
    @IBOutlet weak var stpMedicos: UIStepper!
    @IBOutlet weak var pageControlMedicos: UIPageControl!
    @IBOutlet weak var textViewIndicaciones: UITextView!
    
    
    var listaMedicos = ["Pancho", "Uvaldo","Ignacio", "Simi", "Catafixio", "Masiosare"]
    var listaIndicaciones = ["Hola", "Quién soy", "No sé", "Se me olvidó" , "Yeh, yeh", "Bad Bunny beibe"]
    
    var listaMedicinas = [String]() //Idea: Crear clase Medicina para incluir en el table view
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControlMedicos.numberOfPages = listaMedicos.count
        stpMedicos.maximumValue = Double(listaMedicos.count - 1)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaMedicinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda")!
        celda.textLabel?.text = listaMedicos[indexPath.row]
        return celda
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
