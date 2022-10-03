//
//  PopUp_VCToken.swift
//  SaludOS-Movil
//
//  Created by Alumno on 03/10/22.
//

import UIKit

class PopUp_VCToken: UIViewController {

    var token : String!
    
    @IBOutlet weak var lbToken: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = makeDaToken()
        if pushToBD(message: token) {
            lbToken.text = token
        } else {
            lbToken.text = "Error, mala conexión"
            let alert = UIAlertController(title: "Error de Conexión", message: "Porfavor checar tu internet y volver a intentar mas tarde", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default))
             self.present(alert, animated: true, completion: nil)
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
    
    func pushToBD(message: String) -> Bool{
        if lbToken != nil {
            // Push to BD?
            print(message)
            return true
        }
        return false
    }
    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
