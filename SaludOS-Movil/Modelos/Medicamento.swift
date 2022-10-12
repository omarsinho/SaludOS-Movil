//
//  Medicamento.swift
//  SaludOS-Movil
//
//  Created by user220808 on 10/12/22.
//

import UIKit

class Medicamento {
    let nombre : String
    let fechaLimite: String
    let frecuencia: String
    let cantidad : String
    
    init(nombre:String, fechaLimite: String, frecuencia:String, cantidad:String){
        self.nombre = nombre
        self.fechaLimite = fechaLimite
        self.frecuencia = frecuencia
        self.cantidad = cantidad
    }
}
