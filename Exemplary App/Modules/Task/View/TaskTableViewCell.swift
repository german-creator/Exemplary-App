//
//  TaskTableViewCell.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: TaskTableViewCell.self)
    }
    
    static let height: CGFloat = UITableView.automaticDimension
    static let estimatedHeight: CGFloat = 100
    
    private let statusView = UIView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let statusViewSize = CGFloat(38)
    
    var viewModel: Task? {
        didSet {
            setupTask()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        selectionStyle = .none
        
        statusView.layer.cornerRadius = statusViewSize / 2
        
        titleLabel.bonMotStyle = Theme.currentTheme.stringStyle.h2_17_r.byAdding(
            .color(Theme.currentTheme.color.black)
        )
        
        descriptionLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
            .color(Theme.currentTheme.color.grey)
        )
        
        stackView.axis = .vertical
        stackView.distribution = .fill
    }
    
    private func setupLayout() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dateLabel)
        
        addSubview(statusView)
        addSubview(stackView)
        
        statusView.snp.makeConstraints { make in
            make.width.height.equalTo(statusViewSize)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.largeMargin)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.mediumMargin)
            make.bottom.equalToSuperview().offset(-Constants.mediumMargin)
            make.leading.equalTo(statusView.snp.trailing).offset(Constants.smallMargin)
            make.trailing.lessThanOrEqualToSuperview().offset(-Constants.mediumMargin)
        }
    }
    
    private func setupTask() {
        switch viewModel?.status {
        case .base:
            statusView.backgroundColor = Theme.currentTheme.color.mainAccentLight
            dateLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
                .color(Theme.currentTheme.color.mainAccent)
            )
            titleLabel.styledText = viewModel?.title
            descriptionLabel.styledText = viewModel?.subtitle
            dateLabel.styledText = viewModel?.taskDate?.displayFormat

        case .overdue:
            statusView.backgroundColor = Theme.currentTheme.color.secondRedDark
            dateLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
                .color(Theme.currentTheme.color.secondRedDark)
            )
            titleLabel.styledText = viewModel?.title
            descriptionLabel.styledText = viewModel?.subtitle
            dateLabel.styledText = viewModel?.taskDate?.displayFormat

        case .completed:
            statusView.backgroundColor = Theme.currentTheme.color.grey
            titleLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
                .color(Theme.currentTheme.color.grey)
            )
            titleLabel.styledText = viewModel?.title
            descriptionLabel.isHidden = true
            dateLabel.isHidden = true
            
        case .none:
            break
        }
        
        stackView.setCustomSpacing(viewModel?.subtitle?.isEmpty ?? true ? 0 : 5, after: descriptionLabel)
    }
}
