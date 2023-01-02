//
//  AddColor.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 23/12/2022.
//

import SwiftUI

struct AddColor: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var colorVM : ColorViewModel
    @Environment(\.self) var env

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
                print(colorVM.drawHexNumber)
                print(colorVM.drawUIColor)
                addItem()
                colorVM.openEditColor.toggle()
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
    private func addItem(){
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timeStamp = Date()
            newItem.id = UUID()
            let colorCode = colorVM.drawHexNumber
            let pickedColor = colorVM.drawUIColor
            newItem.red = Float(pickedColor.components.red)
            newItem.blue = Float(pickedColor.components.blue)
            newItem.green = Float(pickedColor.components.green)
            newItem.alpha = Float(pickedColor.components.alpha)
            newItem.hexNumber = colorCode
            saveItem()
            print(newItem.id)
        }
    }
    
    private func saveItem(){
        do {
            try viewContext.save()
            
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}


//MARK: - PREVIEW
struct AddColor_Previews: PreviewProvider {
    static var previews: some View {
        AddColor().environmentObject(ColorViewModel())
    }
}
