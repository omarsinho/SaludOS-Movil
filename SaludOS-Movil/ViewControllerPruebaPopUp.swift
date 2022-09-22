//
//  ViewControllerPruebaPopUp.swift
//  SaludOS-Movil
//
//  Created by Invitado on 21/09/22.
//

import UIKit

class ViewControllerPruebaPopUp: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var medicos = [Medico]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
     @IBAction func cierraView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda")!
        return celda
    }
}
