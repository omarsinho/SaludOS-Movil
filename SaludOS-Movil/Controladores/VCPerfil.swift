//
//  VCPerfil.swift
//  SaludOS-Movil
//
//  Created by Alumno on 20/09/22.
//

import UIKit
import FirebaseAuth
import Firebase

class VCPerfil: UIViewController {

    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var imgPerfil: UIImageView!
    
    //var foto = UIImage()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imgPerfil.image = foto
        
        db.collection("Paciente").document(Auth.auth().currentUser!.uid).getDocument {
            (documentSnapshot, error) in
            if let document = documentSnapshot, error == nil {
                if let nombrePila = document.get("nombrePila") as? String, let apellidoP = document.get("apellidoPaterno") as? String, let apellidoM = document.get("apellidoMaterno") as? String {
                    self.lbNombre.text = nombrePila + " " + apellidoP + " " + apellidoM
                }
            }
            else {
                self.lbNombre.text = error?.localizedDescription
            }
        }
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        
        print("Hola, aparecí de nuevo")
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
            return
        }
        
        print(urlString)
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let foto = UIImage(data: data)
                self.actualizaFoto(imagen: foto ?? UIImage(systemName: "heart.fill")!)
            }
            
            
        })
        
        task.resume()
    }
    
    func actualizaFoto(imagen : UIImage) {
        imgPerfil.image = imagen
    }
    
    
    @IBAction func CerrarSesion(_ sender: UIButton) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            performSegue(withIdentifier: "PerfilALogin", sender: self)
        }
        catch let signOutError {
            let alerta = UIAlertController(title: "Error", message: signOutError.localizedDescription, preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel)
                alerta.addAction(accion)
            present(alerta, animated: true)
        }
    }
    
}
