//
//  TaskList.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import SwiftUI

struct TaskList: View {
    @StateObject var lembretes = ViewModelLembrete()

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(lembretes.groupLembretesByDate().orderedKeys, id: \.self) { key in
                            

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
                                ForEach(lembretes.groupLembretesByDate()[key]!, id: \._id) { lembrete in
                                    NavigationLink(destination: TarefaDetalhes(lembrete : lembrete)){
                                        
                                        
                                        //MARK: EXCLUIR LEMBRETE
                                        HStack{
                                            Button {
                                                lembretes.deleteLembretes(lembrete: lembrete)
                                                
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
                                                }//:HSTACK

                                            }//:VSTACK
                                        }//:HSTACK
                                        .background(Color((UIColor.systemGray6)))
                                        .cornerRadius(20)
                                    }
                                }
                            }//:VSTACK
                        }//:FOR
                    }//:VSTACK
                    .padding(.horizontal, 20)
                }//:SCROLLVIEW
            }//:ZSTACK
        }//:NavigationStack
        .onAppear { lembretes.getLembretes() }
    }//:BODY
}//:VIEW


//MARK: AGRUPAR LEMBRETES
extension ViewModelLembrete {
    func groupLembretesByDate() -> OrderedDictionary<String, [LembreteModel]> {
        var groupedLembretes: OrderedDictionary<String, [LembreteModel]> = OrderedDictionary()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        for lembrete in chars {
            if let date = dateFormatter.date(from: lembrete.data) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day], from: date)
                let formattedDate = "\(components.day!)/\(components.month!)/\(components.year!)"

                if var lembretesArray = groupedLembretes[formattedDate] {
                    lembretesArray.append(lembrete)
                    groupedLembretes[formattedDate] = lembretesArray
                } else {
                    groupedLembretes[formattedDate] = [lembrete]
                }
            }
        }


        return groupedLembretes
    }
}





struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
        
    }
}
