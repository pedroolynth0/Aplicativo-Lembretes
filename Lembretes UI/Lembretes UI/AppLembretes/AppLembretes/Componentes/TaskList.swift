//
//  TaskList.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import SwiftUI

struct TaskList: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        
                        ForEach(viewModel.groupLembretesByDate().orderedKeys, id: \.self) { key in
                            
                            
                            VStack(alignment: .leading) {
                                //MARK: DATA TITULO
                                Text(key)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.leading)
                                    .padding(.top)
                                    .foregroundColor(.gray)
                                //:DATA TITULO
                                
                                
                                // FOR LEMBRETES
                                ForEach(viewModel.groupLembretesByDate()[key]!, id: \._id) { lembrete in
                                    NavigationLink(destination: TarefaDetalhes(lembrete : lembrete)){
                                        
                                        
                                        //MARK: EXCLUIR LEMBRETE
                                        HStack{
                                            Button {
                                                viewModel.delete(lembrete._id)
                                            }
                                        label: {
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.red)
                                                .padding()
                                        }
                                            //:EXCLUIR LEMBRETE
                                            
                                            //:MARK: CARD LEMBRETE
                                            VStack(alignment: .leading){
                                                //MARK: -. NOME
                                                HStack{
                                                    Text(lembrete.nome).font(.subheadline).fontWeight(.semibold).foregroundColor(Color.gray)
                                                        .padding(.top, 5.0)
                                                    
                                                    
                                                }//:HSTACK
                                                
                                                //MARK: -. DATA
                                                HStack{
                                                    Image(systemName: "calendar.badge.clock").foregroundColor(Color.gray)
                                                    
                                                    Text(lembrete.data).lineLimit(3).foregroundColor(Color((UIColor.darkGray)))
                                                        .fontWeight(.light)
                                                        .font(.subheadline)
                                                        .multilineTextAlignment(.leading)
                                                    
                                                    
                                                    Spacer()
                                                    NavigationLink(destination: EditTask(lembrete: lembrete)) {
                                                        Image(systemName: "pencil.circle")
                                                    }
                                                    .foregroundColor(.yellow)
                                                    .frame(width: 50)
                                                    .padding(.bottom)
                                                }
                                            }
                                        }
                                        .background(Color((UIColor.systemGray6)))
                                        .cornerRadius(20)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .onAppear{viewModel.getData()}
        }
    }
}





struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
        
    }
}
