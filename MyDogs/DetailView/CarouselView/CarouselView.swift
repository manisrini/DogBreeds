//
//  CarouselView.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import SwiftUI

struct CarouselItem : Hashable {
    var name : String
    var imageUrl : String
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
                        let url = URL(string: item.imageUrl)
                        AsyncImage(url: url)
                            .frame(width: 200,height: 200)
                    }
                    .background()
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: viewModel.selectedIndex) { _, newIndex in
                self.didChangeItem?(newIndex)
            }
        }
        .onAppear {
            
        }
    }
    
    func updateImage(index : Int){
        self.viewModel.selectedIndex = index
    }
}

#Preview {
    CarouselView(viewModel: CarouselViewModel(items: []))
}
