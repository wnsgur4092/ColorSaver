//
//  AddColor.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 23/12/2022.
//

import SwiftUI

struct AddColor: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var colorVM : ColorViewModel
    @Environment(\.self) var env
    
    @State private var drawSwiftUIColor: Color = Color.red
    @State private var drawOpacity: Double = 1.0
    @State private var drawUIColor: UIColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    @State private var drawHexNumber: String = "#FF0000"
//    @State private var preferredName : String = ""
    
    //MARK: - BODY
    var body: some View {
        VStack{
            Text("Select the Color")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }

                }
            
            Rectangle()
                .foregroundColor(colorVM.drawSwiftUIColor)
                .cornerRadius(20)
                .frame(maxHeight: 300)
                .padding()
            
            Form {
                Section("Choosen Color") {
                    ColorPicker("Select Color", selection: $colorVM.drawSwiftUIColor, supportsOpacity: true)
                        .onChange(of: colorVM.drawSwiftUIColor) { newValue in colorVM.getColorsFromPicker(pickerColor: newValue)
                        }
                }
                
                Section("Hexadecimal") {
                    Text("\(colorVM.drawHexNumber)").bold()
                }
                
                
            }
            //SAVE BUTTON
            Button {
                
            } label: {
                Label {
                    Text("Save Color")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(.black,in:Capsule())
            }
        }
        .frame(maxHeight:.infinity)
        .padding()
    }
    
    
    //MARK: - FUNCTION
    func getColorsFromPicker(pickerColor: Color) {
        let colorString = "\(pickerColor)"
        let colorArray: [String] = colorString.components(separatedBy: " ")

        if colorArray.count > 1 {
            var r: CGFloat = CGFloat((Float(colorArray[1]) ?? 1))
            var g: CGFloat = CGFloat((Float(colorArray[2]) ?? 1))
            var b: CGFloat = CGFloat((Float(colorArray[3]) ?? 1))
            let alpha: CGFloat = CGFloat((Float(colorArray[4]) ?? 1))

            if (r < 0.0) {r = 0.0}
            if (g < 0.0) {g = 0.0}
            if (b < 0.0) {b = 0.0}

            if (r > 1.0) {r = 1.0}
            if (g > 1.0) {g = 1.0}
            if (b > 1.0) {b = 1.0}

            // Update UIColor
            drawUIColor = UIColor(red: r, green: g, blue: b, alpha: alpha)
            // Update Opacity
            drawOpacity = Double(alpha)

            // Update hex
            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            drawHexNumber = String(format: "#%06X", rgb)
        }
    }
}


//MARK: - PREVIEW
struct AddColor_Previews: PreviewProvider {
    static var previews: some View {
        AddColor().environmentObject(ColorViewModel())
    }
}
