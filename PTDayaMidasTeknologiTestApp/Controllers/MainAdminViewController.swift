//
//  MainViewController.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 07/03/23.
//

import UIKit

class MainAdminViewController: UIViewController {

    private let mainViewTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.identifier)
  
        return table
    }()
    
    private var users: [UserProfile] = [UserProfile]()
    
    let logoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .black
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.setAnchor(width: 100, height: 50)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.backgroundColor = .systemBackground
        view.addSubview(mainViewTable)
        view.addSubview(logoutButton)
        
        logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: self.view.bottomAnchor ,constant: -100
        ).isActive = true
        
        mainViewTable.delegate = self
        mainViewTable.dataSource = self
        
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        

        
    }
    func reloadTable() {
        mainViewTable.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainViewTable.frame = view.bounds
    }
    
    
    @objc func handleLogout() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadData(){
        DataPersistenceManager.shared.fetchingUsersFromDatabase { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                DispatchQueue.main.async {
                    self?.mainViewTable.reloadData()
                }
   
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension MainAdminViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as? UsersTableViewCell else {
            return UITableViewCell()
        }
    
        
        let model = users[indexPath.row]
        cell.configure(with: model)

        return cell

    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Delete = UITableViewRowAction(style: .destructive, title: "Delete") { [self] action, index in
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }
            
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(users[indexPath.row])
            self.mainViewTable.reloadData()
            
            DataPersistenceManager.shared.deleteUserWith(model: users[indexPath.row]) {[weak self] result in
                switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self?.mainViewTable.reloadData()
                    }
       
                case .failure(let error):
                    print(error.localizedDescription)
                }            }
            
            reloadTable()
        }
        
        return [ Delete]
        
    }
}
