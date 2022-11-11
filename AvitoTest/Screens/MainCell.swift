//
//  MainCell.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 07.11.2022.
//

import UIKit

final class MainCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuceID = "MainCell"
    
    private lazy var personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        addSubview(personImage)
        addSubview(nameLabel)
        addSubview(phoneNumberLabel)
        addSubview(skillsLabel)
    }
    
    func configure(employees: Employees) {
        self.nameLabel.text = employees.name
        self.phoneNumberLabel.text = "Phone: " + employees.phoneNumber
        let skills = employees.skills.joined(separator: ", ")
        self.skillsLabel.text = skills
    }
}

extension MainCell {
    
    //MARK: Layout
    
    private struct Layout {
        static let personImageHeightWidth = 50.0
        static let standartLayout = 10.0
    }
    
    private func setupConstraints() {
        
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            personImage.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            personImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                 constant: Layout.standartLayout),
            
            personImage.heightAnchor.constraint(equalToConstant: Layout.personImageHeightWidth),
            personImage.widthAnchor.constraint(equalToConstant: Layout.personImageHeightWidth),
            
            nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: Layout.standartLayout),
            nameLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor,
                                               constant: Layout.standartLayout),
            
            phoneNumberLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                     constant: -Layout.standartLayout),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor,
                                                      constant: Layout.standartLayout),
            
            skillsLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            skillsLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                  constant: -Layout.standartLayout)
        ])
    }
}
