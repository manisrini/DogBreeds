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
                    VStack(alignment: .leading){
                        HStack{
                            Text(viewModel.getDropdownText())
                                .font(.custom("Roboto", size: 16).weight(.medium))
                                .foregroundStyle(Color(hex: "384A62"))
                                .padding(.leading,10)
                            Image("chevronDown")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20,height: 20)
                                .foregroundStyle(Color(hex: "283648"))
                                .padding(.trailing,10)
                        }
                        .frame(alignment: .leading)
                        .cornerRadius(15)
                        .padding(.vertical,10)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color(hex: "90EE90"), lineWidth: 1)
//                        )
                        
                    }
                    .background(Color(hex: "90EE90"))
                    .cornerRadius(10)
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
