//
//  InstructionsCell.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/19/22.
//

import UIKit

class InstructionsCell: UITableViewCell {
    
    static let reuseID = "InstructionsCell"
    
    let nameLabel = DDTitleLabel(textAlignment: .left, fontSize: 16)
    let instructionsLabel = DDBodyLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    func set(details: Details) {
        nameLabel.text = "Instructions"
        instructionsLabel.text = details.instructions
    }
    
    private func configure() {
        selectionStyle = .none
        
        contentView.addSubViews(nameLabel, instructionsLabel)
        instructionsLabel.numberOfLines = 0
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.bottomAnchor.constraint(equalTo: instructionsLabel.topAnchor, constant: -padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            instructionsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
