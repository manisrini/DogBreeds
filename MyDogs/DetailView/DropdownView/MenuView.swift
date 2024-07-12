//
//  MenuView.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var viewModel : MenuViewModel
    var didTapOption : ((DogBreedModel,Int) -> ())?

    var body: some View {
        
        ScrollView {
            VStack{
                Menu {
                    ForEach(Array(viewModel.items.enumerated()),id: \.element) { index,item in
                        Button {
                            self.viewModel.updateDropdownText(model: item)
                            self.didTapOption?(item,index)
                        } label: {
                            Text(item.name)
                        }
                    }
                } label: {
                    Text(viewModel.getDropdownText())
                        .font(.custom("Roboto", size: 16).weight(.medium))
                        .foregroundStyle(Color(hex: "384A62"))

                    Image("chevronDown")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(Color(hex: "283648"))
                        
                }
            }
        }
    }
    
    func updateDropdownText(text : String){
        self.viewModel.dropdownText = text
    }
    
}

#Preview {
    MenuView(viewModel: MenuViewModel(items: []))
}
