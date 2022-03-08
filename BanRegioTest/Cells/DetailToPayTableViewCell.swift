//
//  DetailToPayTableViewCell.swift
//  BanRegioTest
//
//  Created by Adrian Dominguez on 08/03/22.
//

import UIKit

class DetailToPayTableViewCell: UITableViewCell {

    @IBOutlet weak var lblIVA: UILabel!
    @IBOutlet weak var lblInteres: UILabel!
    @IBOutlet weak var lblPlazo: UILabel!
    @IBOutlet weak var AmmountToPay: UILabel!
    @IBOutlet weak var lblAmmount: UILabel!
    @IBOutlet weak var lblClient: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(client:String,plazo:String, monto:String,interes:String, iva:String, pago:String){
        lblPlazo.text = plazo
        lblClient.text = client
        lblAmmount.text = monto
        AmmountToPay.text = pago
        lblInteres.text = interes
        lblIVA.text = iva
    }
}
