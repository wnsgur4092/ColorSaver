//
//  HomeView.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 23/12/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var colorVM : ColorViewModel = .init()
    

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStamp, ascending: false )], animation:.default)
    
    private var items : FetchedResults<Item>
    
    var body: some View {
        VStack {
            Text("Your Colour")
                .font(.callout)
            
            //SCROLLVIEW
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(items) { item in
                    ZStack {
                        Rectangle()
                            .fill(Color(UIColor(red:CGFloat(item.red),green:CGFloat(item.green),blue:CGFloat(item.blue),alpha:CGFloat(item.alpha))))
                        .frame(width: 250, height: 50)
                        
                        Text(item.hexNumber ?? "NO")
                    }
                }
            } //: SCROLLVIEW
        }
        
        .overlay(alignment: .bottom) {
            //BUTTON
            Button {
                colorVM.openEditColor.toggle()
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
                .frame(maxWidth:.infinity)
                
            }
        }
        .fullScreenCover(isPresented: $colorVM.openEditColor, content: {
            AddColor().environmentObject(colorVM)
        })
        .padding()
    }
 
    

}

//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
