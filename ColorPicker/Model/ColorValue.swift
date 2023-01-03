//
//  ColorValue.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 28/12/2022.
//

import SwiftUI

struct ColorValue : Hashable, Equatable {
    var drawSwiftUIColor: Color
    var drawOpacity: Double
    var drawUIColor: UIColor
    var drawHexNumber: String
    var id : UUID
}
