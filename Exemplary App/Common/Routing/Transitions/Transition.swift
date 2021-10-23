//
//  Transition.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 09.10.2021.
//

import UIKit

protocol Transition: AnyObject {
    var sourceViewController: UIViewController? { get set }

    func open(_ viewController: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}
