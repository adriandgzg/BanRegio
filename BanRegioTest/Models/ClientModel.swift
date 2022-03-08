//
//  ClientModel.swift
//  BanRegioTest
//
//  Created by Adrian Dominguez on 08/03/22.
//

import Foundation

class Prestamos {
    var client : String
    var clientId: String
    var date : String
    var ammount : Double
    var status : String
    
    init(client:String,clientId: String,date : String, ammount :Double, status : String){
        self.client = client
        self.clientId = clientId
        self.date = date
        self.status = status
        self.ammount = ammount
    }
}


class AccountDebit {
    var client : String
    var ammount : Double
    var status :String
    init(client:String,ammount : Double,status :String){
        self.client = client
        self.ammount = ammount
        self.status = status
    }
}


class AccountBalance {
    var client : String
    var ammount : Double
    var plazo : String
    var Interes : Double
    var IVA : Double
    var ammountToPay : Double
    var dateOfPRestamo:String
    
    init(client : String, ammount : Double, plazo : String, Interes : Double, IVA : Double, ammountToPay : Double, dateOfPRestamo:String){
        self.client = client
        self.ammount = ammount
        self.plazo = plazo
        self.Interes = Interes
        self.IVA  = IVA
        self.ammountToPay = ammountToPay
        self.dateOfPRestamo = dateOfPRestamo
    }
}
