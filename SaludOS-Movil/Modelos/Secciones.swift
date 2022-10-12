//
//  Secciones.swift
//  SaludOS-Movil
//
//  Created by user220808 on 10/11/22.
//

import UIKit

// Clase utilizada para la creación de table views con celdas expandibles

class Secciones {
    let titulo:String
    let opciones:[String]
    var abierto:Bool = false
    init(titulo: String, opciones:[String], abierto:Bool = false){
        self.titulo = titulo
        self.opciones = opciones
        self.abierto = abierto
    }
    
}
