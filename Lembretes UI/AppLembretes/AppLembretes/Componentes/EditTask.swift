//
//  AddTask.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import SwiftUI

struct EditTask: View {
    
    //MARK: VARIAVEIS
    var lembrete : LembreteModel
    @StateObject var lembretes = ViewModelLembrete()
    @State private var nome = ""
    @State private var descricao = ""
    @State private var data = Date()
    @State private var testeData = false
    @State private var testeNome = false
    @State private var alerta = false
    init(lembrete: LembreteModel) {
        self.lembrete = lembrete
        _nome = State(initialValue: lembrete.nome)
        _descricao = State(initialValue: lembrete.descricao)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        _data = State(initialValue: dateFormatter.date(from: lembrete.data) ?? Date())
    }
    //:VARIAVEIS
    
    var body: some View {
        return VStack(spacing:16){
            
            //MARK: TITULO
            Text("Editar Lembrete")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
            //: TITULO
            
            //MARK: NOME
            TextField("Nome" , text: $nome)
                .padding(14.0)
                
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
            //: NOME
            
            //MARK: DESCRICAO
            TextField("Descrição" , text: $descricao)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
            //: DESCRICAO
            
            //MARK: DATA
            DatePicker(selection: $data, label:{
                Text("Data")
                    .foregroundColor(Color(UIColor.systemGray3))
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
            })
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
            
            //: DATA
            
            
            
            //MARK: SALVAR DADOS
            Button {
                //Verificar se os dados são validos
                if(checkNome(nome: nome) && checkDate(data: data)){
                    let novoLembrete = LembreteModel(_id: lembrete._id,
                                                     nome: nome,
                                                     descricao: descricao,
                                                     data: formatDate(date: data),
                                                     status: true)
                    lembretes.putLembretes(lembrete: novoLembrete)
                }
                alerta = true
            }//:BUTTON
            
            label: {
                Spacer()
                Text("Salvar")
                Spacer()
            }//:LABEL
            .alert(isPresented: $alerta) {
                var texto = ""
                var titulo = "Erro"
                if(testeNome && testeData){
                    titulo = "Sucesso"
                    
                }
                else{
                    if(!testeNome){
                        texto += "O campo nome está vazio! \n"
                    }
                    if (!testeData){
                        texto += "A data deve estar no futuro!"
                    }
                }

                return Alert(
                    title: Text(titulo),
                    
                    message: Text(texto),
                    primaryButton: .default(Text("Ok")),
                    secondaryButton: .cancel(Text("Cancelar"))
                )//:ALERT
            }//.ALERT

            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .background(Color.pink)
            .cornerRadius(20)
            
            

            Spacer()

        }//: VStack
        .padding()
    }//:BODY
    
    
    //MARK: FUNCOES
    
    //Verificar se a data está no futuro
    private func checkDate(data: Date) -> Bool{
        testeData = false
        if(data >= Date()){
            testeData = true
        }
        return testeData
    }
    //Verificar se o campo nome está preenchido
    private func checkNome(nome: String) -> Bool{
        testeNome = false
        if(!nome.isEmpty){
            testeNome = true
        }
        return testeNome
    }
    //Formatar data
    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
    
    
    

}//:VIEW





struct EditTask_Previews: PreviewProvider {
    static var previews: some View {
        let placeholder = LembreteModel(_id: "Id teste", nome: "teste",descricao: "teste" ,data: "30-07-2002 04:32", status: true)
        EditTask(lembrete : placeholder)
    }
}
