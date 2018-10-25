//
//  UIColor+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

extension UIColor {
	
	public static func convert(_ hex: Int32) -> UIColor {
		return convert(hex.toRed(), hex.toGreen(), hex.toBlue(), hex.toAlpha())
	}
	
	public static func convert(_ hex: Int) -> UIColor {
		return convert(hex.toRed(), hex.toGreen(), hex.toBlue())
	}
	
	public static func convert(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
		return convert(red, green, blue, 1)
	}
	
	public static func convert(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int) -> UIColor {
		return UIColor(red: red.toColorChannel(),
									 green: green.toColorChannel(),
									 blue: blue.toColorChannel(),
									 alpha: alpha.toColorChannel())
	}	
}
