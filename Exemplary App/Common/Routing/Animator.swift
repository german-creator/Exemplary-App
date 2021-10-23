//
//  Animator.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 09.10.2021.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
