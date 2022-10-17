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
    //@State var mostrarAlerta = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            VStack {
                Text("Gráfica Tiempo vs Presión Diastólica, Presión Sistólica, y Pulso")
                    .fontWeight(.bold)
                    .padding()
                    .font(.custom("Noteworthy", size: 22))
                    .multilineTextAlignment(.center)
                Spacer()
                Chart(modelo.datosRegistroPresion, id: \.fechaYHoraToma) { dataPoint in
                    LineMark(x: .value("Día", dataPoint.fechaYHoraToma), y: .value("Presión Diastólica", dataPoint.presionDiastolica))
                        .foregroundStyle(by: .value("Value", "Presión Diastólica"))
                    LineMark(x: .value("Día", dataPoint.fechaYHoraToma), y: .value("Presión Sistólica", dataPoint.presionSistolica))
                        .foregroundStyle(by: .value("Value", "Presión Sistólica"))
                    LineMark(x: .value("Día", dataPoint.fechaYHoraToma), y: .value("Pulso", dataPoint.pulso))
                        .foregroundStyle(by: .value("Value", "Pulso"))
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(format: .dateTime.day())
                    }
                    
                }
                .chartYAxis {
                    AxisMarks(values: .stride(by: 10))
                }
            }
        }
        .alert("Error", isPresented: $modelo.NOSePuedeMostrar) {
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("No tienes suficientes registros de presión arterial para poder graficar. Necesitas tener al menos dos.")
        }
        VStack {
            Text("Datos Estadísticos")
                .font(.custom("Hoefler Text", size: 18).italic())
                .fontWeight(.bold)
                .padding()
                .multilineTextAlignment(.center)
            Text("Media")
                .font(.custom("Hoefler Text", size: 16).italic())
                .fontWeight(.bold)
                .padding()
            Text("Presión Diastólica: \(modelo.mediaDIA)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Presión Sistólica: \(modelo.mediaSYS)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Pulso: \(modelo.mediaPulso)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Moda")
                .font(.custom("Hoefler Text", size: 16).italic())
                .fontWeight(.bold)
                .padding()
            Text("Presión Diastólica: \(modelo.modaDIA)mmHG aparece \(modelo.vecesDIA) veces")
                .font(.custom("Hoefler Text", size: 14))
            Text("Presión Sistólica: \(modelo.modaSYS)mmHG aparece \(modelo.vecesSYS) veces")
                .font(.custom("Hoefler Text", size: 14))
            Text("Pulso: \(modelo.modaPulso)mmHG aparece \(modelo.vecesPulso) veces")
                .font(.custom("Hoefler Text", size: 14))
        }
        VStack {
            Text("Mediana")
                .font(.custom("Hoefler Text", size: 16).italic())
                .fontWeight(.bold)
                .padding()
            Text("Presión Diastólica: \(modelo.medianaDIA)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Presión Sistólica: \(modelo.medianaSYS)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Pulso: \(modelo.medianaPulso)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Desviación Estándar")
                .font(.custom("Hoefler Text", size: 16).italic())
                .fontWeight(.bold)
                .padding()
            Text("Presión Diastólica: \(modelo.DEDIA)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Presión Sistólica: \(modelo.DESYS)mmHG")
                .font(.custom("Hoefler Text", size: 14))
            Text("Pulso: \(modelo.DEPulso)mmHG")
                .font(.custom("Hoefler Text", size: 14))
        }
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
