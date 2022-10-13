//
//  Camera_VC.swift
//  SaludOS-Movil
//
//  Created by Alumno on 10/10/22.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import Firebase

class Camera_VC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnCerrar: UIButton!
    @IBOutlet weak var btnCamara: UIButton!
    @IBOutlet weak var btnGaleria: UIButton!
    @IBOutlet weak var lbEsperar: UILabel!
    @IBOutlet weak var viewOpcionesFoto: UIView!
    
    
    var foto = UIImage()
    let imagePicker = UIImagePickerController()
    
    private let storage = Storage.storage().reference()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        
        btnCerrar.isHidden = false
        btnCamara.isHidden = false
        btnGaleria.isHidden = false
        lbEsperar.isHidden = true
        viewOpcionesFoto.isHidden = false
    }
    
    @IBAction func Camera(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func Gallery(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        //foto = img!
        
        guard let imageData = img.pngData() else {
            return
        }
        
        btnCerrar.isHidden = true
        btnCamara.isHidden = true
        btnGaleria.isHidden = true
        lbEsperar.isHidden = false
        viewOpcionesFoto.isHidden = true
        
        storage.child("imgPacientes/\(Auth.auth().currentUser!.uid).png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("No se pudo subir")
                return
            }
            
            self.storage.child("imgPacientes/\(Auth.auth().currentUser!.uid).png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                let urlString = url.absoluteString
                
                /*DispatchQueue.main.async {
                    self.foto = img
                }*/
                
                print("Primer Hola")
                UserDefaults.standard.set(urlString, forKey: "url")
                
                print(urlString)
                print("Hola")
                
                self.db.collection("Paciente").document(Auth.auth().currentUser!.uid).setData(["urlImg": urlString], merge: true) {
                    (error) in
                    
                    if error != nil {
                        let alerta = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                        let accion = UIAlertAction(title: "OK", style: .cancel)
                        alerta.addAction(accion)
                        self.present(alerta, animated: true)
                    }
                }
            })
         })
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 19) {
            // code to remove your view
            self.dismiss(animated: true, completion: nil)
        }
        
        /*let alerta = UIAlertController(title: "Espera", message: "Espera un momento mientras se guardan los cambios.", preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .cancel)
            alerta.addAction(accion)
        present(alerta, animated: true)*/
    }
    
    
    @IBAction func Regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
