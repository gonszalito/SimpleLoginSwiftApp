//
//  AlbumsTableViewCell.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 07/03/23.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    static let identifier = "AlbumsTableViewCell"

    private let idLabel: UILabel = {
       
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
        
    }()
    
    
    private let titleLabel: UILabel = {
       
        let t = UILabel()
        t.textColor = .systemRed
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    
    }()
    
    private let urlImage: UIImageView = {
       
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        i.clipsToBounds = true
        i.setAnchor(width: 400, height: 400)
        return i
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainStackView())

        
        applyConstraints()
    }
    
    private func applyConstraints() {
//        let idLabelConstraints = [
//            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//            idLabel.widthAnchor.constraint(equalToConstant: 10),
//            idLabel.heightAnchor.constraint(equalToConstant: 200)
//        ]
//
//        let titleLabelConstraints = [
//            titleLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
//        ]
//
//        let urlImageConstraints = [
//            urlImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -20),
//            urlImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            urlImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//        ]
//
        
        let stackConstraints = [
            
            mainStackView().centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainStackView().centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainStackView().widthAnchor.constraint(equalToConstant: 200),
            mainStackView().heightAnchor.constraint(equalToConstant: 200)
            
        ]
        
//        NSLayoutConstraint.activate(idLabelConstraints)
//        NSLayoutConstraint.activate((titleLabelConstraints))
//        NSLayoutConstraint.activate(urlImageConstraints)
        NSLayoutConstraint.activate(stackConstraints)
    }
    
    public func configure(with model: Album) {

        idLabel.text = String(model.id)
        urlImage.loadFrom(URLAddress: model.url)
        titleLabel.text = model.title

    }
    
    
    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [idLabel,
                                                       titleLabel,
                                                       urlImage,
                                                      ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
