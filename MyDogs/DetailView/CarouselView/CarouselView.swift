//
//  CarouselView.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct CarouselItem : Hashable {
    var name : String
    var imageUrl : String?
}

struct CarouselView: View {
    
    @ObservedObject var viewModel : CarouselViewModel
    var didChangeItem : ((Int)->())?
    
    var body: some View {
        
        ZStack{
            
            Color.secondary.ignoresSafeArea()
            
                TabView(selection: $viewModel.selectedIndex) {
                    ForEach(Array(viewModel.items.enumerated()),id: \.element) { index,item in
                        ZStack{
                            if let _imageURL = item.imageUrl,!_imageURL.isEmpty,let url = URL(string: _imageURL){
                                WebImage(url: url)
                                    .renderingMode(.original)
                                    .resizable()
                                    .indicator(.activity)
                                    .transition(.fade(duration: 0.5))
                                    .scaledToFill()
                            }else{
                                Text("On the way, just wait....")
                                    .onAppear{
                                        viewModel.fetchImage(name: item.name)
                                    }
                            }
                        }
                        .background()
                        .tag(index)
                        .ignoresSafeArea()
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                .onChange(of: viewModel.selectedIndex) { _, newIndex in
                    self.didChangeItem?(newIndex)
                }
            }.cornerRadius(10)
        //            HStack{
//                ForEach(0..<viewModel.items.count,id: \.hashValue) { index in
//                    Capsule()
//                        .fill(Color.white.opacity(viewModel.selectedIndex ==  index ? 1 : 0.33))
//                        .frame(width: 35,height: 10)
//                        .onTapGesture {
//                            viewModel.selectedIndex = index
//                        }
//                }
//            }
//            .offset(y : 130)
        
    }
    
    func updateImage(index : Int){
        self.viewModel.selectedIndex = index
    }
}

#Preview {
    CarouselView(viewModel: CarouselViewModel(items: []))
}
