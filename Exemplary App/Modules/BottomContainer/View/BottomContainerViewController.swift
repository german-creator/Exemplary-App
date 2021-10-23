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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        output.viewIsReady()
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(view)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(200)
        }
    }
    
    @objc private func viewTapped(_ sender: UITapGestureRecognizer) {
        if sender.location(in: containerView).y < 0 {
            output.viewTapped()
        }
    }
}

extension BottomContainerViewController: BottomContainerInput {
    func setupContainer(with contentViewController: UIViewController) {
        addChild(contentViewController)
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentViewController.view)
        contentViewController.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(containerView)
        }
    }
}
