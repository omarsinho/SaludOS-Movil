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
            ScrollView {
                VStack {
                    Text("Gráfica Tiempo vs Presión Diastólica, Presión Sistólica, y Pulso")
                        .fontWeight(.bold)
                        .padding()
                        .font(.custom("Noteworthy", size: 22))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Chart(modelo.datosRegistroPresion, id: \.id) { dataPoint in
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
                    .frame(height: 300)
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
                        .font(.custom("PingFang TC", size: 18).italic())
                        .fontWeight(.bold)
                        .padding()
                        .multilineTextAlignment(.center)
                    Text("Media")
                        .font(.custom("PingFang TC", size: 16).italic())
                        .fontWeight(.bold)
                        .padding()
                    Text("Presión Diastólica: \(modelo.mediaDIA, specifier: "%.3f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Presión Sistólica: \(modelo.mediaSYS, specifier: "%.3f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Pulso: \(modelo.mediaPulso, specifier: "%.3f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Moda")
                        .font(.custom("PingFang TC", size: 16).italic())
                        .fontWeight(.bold)
                        .padding()
                    Text("Presión Diastólica: \(modelo.modaDIA, specifier: "%.0f")mmHG aparece \(modelo.vecesDIA) veces")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Presión Sistólica: \(modelo.modaSYS, specifier: "%.0f")mmHG aparece \(modelo.vecesSYS) veces")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Pulso: \(modelo.modaPulso, specifier: "%.0f")mmHG aparece \(modelo.vecesPulso) veces")
                        .font(.custom("PingFang TC", size: 14))
                }
                VStack {
                    Text("Mediana")
                        .font(.custom("PingFang TC", size: 16).italic())
                        .fontWeight(.bold)
                        .padding()
                    Text("Presión Diastólica: \(modelo.medianaDIA, specifier: "%.0f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Presión Sistólica: \(modelo.medianaSYS, specifier: "%.0f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Pulso: \(modelo.medianaPulso, specifier: "%.0f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Desviación Estándar")
                        .font(.custom("PingFang TC", size: 16).italic())
                        .fontWeight(.bold)
                        .padding()
                    Text("Presión Diastólica: \(modelo.DEDIA, specifier: "%.3f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Presión Sistólica: \(modelo.DESYS, specifier: "%.3f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                    Text("Pulso: \(modelo.DEPulso, specifier: "%.3f")mmHG")
                        .font(.custom("PingFang TC", size: 14))
                }
            }
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
