//
//  VistaGrafica.swift
//  SaludOS-Movil
//
//  Created by Juan Daniel Rodríguez Oropeza on 12/10/22.
//

import SwiftUI
import Charts
import FirebaseAuth
import Firebase

struct VistaGrafica: View {
    
    @ObservedObject var modelo = VistaModelo()
    
    //typealias Graf = (fechaYHoraToma: String, presionDiastolica: Int, presionSistolica: Int, pulso: Int)
    
    //var data: [Grafica] = []
    
    var body: some View {
        /*List(modelo.list) {item in
            data.append(modelo.list)
        }*/
        Chart(modelo.datosRegistroPresion) { dataPoint in
            LineMark(x: .value("Día", dataPoint.fechaYHoraToma), y: .value("Presión Diastólica", dataPoint.presionDiastolica))
        }
        /*.chartXAxis {
            AxisMarks(values: .stride(by: .))
        }*/
    }
    
    init() {
        modelo.getData()
    }
}

struct VistaGrafica_Previews: PreviewProvider {
    static var previews: some View {
        VistaGrafica()
    }
}
