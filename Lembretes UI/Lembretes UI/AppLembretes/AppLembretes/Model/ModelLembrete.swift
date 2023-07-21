//
//  ModelLembrete.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import Foundation

//MARK: ESTRUTURA DO LEMBRETE
struct LembreteModel: Codable{
    var _id : String
    var nome : String
    var descricao : String
    var data : String
    var status : Bool
}




//MARK: REQUEST
class ViewModelLembrete: ObservableObject{
@Published var chars: [LembreteModel] = []
    
    //MARK: URL DA REQUISICAO
    
/**
    *var stringURL = "http://localhost:3333"  deve ser utilizada quando o servidor local estiver ativo
    *var stringURL = "https://dtiapi--pedroaifail55.repl.co/"  essa url é utilizada para acessar api hospedada no replit caso essa url apresentar problemas tente rodar a api no servidor local e utilize       a outra url
*/
    var stringURL = "http://localhost:3333"
    

    
    
    
//MARK: REQUISICOES
    
//MARK: GET
func getLembretes(){
    guard let url = URL(string: "\(stringURL)/getLembretesAtivos/?status=true")
    else {
        return
    }
    
    let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
        guard let data = data, error == nil else{
            return
        }
        
        
        do {
            let parsed = try JSONDecoder().decode([LembreteModel].self, from: data)
            
            DispatchQueue.main.async {
                self?.chars = parsed
            }
        }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: DELETE
func deleteLembretes(lembrete: LembreteModel) {
            guard let url = URL(string: "\(stringURL)/deleteLembrete/\(lembrete._id)") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    // Atualizar  a lista de lembretes após a exclusão bem-sucedida
                    self?.chars.removeAll { $0._id == lembrete._id }
                    
                }
            }
            task.resume()
        }
    //MARK: UPDATE
    func putLembretes(lembrete: LembreteModel) {
        
        guard let url = URL(string: "\(stringURL)/updateLembrete/\(lembrete._id)") else {
            return
        }

        let requestData: [String: Any] = [
            "nome": lembrete.nome,
            "descricao": lembrete.descricao,
            "data": lembrete.data,
            "status": lembrete.status
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Erro na requisição: \(error.localizedDescription)")
                    return
                }

                if let data = data {
                    if let responseMessage = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                           
                            
                        }
                    }
                }
            }.resume()

        } catch {
            print("Erro ao serializar os dados: \(error.localizedDescription)")
        }
    }
    
    //MARK: POST

    func postLembretes(lembrete: LembreteModel) {
        
        guard let url = URL(string: "\(stringURL)/criarLembrete") else {
            return
        }

        // Define os dados que você deseja enviar no formato JSON
        let requestData: [String: Any] = [
            
            "nome": "\(lembrete.nome)",
            "descricao": "\(lembrete.descricao)",
            "data": "\(lembrete.data)",
            "status" : lembrete.status
            
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Erro na requisição: \(error.localizedDescription)")
                    return
                }

                if let data = data {
                    if String(data: data, encoding: .utf8) != nil {
                        DispatchQueue.main.async {
                           
                        }
                    }
                }
            }.resume()

        } catch {
            print("Erro ao serializar os dados: \(error.localizedDescription)")
        }
    }
}
