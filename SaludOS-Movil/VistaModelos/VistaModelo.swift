//
//  VistaModelo.swift
//  SaludOS-Movil
//
//  Created by Juan Daniel Rodríguez Oropeza on 12/10/22.
//

import Foundation
import Firebase

class VistaModelo: ObservableObject {
    @Published var datosRegistroPresion = [Grafica]()
    
    /*let dateformatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }*/
    
    func getData() {
        let db = Firestore.firestore() // Obtener una referencia hacia la base de datos.
        
        // Leer los documentos en un trayecto específico
        db.collection("RegistroPresion").getDocuments { snapshot, error in
            // Checa si hay errores
            if error == nil {
                // No hay errores
                if let snapshot = snapshot {
                    // Actualiza la lista en el hilo principal
                    DispatchQueue.main.async {
                        // Se obtienen los documentos y crea "Grafica"
                        self.datosRegistroPresion = snapshot.documents.map { d in
                            // Crea un objeto "Grafica" por cada documento retornado
                            return Grafica(id: d.documentID, fechaYHoraToma: d["fechaYHoraToma"] as? Date ?? Date(), presionDiastolica: d["presionDiastolica"] as? Int ?? 0, presionSistolica: d["presionSistolica"] as? Int ?? 0, pulso: d["pulso"] as? Int ?? 0)
                        }
                    }
                }
            }
        }
        
        /*for dato in list {
            datos.append((dato.fechaYHoraToma, dato.presionDiastolica, dato.presionSistolica, dato.pulso))
        }*/
        
        //print("Ya lo hice")
    }
}
