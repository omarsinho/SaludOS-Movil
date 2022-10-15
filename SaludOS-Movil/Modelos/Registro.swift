//
//  Registro.swift
//  SaludOS-Movil
//
//  Created by user220808 on 10/15/22.
//

import UIKit

class Registro {
    let comentarios : String
    let fechayHoraToma:Date
    let hicisteEjercicio :Bool
    let medidorEmocional:Double
    let presionDiastolica:Double
    let presionSistolica:Double
    let pulso: Double
    init(comentarios: String, fechayHoraToma: Date, hicisteEjercicio: Bool, medidorEmocional: Double, presionDiastolica: Double, presionSistolica: Double, pulso: Double) {
        self.comentarios = comentarios
        self.fechayHoraToma = fechayHoraToma
        self.hicisteEjercicio = hicisteEjercicio
        self.medidorEmocional = medidorEmocional
        self.presionDiastolica = presionDiastolica
        self.presionSistolica = presionSistolica
        self.pulso = pulso
    }
}
