//
//  TaskTableViewCell.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit
import SnapKit

struct TaskViewModel {
    enum Status {
        case base, overdue, completed
    }
    
    let status: Status
    let title: String
    let date: Date?
    let addInfo: Bool?
}

class TaskTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: TaskTableViewCell.self)
    }
    
    static let height: CGFloat = UITableView.automaticDimension
    static let estimatedHeight: CGFloat = 100
    
    private let statusView = UIView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let rightImageView = UIImageView()
    
    private let statusViewSize = CGFloat(38)
    private let rightImageViewSize = CGFloat(18)
    
    
    var viewModel:TaskViewModel? {
        didSet {
            updateContent()
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
        statusView.layer.cornerRadius = statusViewSize / 2
        
        titleLabel.bonMotStyle = Theme.currentTheme.stringStyle.h2_17_r.byAdding(
            .color(Theme.currentTheme.color.black)
        )
        
        rightImageView.image = R.image.chevron_right()
        rightImageView.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        
        addSubview(statusView)
        addSubview(stackView)
        addSubview(rightImageView)
    }
    
    private func setupLayout() {
        statusView.snp.makeConstraints { make in
            make.width.height.equalTo(statusViewSize)
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.snp.leading).offset(Constants.largeMargin)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Constants.mediumMargin)
            make.bottom.equalTo(self.snp.bottom).offset(-Constants.mediumMargin)
            make.leading.equalTo(statusView.snp.trailing).offset(Constants.smallMargin)
            make.trailing.lessThanOrEqualTo(rightImageView).offset(Constants.mediumMargin)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(rightImageViewSize)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.snp.trailing).offset(Constants.mediumMargin)
        }
    }
    
    private func updateContent() {
        switch viewModel?.status {
        case .base:
            statusView.backgroundColor = Theme.currentTheme.color.mainAccentLight
            dateLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
                .color(Theme.currentTheme.color.mainAccent)
            )
        case .overdue:
            statusView.backgroundColor = Theme.currentTheme.color.secondRedDark
            dateLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
                .color(Theme.currentTheme.color.secondRedDark)
            )
        case .completed:
            statusView.backgroundColor = Theme.currentTheme.color.grey
            dateLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
                .color(Theme.currentTheme.color.grey)
            )
        case .none:
            break
        }
        
        titleLabel.styledText = viewModel?.title
        
        if let date = viewModel?.date  {
            let dataFormate: DateFormatter = .displayDayFormatter
            dateLabel.styledText = dataFormate.string(from: date)
        }
        
        rightImageView.isHidden = viewModel?.addInfo ?? true
    }
}
