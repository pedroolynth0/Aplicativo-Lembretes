//
//  AddTask.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import SwiftUI



struct AddTask: View {
    
    //MARK: VARIAVEIS
    @StateObject var lembretesModel = ViewModel()
    @State private var nome = ""
    @State private var descricao = ""
    @State private var data = Date()
    @State private var testeData = false
    @State private var testeNome = false
    @State private var alerta = false
    //:VARIAVEIS
    
    
    var body: some View {
        return VStack(spacing:16){
            
            //MARK: TITULO
            Text("Adicionar lembrete")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
            //:CAMPO TITULO
            
            //MARK: CAMPO NOME
            TextField("Nome" , text: $nome)
                .padding(14.0)
                
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
            //:CAMPO NOME
            
            //MARK: CAMPO DESCRICAO
            TextField("Descrição" , text: $descricao)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
            //:CAMPO DESCRICAO

        
            //MARK: CAMPO DATA
            DatePicker(selection: $data, label:{
                Text("Data")
                    .foregroundColor(Color(UIColor.systemGray3))
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
            })
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
                .accessibilityIdentifier("Data") 
            //:CAMPO DATA
            
            
            //MARK: ENVIAR DADOS
            Button {
                
                if(checkNome(nome: nome) && checkDate(data: data)){
                    let novoLembrete = Reminder(_id: UUID().uuidString,
                                                     nome: nome,
                                                     descricao: descricao,
                                                     data: formatDate(date: data),
                                                     status: true)
                    ReminderManager.saveRecipe(novoLembrete)
                    
                }
                alerta = true
            }
            label: {
                Spacer()
                Text("Salvar")
                Spacer()
            }
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
                )
            }

            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .background(Color.pink)
            .cornerRadius(20)
            //:ENVIAR DADOS
            
            Spacer()

        }//: VStack
        .padding()
        .accessibilityIdentifier("AddTaskScreen")
    }
    
    
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

}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
