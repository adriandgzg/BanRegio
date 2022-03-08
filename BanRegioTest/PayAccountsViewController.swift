//
//  PayAccountsViewController.swift
//  BanRegioTest
//
//  Created by Adrian Dominguez on 08/03/22.
//

import UIKit

class PayAccountsViewController: UIViewController {
    var dataSource : [AccountBalance] = []
    @IBOutlet weak var tablevView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tablevView.register(UINib(nibName: String(describing: DetailToPayTableViewCell.self), bundle: nil), forCellReuseIdentifier: NSStringFromClass(DetailToPayTableViewCell.self))
        // Do any additional setup after loading the view.
        tablevView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        dataSource = DataSourceManager.shared.getBalanceAccount(ApplyPay: false)
        tablevView.reloadData()
    }

    @IBAction func btnAplicarPagos(_ sender: Any) {
        
        DataSourceManager.shared.proccesToPay(balances: dataSource)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dismis(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PayAccountsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DetailToPayTableViewCell.self), for: indexPath) as? DetailToPayTableViewCell
        else { return UITableViewCell() }
        if dataSource[indexPath.row] != nil {
            let client = dataSource[indexPath.row]
            cell.setup(client:client.client, plazo: client.plazo, monto: String(format: "%.2f", client.ammount), interes:String(format:"%.2f", client.Interes), iva: String(format:"%.2f",client.IVA), pago: String(format:"%.2f",client.ammountToPay))
        }
        
        return cell
    }
    
}
