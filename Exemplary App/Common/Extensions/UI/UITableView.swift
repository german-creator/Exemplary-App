//
//  UITableView.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 27/11/2021.
//

import UIKit

extension UITableView {
    
    func setEmptyView(viewModel: EmptyViewModel) {
        
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        let imageView = UIImageView()
        let stackView = UIStackView()
        let contentView = UIView()
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(stackView)
    
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            // Priority for disable constraint conflict, when table view has zero frame
            make.leading.greaterThanOrEqualToSuperview().offset(Constants.mediumMargin).priority(999)
            make.trailing.greaterThanOrEqualToSuperview().offset(-Constants.mediumMargin).priority(999)
        }
        
        titleLabel.bonMotStyle = Theme.currentTheme.stringStyle.h1_20_b.byAdding(
            .color(Theme.currentTheme.color.black)
        )
        
        titleLabel.styledText = viewModel.title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        descriptionLabel.bonMotStyle = Theme.currentTheme.stringStyle.h2_17_r.byAdding(
            .color(Theme.currentTheme.color.grey)
        )
        
        descriptionLabel.styledText = viewModel.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center

        imageView.image = viewModel.image
        
        backgroundView = contentView
        separatorStyle = .none
    }
    
    func removeEmptyView() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
