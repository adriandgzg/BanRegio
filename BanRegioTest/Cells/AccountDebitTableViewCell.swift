//
//  AccountDebitTableViewCell.swift
//  BanRegioTest
//
//  Created by Adrian Dominguez on 08/03/22.
//

import UIKit

class AccountDebitTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblMonto: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(cliente:String, monto:String, status:String){
        lblCliente.text = cliente
        lblMonto.text = monto
        lblStatus.text = status
    }
}
