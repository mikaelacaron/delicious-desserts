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
        nameLabel.text = dessert.name
        dessertImageView.sd_setImage(with: URL(string:dessert.thumbnailUrl), placeholderImage: Images.placeholder)
   }
   
   private func configure() {
       selectionStyle = .none
       accessoryType = .disclosureIndicator
       
       addSubViews(dessertImageView, nameLabel)
       
       let padding: CGFloat = 12
       let dessertImageViewWidthHeight: CGFloat = 60
       let nameLabelLeadingPadding: CGFloat = 24
       let nameLabelHeight: CGFloat = 40
       
       NSLayoutConstraint.activate([
           dessertImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
           dessertImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
           dessertImageView.heightAnchor.constraint(equalToConstant: dessertImageViewWidthHeight),
           dessertImageView.widthAnchor.constraint(equalToConstant: dessertImageViewWidthHeight),
           
           nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
           nameLabel.leadingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: nameLabelLeadingPadding),
           nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
           nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
       ])
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
