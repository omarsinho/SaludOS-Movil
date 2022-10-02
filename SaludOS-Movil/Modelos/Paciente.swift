///
//  Paciente.swift
//  SaludOS-Movil
//
//  Created by Invitado on 19/09/22.
//

import UIKit

class Paciente: NSObject {
    var idPaciente: Int
    var nombrePila: String
    var apellidoPaterno: String
    var apellidoMaterno: String
    var fechaNacimiento: Date
    var correoElectronico: String
    var contrasena: String
    var contrasena_hash: String
    var altura: Float
    var peso: Float
    var tipoSangre: String
    
    init(idPaciente: Int, nombrePila: String, apellidoPaterno: String, apellidoMaterno: String, fechaNacimiento: Date, correoElectronico: String, contrasena: String, contrasena_hash: String, altura: Float, peso: Float, tipoSangre: String) {
        self.idPaciente = idPaciente
        self.nombrePila = nombrePila
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.fechaNacimiento = fechaNacimiento
        self.correoElectronico = correoElectronico
        self.contrasena = contrasena
        self.contrasena_hash = contrasena_hash
        //self.contrasena_hash = hashContrasena(contrasena) //Contraseña con la función para hacer la seguridad por medio de hashing
        self.altura = altura
        self.peso = peso
        self.tipoSangre = tipoSangre
    }
}
