//
//  HomeView.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 23/12/2022.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @StateObject var colorVM : ColorViewModel = .init()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timeStamp, ascending: false )], animation:.default)
    private var items : FetchedResults<Item>
    
    @State var currentItem : ColorValue?
    @State var expandCard : Bool = false
    @State var moveCardDown : Bool = false
    @State var animationContent : Bool = false
    //MARK: - BODY
    var body: some View {
        
        
        //SCROLLVIEW
        ScrollView(.vertical, showsIndicators: true) {
            
            VStack(spacing: 12) {
                ForEach(items) { item in
                    Rectangle()
                        .overlay{
                            Rectangle()
                                .fill(Color(UIColor(red:CGFloat(item.red),green:CGFloat(item.green),blue:CGFloat(item.blue),alpha:CGFloat(item.alpha))))
                                .onTapGesture {
                                    colorVM.openEditColorView.toggle()
                                }
                                .sheet(isPresented: $colorVM.openEditColorView) {
                                    EditColorView()
                                }
                        }
                        .overlay{
                            HStack(spacing: 4) {
                                Text(item.hexNumber ?? "")
                                    .font(.title.bold())
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(16)
                                
                                Spacer()
                            }
                        }
                        .frame(height:110)
                    
                } //: ForEach
            } //: VSTACK
            .padding(.horizontal,10)
            .padding(.vertical,16)
        } //: SCROLLVIEW
        
        
        
        
        .overlay(alignment: .bottom) {
            //BUTTON
            Button {
                colorVM.openAddColorView.toggle()
            } label: {
                Label {
                    Text("Add Color")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .frame(width:160, height:20)
                .foregroundColor(.white)
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(.black,in:Capsule())
            }

        }
        .fullScreenCover(isPresented: $colorVM.openAddColorView, content: {
            AddColor().environmentObject(colorVM)
        })
        .padding()
    }
    
    //MARK: - FUNCTION
}







//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
