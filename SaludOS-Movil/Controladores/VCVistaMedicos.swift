//
//  VCVistaMedicos.swift
//  SaludOS-Movil
//
//  Created by Alumno on 29/09/22.
//

import UIKit

class VCVistaMedicos: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listaMedicos = ["Jose", "Pepe", "Juan"]
    var listaTitulos = ["Podologo", "Pediatra", "Cardiovasculeno"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cierraView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaMedicos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "idCell")!
        celda.textLabel?.text = listaMedicos[indexPath.row]
        celda.detailTextLabel?.text = "\(listaTitulos[indexPath.row])"
        celda.imageView?.image = UIImage(named: "medic")
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
