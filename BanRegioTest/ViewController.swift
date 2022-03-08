//
//  ViewController.swift
//  BanRegioTest
//
//  Created by Adrian Dominguez on 08/03/22.
//

import UIKit

class ViewController: UIViewController {

    var dataSource : [AccountDebit] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: String(describing: AccountDebitTableViewCell.self), bundle: nil), forCellReuseIdentifier: NSStringFromClass(AccountDebitTableViewCell.self))
        // Do any additional setup after loading the view.
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataSource = DataSourceManager.shared.GetDebitAccount()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController(title: "Carga de datos", message: "Carga de datos correcta", preferredStyle: .alert)

            // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
          

            // Add the actions
            alertController.addAction(okAction)

            // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func gotoCalculate(_ sender: Any) {
        let vc = PayAccountsViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(AccountDebitTableViewCell.self), for: indexPath) as? AccountDebitTableViewCell
        else { return UITableViewCell() }
        if dataSource[indexPath.row] != nil {
            let client = dataSource[indexPath.row]
            cell.setup(cliente: client.client, monto: String(client.ammount), status: client.status)
        }
        
        return cell
    }
    
}
