//
//  ColorDetailView.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 2/1/2023.
//

import SwiftUI

struct ColorDetailView: View {
    @State var backgroundColor : UIColor
    
    
    var body: some View {
        VStack{
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color(backgroundColor))
    }
}

struct ColorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ColorDetailView(backgroundColor: .red)
    }
}
