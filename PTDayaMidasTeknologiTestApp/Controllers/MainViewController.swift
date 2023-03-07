//
//  MainViewController.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 07/03/23.
//

import UIKit

class MainViewController: UIViewController {

    private let mainViewTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(AlbumsTableViewCell.self, forCellReuseIdentifier: AlbumsTableViewCell.identifier)
  
        return table
    }()
    
    private var albums: [Album] = [Album]()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainViewTable.frame = view.bounds
    }
    
    
    @objc func handleLogout() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadData() {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([Album].self, from: data) {
                        DispatchQueue.main.async {
                            self.albums = response
                            
                        }
                        return
                    }
                }
            }.resume()
        }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumsTableViewCell.identifier, for: indexPath) as? AlbumsTableViewCell else {
            return UITableViewCell()
        }
    
        
        let model = albums[indexPath.row]
        cell.configure(with: model)

        return cell

    }
}
