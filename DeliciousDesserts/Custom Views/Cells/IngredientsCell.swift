//
//  IngredientsCell.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/18/22.
//

import UIKit

class IngredientsCell: UITableViewCell {
    
    static let reuseID = "IngredientCell"
    
    let nameLabel = DDTitleLabel(textAlignment: .left, fontSize: 16)
    let ingredientLabels = DDBodyLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    func set(details: Details) {
        nameLabel.text = "Ingredients"
        
        var ingredientText = ""
        
        for (index, ingredient) in details.ingredients.enumerated() {
            ingredientText += "• \(ingredient.measurement) \(ingredient.name)"
            if index != details.ingredients.count - 1 {
                ingredientText += "\n"
            }
        }
        
        ingredientLabels.text = ingredientText
    }
    
    private func configure() {
        selectionStyle = .none
        
        contentView.addSubViews(nameLabel, ingredientLabels)
        ingredientLabels.numberOfLines = 0
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.bottomAnchor.constraint(equalTo: ingredientLabels.topAnchor, constant: -padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            ingredientLabels.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            ingredientLabels.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            ingredientLabels.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ingredientLabels.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
