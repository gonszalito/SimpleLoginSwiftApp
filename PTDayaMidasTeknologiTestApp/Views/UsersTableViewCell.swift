//
//  UsersTableViewCell.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 07/03/23.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    static let identifier = "UsersTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private let idLabel: UILabel = {
       
        let t = UILabel()
        t.textColor = .black
        t.font = t.font.withSize(25)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
        
    }()
    
    
    private let usernameLabel: UILabel = {
       
        let t = UILabel()
        t.textColor = .systemRed
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    
    }()
    
    private let emailLabel: UILabel = {
       
        let t = UILabel()
        t.textColor = .systemRed
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    
    }()
    
    private let roleLabel: UILabel = {
       
        let t = UILabel()
        t.textColor = .systemRed
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainStackView())
        contentView.addSubview(idLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(roleLabel)


        applyConstraints()
    }
    
    private func applyConstraints() {

        let idLabelConstraints = [
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            idLabel.widthAnchor.constraint(equalToConstant: 50),
            idLabel.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let usernameConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor,constant: 40),
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            usernameLabel.widthAnchor.constraint(equalToConstant: 50),
            usernameLabel.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let emailConstraints = [
            emailLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor,constant: 40),
            emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            emailLabel.widthAnchor.constraint(equalToConstant: 50),
            emailLabel.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let roleConstraints = [
            roleLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor,constant: 40),
            roleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            roleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            roleLabel.widthAnchor.constraint(equalToConstant: 50),
            roleLabel.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(idLabelConstraints)
        NSLayoutConstraint.activate(usernameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(roleConstraints)

    }
    
    public func configure(with model: UserProfile) {

        idLabel.text = String(model.id)
        usernameLabel.text = model.username
        emailLabel.text = model.email
        
        if(model.role == true){
            roleLabel.text = "Admin"
            
        }else {
            roleLabel.text = "User"
            
        }
    
        

    }
    
    
    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [idLabel,
                                                       usernameLabel,
                                                       emailLabel,
                                                       roleLabel
                                                      ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
