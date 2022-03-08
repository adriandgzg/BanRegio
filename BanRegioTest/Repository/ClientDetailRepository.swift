//
//  ClientDetailRepository.swift
//  BanRegioTest
//
//  Created by Adrian Dominguez on 08/03/22.
//

import Foundation


class DataSourceManager {
    static let shared = DataSourceManager()
    
    var ArrPrestamos  : [Prestamos] = []
    var arrAccountDebit : [AccountDebit] = []
    
    var Fecha_Actual =  "15-feb-2021"
    var Tasa_Interes = 7.5
    var Tasa_IVA = 16.0
    var Dias_Año_Comercial = 360
    
    init (){
        var p1 = Prestamos(client: "00103228", clientId: "1", date: "10-ene-2021", ammount: 37500.00, status: "Pendiente")
        var p2 = Prestamos(client: "00103228", clientId: "2", date: "19-ene-2021", ammount: 725.18, status: "Pendiente")
        var p3 = Prestamos(client: "00103228", clientId: "3", date: "31-ene-2021", ammount: 1578.22, status: "Pendiente")
        var p4 = Prestamos(client: "00103228", clientId: "4", date: "04-feb-2021", ammount: 380.00, status: "Pendiente")
        var p5 = Prestamos(client: "70099925", clientId: "1", date: "07-ene-2021", ammount: 2175.25, status: "Pagado")
        var p6 = Prestamos(client: "70099925", clientId: "2", date: "13-ene-2021", ammount: 499.99, status: "Pagado")
        var p7 = Prestamos(client: "70099925", clientId: "3", date: "24-ene-2021", ammount: 5725.18, status: "Pendiente")
        var p8 = Prestamos(client: "70099925", clientId: "4", date: "07-feb-2021", ammount: 876.13, status: "Pendiente")
        var p9 = Prestamos(client: "00298185", clientId: "1", date: "04-feb-2021", ammount: 545.55, status: "Pendiente")
        var p10 = Prestamos(client: "15000125", clientId: "1", date: "31-dic-2020", ammount: 15220.00, status: "Pagado")
        
        ArrPrestamos = [p1, p2, p3, p4, p5 , p6 , p7, p8, p9,p10]
        
        let d1 = AccountDebit(client: "00103228", ammount: 15375.28, status: "Activa")
        let d2 = AccountDebit(client: "70099925", ammount: 3728.51, status: "Bloqueada")
        let d3 = AccountDebit(client: "00298185", ammount: 0.0, status: "Cancelada")
        let d4 = AccountDebit(client: "15000125", ammount: 0.0, status: "Activa")
        
        arrAccountDebit = [d1, d2, d3, d4]
    }
    
    public func GetDebitAccount()-> [AccountDebit]{
        return self.arrAccountDebit
    }
    
    func getBalanceAccount(ApplyPay:Bool)-> [AccountBalance]{
      
        
        var arrResult : [AccountBalance] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        guard  let fechaActual =  dateFormatter.date(from: Fecha_Actual) else {return [] }
        
        
        for cliente in arrAccountDebit.filter{$0.status == "Activa"}
        {
            
            let prestamos = ArrPrestamos.filter{$0.client == cliente.client }
            for prestamo in prestamos {
                if prestamo.status != "Pagado" {
                guard let fechaPrestamo  = dateFormatter.date(from: prestamo.date) else { return []}
                let calendar = Calendar.current

                // Replace the hour (time) of both dates with 00:00
                let date1 = calendar.startOfDay(for: fechaActual)
                let date2 = calendar.startOfDay(for: fechaPrestamo)

                let components = calendar.dateComponents([.day], from: date2, to: date1)
             
                
                let interes =  prestamo.ammount * Double(components.day ?? 1) * (Tasa_Interes / 100) / Double(Dias_Año_Comercial)
                
                let IVA = interes * Tasa_IVA
                
                let pago = prestamo.ammount + interes + IVA
                
                let resumen = AccountBalance(client: cliente.client, ammount: cliente.ammount, plazo:String(components.day ?? 1), Interes: interes, IVA: IVA, ammountToPay: pago, dateOfPRestamo: prestamo.date)
                
                arrResult.append(resumen)
            }
            }
            
        }
        
        return arrResult
    }
    
    func proccesToPay(balances:[AccountBalance]){
        
        for balance in balances {
            
                //decontamos del debito
                guard let  debitAccount = arrAccountDebit.filter{$0.client == balance.client}.first else { break }
            
            if balance.ammount >= balance.ammountToPay {
                debitAccount.ammount = debitAccount.ammount  - balance.ammountToPay
                
               guard let creditStatus = ArrPrestamos.filter{$0.client == balance.client && $0.date == balance.dateOfPRestamo }.first else {break}
                
                creditStatus.status = "Pagado"
            }
               
            
        }
        
    }
}
