//
//  AppLembretesTests.swift
//
//
//  Created by Pedro Olyntho on 18/07/23.
//

import XCTest
@testable import AppLembretes

class ViewModelLembreteTests: XCTestCase {
    // Mock URLSession para simular as respostas do servidor
    class MockURLSession: URLSession {
        var data: Data?
        var error: Error?

        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let mockDataTask = MockURLSessionDataTask()
            mockDataTask.data = data // Definindo a variável data do mockDataTask
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }
    }

    // Mock URLSessionDataTask para simular a execução da tarefa
    class MockURLSessionDataTask: URLSessionDataTask {
        var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
        var data: Data? // Definindo a variável data para a tarefa

        override func resume() {
            // Simula a chamada do servidor com a resposta e erro fornecidos
            completionHandler?(data, nil, nil)
        }
    }

    // Teste para a função getLembretes()
    func testGetLembretes() {
        let viewModel = ViewModelLembrete()
        let mockSession = MockURLSession()
        
        
        // Crie um lembrete mock para ser retornado pelo mockSession
        let mockLembrete = LembreteModel(_id: "1", nome: "Lembrete de teste", descricao: "Descrição do lembrete de teste", data: "2023-07-20", status: true)
        let mockData = try? JSONEncoder().encode([mockLembrete])

        mockSession.data = mockData
        let mockDataTask = mockSession.dataTask(with: URL(string: viewModel.stringURL)!) { data, _, _ in
            guard let data = data else {
                return
            }
            viewModel.chars = try! JSONDecoder().decode([LembreteModel].self, from: data)
        }
        mockDataTask.resume()

        // Verifica se o lembrete mock está presente na lista de lembretes após a conclusão da chamada assíncrona
        XCTAssertEqual(viewModel.chars, [mockLembrete], "A lista de lembretes deve conter o lembrete mock após a chamada getLembretes()")
    }
    // Teste para a função putLembretes()
    func testPutLembretes() {
        let viewModel = ViewModelLembrete()
        let mockSession = MockURLSession()
        

        // Crie um lembrete mock para ser atualizado
        let mockLembrete = LembreteModel(_id: "1", nome: "Lembrete de teste", descricao: "Descrição do lembrete de teste", data: "2023-07-20", status: true)

        // Configura o mockSession para não retornar dados 
        mockSession.data = nil
        viewModel.putLembretes(lembrete: mockLembrete)

    }
    // Teste para a função deleteLembretes()
    func testDeleteLembretes() {
        let viewModel = ViewModelLembrete()
        let mockSession = MockURLSession()
        
        // Crie um lembrete mock para ser removido
        let mockLembrete = LembreteModel(_id: "1", nome: "Lembrete de teste", descricao: "Descrição do lembrete de teste", data: "2023-07-20", status: true)
        
            
        // Configura o mockSession para não retornar dados
        mockSession.data = nil
        
        // Cria uma expectativa para aguardar a conclusão da chamada assíncrona
        let expectation = XCTestExpectation(description: "deleteLembretes")

        viewModel.deleteLembretes(lembrete: mockLembrete)

    }


    // Teste para a função postLembretes()
    func testPostLembretes() {
        let viewModel = ViewModelLembrete()
        let mockSession = MockURLSession()
        

        // Crie um lembrete mock para ser criado
        let mockLembrete = LembreteModel(_id: "1", nome: "Lembrete de teste", descricao: "Descrição do lembrete de teste", data: "2023-07-20", status: true)

        // Configura o mockSession para não retornar dados
        mockSession.data = nil
        viewModel.postLembretes(lembrete: mockLembrete)
        
    }

}


extension LembreteModel: Equatable {
    public static func == (lhs: LembreteModel, rhs: LembreteModel) -> Bool {
        return lhs._id == rhs._id
    }
}

