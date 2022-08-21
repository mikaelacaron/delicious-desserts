//
//  DessertCell.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/16/22.
//

import UIKit
import SDWebImage

class DessertCell: UITableViewCell {
   
   static let reuseID = "DessertCell"
   
   let dessertImageView = DDDessertImageView(frame: .zero)
   let nameLabel = DDTitleLabel(textAlignment: .left, fontSize: 18)
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       
       configure()
   }
   
    func set(dessert: Dessert) {
        nameLabel.text = dessert.strMeal
        dessertImageView.sd_setImage(with: URL(string:dessert.strMealThumb), placeholderImage: Images.placeholder)
        
   }
   
   private func configure() {
       selectionStyle = .none
       
       addSubViews(dessertImageView, nameLabel)
       accessoryType = .disclosureIndicator
       let padding: CGFloat = 12
       
       NSLayoutConstraint.activate([
           dessertImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           dessertImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
           dessertImageView.heightAnchor.constraint(equalToConstant: 60),
           dessertImageView.widthAnchor.constraint(equalToConstant: 60),
           
           nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           nameLabel.leadingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: 24),
           nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
           nameLabel.heightAnchor.constraint(equalToConstant: 40)
       ])
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
