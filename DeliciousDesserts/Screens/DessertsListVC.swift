//
//  DessertsListVC.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/16/22.
//

import UIKit

class DessertsListVC: UITableViewController {
    
    var desserts: [Dessert] = []
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        getDesserts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Desserts"
    }
    
    func configureTableView() {
        tableView.rowHeight = 80
        tableView.removeExcessCells()
        tableView.register(DessertCell.self, forCellReuseIdentifier: DessertCell.reuseID)
    }
    
    func getDesserts() {
        networkManager.getDesserts { [weak self]
            (result: Result<[Dessert], DDError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let desserts):
                self.updateUI(with: desserts)
            case .failure(_):
                #warning("Implement error handling")
            }
        }
    }
    
    func updateUI(with desserts: [Dessert]) {
        self.desserts = desserts
        reloadDataOnMainThread()
    }
    
}

extension DessertsListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desserts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DessertCell.reuseID) as! DessertCell
        let dessert = desserts[indexPath.row]
        cell.set(dessert: dessert)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dessert = desserts[indexPath.row]
        let detailVC = DessertDetailVC(dessert: dessert, networkManager: networkManager)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
