///
//  Paciente.swift
//  SaludOS-Movil
//
//  Created by Invitado on 19/09/22.
//

import UIKit

class Paciente: NSObject {
    var idPaciente: String
    var nombrePila: String
    var apellidoPaterno: String
    var apellidoMaterno: String
    var fechaNacimiento: String
    var correoElectronico: String
    var contrasena: String
    var altura: Float
    var peso: Float
    var tipoSangre: String
    
    init(idPaciente: String, nombrePila: String, apellidoPaterno: String, apellidoMaterno: String, fechaNacimiento: String, correoElectronico: String, contrasena: String, contrasena_hash: String, altura: Float, peso: Float, tipoSangre: String) {
        self.idPaciente = idPaciente
        self.nombrePila = nombrePila
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.fechaNacimiento = fechaNacimiento
        self.correoElectronico = correoElectronico
        self.contrasena = contrasena
        self.altura = altura
        self.peso = peso
        self.tipoSangre = tipoSangre
    }
}
