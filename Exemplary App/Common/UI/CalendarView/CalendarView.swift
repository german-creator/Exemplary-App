//
//  Calendar.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 31/10/2021.
//

import UIKit

protocol CelendarViewDelegate {
    func didChangeDate(_ date: Date)
}

class CalendarView: UIView {
    
    private let headerView = UIView()
    private let monthLabel = UILabel()
    private let buttonsStackView = UIStackView()
    private let nextMonthButton = UIButton(type: .system)
    private let previousMonthButton = UIButton(type: .system)
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var selectedDay: Date? {
        didSet {
            updateSelectedDate()
        }
    }
    
    private var calendarHelper = CalendarHelper()
    private var currentMonth = Date()
    private var daysArray = [Date?]()
    private let calendarItemsCount = 37
    
    var delegate: CelendarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
    
    private func initSetup() {
        setupViews()
        setupLayout()
        setMonthView()
    }
    
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CalendarCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        
        monthLabel.bonMotStyle = Theme.currentTheme.stringStyle.h1_20_b.byAdding(
            .color(Theme.currentTheme.color.black)
        )
        
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fill
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = Constants.mediumMargin
        
        nextMonthButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        previousMonthButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        nextMonthButton.setBackgroundImage(R.image.button_right(), for: .normal)
        previousMonthButton.setBackgroundImage(R.image.button_left(), for: .normal)
    }
    
    private func setupLayout() {
        headerView.addSubview(monthLabel)
        headerView.addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(previousMonthButton)
        buttonsStackView.addArrangedSubview(nextMonthButton)
        
        addSubview(headerView)
        addSubview(collectionView)
        
        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.smallMargin)
            make.centerY.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(monthLabel.snp.trailing).offset(Constants.mediumMargin)
            make.trailing.equalToSuperview().offset(-Constants.smallMargin)
            make.centerY.equalToSuperview()
        }
        
        nextMonthButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
        previousMonthButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(Constants.mediumMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        switch sender {
        case nextMonthButton:
            currentMonth = calendarHelper.plusMonth(date: currentMonth)
            setMonthView()
        case previousMonthButton:
            currentMonth = calendarHelper.minusMonth(date: currentMonth)
            setMonthView()
        default: break
        }
    }
    
    private func updateSelectedDate() {
        if let selectedDay = selectedDay,
           !Calendar.current.isDate(selectedDay, inSameMonthAs: currentMonth) {
            scrollToSelectedDate()
        } else {
            collectionView.reloadData()
        }
    }
    
    private func scrollToSelectedDate() {
        guard let selectedDay = selectedDay else { return }

        currentMonth = calendarHelper.firstOfMonth(date: selectedDay)
        setMonthView()
    }
    
    private func setMonthView() {
        monthLabel.styledText = calendarHelper.monthString(date: currentMonth)
        + " " + calendarHelper.yearString(date: currentMonth)
        
        updateDaysArray()
        collectionView.reloadData()
    }
    
    private func updateDaysArray() {
        daysArray.removeAll()
        
        let daysInMonth = calendarHelper.daysInMonth(date: currentMonth)
        var day = calendarHelper.firstOfMonth(date: currentMonth)
        let startingSpaces = calendarHelper.weekDay(date: day)
        
        var index = 0
        
        while(index < calendarItemsCount) {
            if(index < startingSpaces || index - startingSpaces >= daysInMonth) {
                daysArray.append(nil)
            } else {
                daysArray.append(day)
                day = calendarHelper.addDays(date: day, days: 1)
            }
            index += 1
        }
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
            for: indexPath) as! CalendarCollectionViewCell

        if let day = daysArray[indexPath.item] {
            cell.text = calendarHelper.dayOfMonth(date: day)
            
            var cellSelected = false
            if let selectedDay = selectedDay, Calendar.current.isDate(selectedDay, inSameDayAs: day) {
               cellSelected = true
            }
            cell.backgroundColor = cellSelected ? Theme.currentTheme.color.mainAccentLight : Theme.currentTheme.color.white
        } else  {
            cell.text = ""
            cell.backgroundColor = Theme.currentTheme.color.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/8 - 5, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let newDay = daysArray[indexPath.row] else { return }
        selectedDay = newDay
        delegate?.didChangeDate(newDay)
        collectionView.reloadData()
    }
}
