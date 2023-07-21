//
//  TarefaDetalhes.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import SwiftUI

struct TarefaDetalhes: View {
    var lembrete : LembreteModel
    var body: some View {
        return ZStack {
            
            //MARK: CARD
            Card()
                .padding()
            VStack(spacing:20){
                
                //MARK: TITULO
                Text("Detalhes do Lembrete")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                    .padding(.top,80)
                //:TITULO
                
                //MARK: NOME
                HStack {
                    Text("Nome:")
                        .padding([.top, .leading], 40.0)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.darkGray))
                        
                    Text(lembrete.nome)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top,40.0)
                    .foregroundColor(.gray)
                    Spacer()
                }//:NOME
                
                //MARK: DESCRICAO
                HStack {
                    Text("Descricao:")
                        .padding([ .leading], 40.0)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.darkGray))
                    Text(lembrete.descricao)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.trailing)
                        
                    .foregroundColor(.gray)
                    Spacer()
                }//:DESCRICAO
                
                //MARK: DATA
                HStack {
                    Text("Data:")
                        .padding([ .leading], 40.0)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.darkGray))
                        
                    Text(lembrete.data)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.trailing)
                        
                    .foregroundColor(.gray)
                    Spacer()
                }
                //:DATA
                Spacer()
                
            }//:VSTACK

        }//:ZSTACK
    }//:BODY
}//:VIEW

struct TarefaDetalhes_Previews: PreviewProvider {
    static var previews: some View {
        
        let placeholder = LembreteModel(_id: "Id teste", nome: "teste",descricao: "teste" ,data: "30-07-2002", status: true)
        TarefaDetalhes(lembrete : placeholder)
    }
}
