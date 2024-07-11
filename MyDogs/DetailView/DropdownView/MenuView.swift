//
//  MenuView.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import SwiftUI

struct MenuView: View {
    
    var items : [DogBreedModel] = []
    
    var body: some View {
        
        ScrollView {
            VStack{
                Menu {
                    ForEach(items,id: \.name) { item in
                        Button {
                            
                        } label: {
                            Text(item.name)
                        }

                    }
                } label: {
                    Text("Dropdown")
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
