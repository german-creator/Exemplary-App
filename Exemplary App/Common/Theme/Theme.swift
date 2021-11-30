//
//  Theme.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit
import BonMot

enum Theme {
    static var currentTheme: Theme = .light
    case light, dark
    
    var color: ColorTheme {
        return self == .light  ? LightColorTheme() : LightColorTheme()
    }
    
    var stringStyle: TextTheme {
        return DefaultTextTheme()
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        return self == .light  ? .light : .dark
    }
}

protocol ColorTheme {
    /**light sky blue 41C6F6*/
    var mainAccent: UIColor { get }
    /**sail B2E2FB*/
    var mainAccentLight: UIColor { get }
    /**light coral FF686B */
    var secondRedDark: UIColor { get }
    /**sweet pink FF9E9A */
    var secondRedLight: UIColor { get }

    var black: UIColor { get }
    var grey: UIColor { get }
    var white: UIColor { get }
}

// swiftlint:disable identifier_name
protocol TextTheme {
    var h1_20_b: BonMot.StringStyle { get }
    var h2_17_r: BonMot.StringStyle { get }
    var h3_15_r: BonMot.StringStyle { get }
}
// swiftlint:enable identifiecr_name

private struct LightColorTheme: ColorTheme {
    var mainAccent: UIColor = #colorLiteral(red: 0.2549019608, green: 0.7764705882, blue: 0.9647058824, alpha: 1)
    var mainAccentLight: UIColor = #colorLiteral(red: 0.6980392157, green: 0.8862745098, blue: 0.9843137255, alpha: 1)
    var secondRedDark: UIColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.4196078431, alpha: 1)
    var secondRedLight: UIColor = #colorLiteral(red: 1, green: 0.6196078431, blue: 0.6039215686, alpha: 1)
    var black: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    var grey: UIColor = #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1)
    var white: UIColor = .white
}

// swiftlint:disable identifier_name
private struct DefaultTextTheme: TextTheme {
    var h1_20_b = StringStyle(
        .font(UIFont.boldSystemFont(ofSize: 20)),
        .lineBreakMode(.byTruncatingTail)
    )
    var h2_17_r = StringStyle(
        .font(UIFont.systemFont(ofSize: 17)),
        .lineBreakMode(.byTruncatingTail)
    )
    var h3_15_r = StringStyle(
        .font(UIFont.systemFont(ofSize: 15)),
        .lineBreakMode(.byTruncatingTail)
    )
}
