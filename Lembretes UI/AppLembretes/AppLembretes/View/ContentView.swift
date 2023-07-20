//
//  ContentView.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSheet: Bool = false
    var body: some View {
        NavigationStack{
            
            
            
            VStack(alignment: .leading) {
                VStack {
                    //MARK: Titulo
                    Text("Lista de lembretes")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                        .multilineTextAlignment(.center)
                        .padding(.top, 24.0)
                    
                    
                    Spacer()
                    
                    
                    //MARK: Lista de lembrete
                    TaskList()
                        .padding()
                    
                    
                    
                    //MARK: Adicionar lembrete
                    NavigationLink(destination: AddTask()){
                        // ACTION: Show a Sheet
                        Spacer()
                        Text("Adicionar lembretes")
                            .font(.title3)
                        
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                            .multilineTextAlignment(.center)
                            .lineLimit(0)
                            .padding()
                        
                        Spacer()
                    }
                    .accessibilityIdentifier("Adicionar lembretes")

                    
                    
                }
                
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
