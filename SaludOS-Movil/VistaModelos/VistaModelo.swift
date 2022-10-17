//
//  VistaModelo.swift
//  SaludOS-Movil
//
//  Created by Juan Daniel Rodríguez Oropeza on 12/10/22.
//

import Foundation
import Firebase
import FirebaseAuth

class VistaModelo: ObservableObject {
    let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @Published var datosRegistroPresion = [Grafica]()
    
    //var arregloID = ["Hola"]
    //var arregloFecha = [Date()]
    var arregloDIA = [1]
    var arregloSYS = [1]
    var arregloPulso = [1]
    
    /*var arregloIDOrd = ["Hola"]
    var arregloFechaOrd = [Date()]
    var arregloDIAOrd = [1]
    var arregloSYSOrd = [1]
    var arregloPulsoOrd = [1]*/
    
    var sumDIA = 1
    var sumSYS = 1
    var sumPulso = 1
    var cantidadDatos = 1
    @Published var NOSePuedeMostrar = false
    
    @Published var mediaDIA = 1.1
    @Published var mediaSYS = 1.1
    @Published var mediaPulso = 1.1
    
    // Create dictionary to map value to count
    var countsDIA = [Int: Int]()
    var countsSYS = [Int: Int]()
    var countsPulso = [Int: Int]()
    
    @Published var modaDIA = 1
    @Published var modaSYS = 1
    @Published var modaPulso = 1
    
    @Published var vecesDIA = 1
    @Published var vecesSYS = 1
    @Published var vecesPulso = 1
    
    @Published var medianaDIA = 1
    @Published var medianaSYS = 1
    @Published var medianaPulso = 1
    
    var varDIA = 1.1
    var varSYS = 1.1
    var varPulso = 1.1
    
    @Published var DEDIA = 1.1
    @Published var DESYS = 1.1
    @Published var DEPulso = 1.1
    
    func getData() {
        let db = Firestore.firestore() // Obtener una referencia hacia la base de datos.
        
        // Leer los documentos en un trayecto específico
        db.collection("RegistroPresion").whereField("uidPaciente", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { snapshot, error in
            // Checa si hay errores
            if error == nil {
                // No hay errores
                if let snapshot = snapshot {
                    // Actualiza la lista en el hilo principal
                    if snapshot.documents.count < 2 {
                        self.NOSePuedeMostrar = true
                        return
                    }
                    DispatchQueue.main.async {
                        // Se obtienen los documentos y crea "Grafica"
                        self.datosRegistroPresion = snapshot.documents.map { d in
                            // Crea un objeto "Grafica" por cada documento retornado
                            return Grafica(id: d.documentID, fechaYHoraToma: d["fechaYHoraToma"] as? Date ?? Date(), presionDiastolica: d["presionDiastolica"] as? Int ?? 0, presionSistolica: d["presionSistolica"] as? Int ?? 0, pulso: d["pulso"] as? Int ?? 0)
                        }
                        
                        //self.datosRegistroPresion.map { (id: $0.1, fechaYHoraToma: dateFormatter.date(from: $0.0)!, presionDiastolica: $0.1, presionSistolica: $0.1, pulso: $0.1)}

                        self.arregloDIA.remove(at: 0)
                        self.arregloSYS.remove(at: 0)
                        self.arregloPulso.remove(at: 0)
                        

                        
                        for doc in snapshot.documents {
                            //self.arregloID.append(doc.documentID)
                            //self.arregloFecha.append(doc["fechaYHoraToma"] as? Date ?? Date())
                            self.arregloDIA.append(doc["presionDiastolica"] as? Int ?? 0)
                            self.arregloSYS.append(doc["presionSistolica"] as? Int ?? 0)
                            self.arregloPulso.append(doc["pulso"] as? Int ?? 0)
                            self.cantidadDatos += 1
                            self.sumDIA += doc["presionDiastolica"] as? Int ?? 0
                            self.sumSYS += doc["presionSistolica"] as? Int ?? 0
                            self.sumPulso += doc["pulso"] as? Int ?? 0
                        }
                        
                        
                        // Count the values with using forEach
                        self.arregloDIA.forEach { self.countsDIA[$0] = (self.countsDIA[$0] ?? 0) + 1 }
                        self.arregloSYS.forEach { self.countsSYS[$0] = (self.countsSYS[$0] ?? 0) + 1 }
                        self.arregloPulso.forEach { self.countsPulso[$0] = (self.countsPulso[$0] ?? 0) + 1 }
                        
                        if let (value, count) = self.countsDIA.max(by: {$0.1 < $1.1}) {
                            self.modaDIA = value
                            self.vecesDIA = count
                        }
                        if let (value, count) = self.countsSYS.max(by: {$0.1 < $1.1}) {
                            self.modaSYS = value
                            self.vecesSYS = count
                        }
                        if let (value, count) = self.countsPulso.max(by: {$0.1 < $1.1}) {
                            self.modaPulso = value
                            self.vecesPulso = count
                        }
                        
                        self.medianaDIA = self.arregloDIA.sorted(by: <)[self.arregloDIA.count / 2]
                        self.medianaSYS = self.arregloSYS.sorted(by: <)[self.arregloSYS.count / 2]
                        self.medianaPulso = self.arregloPulso.sorted(by: <)[self.arregloPulso.count / 2]
                        
                        self.cantidadDatos = self.arregloDIA.count
                        
                        self.mediaDIA = Double(self.sumDIA) / Double(self.cantidadDatos)
                        self.mediaSYS = Double(self.sumSYS) / Double(self.cantidadDatos)
                        self.mediaPulso = Double(self.sumPulso) / Double(self.cantidadDatos)
                        
                        self.varDIA = 0
                        self.varSYS = 0
                        self.varPulso = 0
                        
                        for valor in stride(from: 0, through: self.cantidadDatos - 1, by: 1) {
                            self.varDIA += pow((Double(self.arregloDIA[valor]) - self.mediaDIA), 2)
                            self.varSYS += pow((Double(self.arregloSYS[valor]) - self.mediaSYS), 2)
                            self.varPulso += pow((Double(self.arregloPulso[valor]) - self.mediaPulso), 2)
                        }
                        
                        self.DEDIA = sqrt(self.varDIA)
                        self.DESYS = sqrt(self.varSYS)
                        self.DEPulso = sqrt(self.varPulso)
                    }
                }
            }
        }
    }
}
