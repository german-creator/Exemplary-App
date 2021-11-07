//
//  BottomContainerViewController.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import UIKit

protocol BottomContainerInput {
    func setupContainer(with contentViewController: UIViewController)
}

class BottomContainerViewController: UIViewController {
    
    var output: BottomContainerOutput!
    
    private let containerView = UIView()
    private let outsideButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        outsideButton.backgroundColor = .clear
        outsideButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setupLayout()
        
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = Theme.currentTheme.color.grey
        }
    }
 
    private func setupLayout() {
        view.addSubview(outsideButton)
        view.addSubview(containerView)
        
        outsideButton.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(containerView.snp.top)
            make.height.greaterThanOrEqualTo(100)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        output.didTapOutsideContainer()
    }
}

extension BottomContainerViewController: BottomContainerInput {
    func setupContainer(with contentViewController: UIViewController) {
        addChild(contentViewController)
        containerView.addSubview(contentViewController.view)
        contentViewController.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(containerView)
        }
    }
}
