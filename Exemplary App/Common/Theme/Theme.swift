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
    /**light sky blue 41C6F6 with alfa 0.5*/
    var mainAccentLight: UIColor { get }
    /**light coral FF686B */
    var secondRedDark: UIColor { get }
    /**light coral FF686B with alfa 0.5*/
    var secondRedLight: UIColor { get }
    /**melon FFA69E */
    var secondPink: UIColor { get }
    /**magicMint A9E5C8 */
    var secondGreen: UIColor { get }
    
    var black: UIColor { get }
    var grey: UIColor { get }
    var white: UIColor { get }
}

protocol TextTheme {
    var h1_20_b: BonMot.StringStyle { get }
    var h2_17_r: BonMot.StringStyle { get }
    var h3_15_r: BonMot.StringStyle { get }
}

private struct LightColorTheme: ColorTheme {
    var mainAccent: UIColor = #colorLiteral(red: 0.2549019608, green: 0.7764705882, blue: 0.9647058824, alpha: 1)
    var mainAccentLight: UIColor = #colorLiteral(red: 0.2549019608, green: 0.7764705882, blue: 0.9647058824, alpha: 1).withAlphaComponent(0.5)
    var secondRedDark: UIColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.4196078431, alpha: 1)
    var secondRedLight: UIColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.4196078431, alpha: 1) .withAlphaComponent(0.5)
    var secondPink: UIColor = #colorLiteral(red: 1, green: 0.6509803922, blue: 0.6196078431, alpha: 1)
    var secondGreen: UIColor = #colorLiteral(red: 0.662745098, green: 0.8980392157, blue: 0.7843137255, alpha: 1)
    var black: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    var grey: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).withAlphaComponent(0.5)
    var white: UIColor = .white
}

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
