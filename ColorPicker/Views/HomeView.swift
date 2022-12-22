//
//  HomeView.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 23/12/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Your Colour")
                .font(.callout)
            
            //SCROLLVIEW
            ScrollView(.vertical, showsIndicators: true) {
                
            } //: SCROLLVIEW
        }
        
        .overlay(alignment: .bottom) {
            //BUTTON
            Button {
                
            } label: {
                Label {
                    Text("Add Color")
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
        .padding()
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
