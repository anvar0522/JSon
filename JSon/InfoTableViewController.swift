//
//  InfoTableViewController.swift
//  JSon
//
//  Created by anvar on 14/02/22.
//

import UIKit

class InfoTableViewController: UITableViewController {
    var urlXXX = "https://api.wazirx.com/api/v2/trades?market=btcusdt"
    var BtcMarket: [Market] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BtcMarket.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketInfo", for: indexPath)
      
        let markets = BtcMarket[indexPath.row]
      
        var content = cell.defaultContentConfiguration()
        
        content.secondaryText = "Price\(markets.price)"
        content.text = "Id:\(markets.id)"
        
        cell.contentConfiguration = content

         

        return cell
    }

    func fetchData() {
        NetworkManager.shared.fetch(dataType: [Market].self, from: urlXXX) { result in
            switch result {
                case .success(let market):
                self.BtcMarket = market
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

 
