//
//  DessertDetailVC.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/18/22.
//

import UIKit

class DessertDetailVC: UIViewController {
    
    let tableView = UITableView()
    
    var dessert: Dessert
    var details: Details?
    var networkManager: NetworkManagerProtocol
    
    init(dessert: Dessert, networkManager: NetworkManagerProtocol) {
        self.dessert = dessert
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
        
        title = dessert.strMeal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        getDetails(dessert: dessert)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.reuseID)
        tableView.register(InstructionsCell.self, forCellReuseIdentifier: InstructionsCell.reuseID)
    }
    
    func getDetails(dessert: Dessert) {
        networkManager.getDetails(for: dessert.idMeal) { [weak self] (result: Result<Details, DDError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.updateUI(with: response)
            case .failure(_):
                #warning("Implement error handling")
            }
        }
    }
    
    func updateUI(with details: Details) {
        self.details = details
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension DessertDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let details = details else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.reuseID) as! IngredientsCell
            cell.set(details: details)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsCell.reuseID) as! InstructionsCell
        cell.set(details: details)
        return cell
    }
}
