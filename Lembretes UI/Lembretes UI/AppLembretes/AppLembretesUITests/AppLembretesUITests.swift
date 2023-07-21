//
//  AppLembretesUITests.swift
//  AppLembretesUITests
//
//  Created by Pedro Olyntho on 18/07/23.
//

import XCTest
@testable import AppLembretes


final class AppLembretesUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testTitleIsPresent() throws {
        // Encontre o título "Lista de lembretes" na interface
        let title = app.staticTexts["Lista de lembretes"]
        
        // Verifique se o título está presente
        XCTAssertTrue(title.exists, "Título 'Lista de lembretes' não encontrado na interface")
        XCUIApplication().launchArguments = ["UITesting"]
    }

    func testButtonIsPresent() throws {
        // Encontre o botão "Adicionar lembretes" na interface
        let addButton = app.buttons["Adicionar lembretes"]
        
        // Verifique se o botão está presente
        XCTAssertTrue(addButton.exists, "Botão 'Adicionar lembretes' não encontrado na interface")
    }

    func testTapButtonToShowSheet() throws {
        // Encontre o botão "Adicionar lembretes" na interface
        let addButton = app.buttons["Adicionar lembretes"]

        // Clique no botão "Adicionar lembretes"
        addButton.tap()

        // Verifique se a tela de adição de lembrete é apresentada
        let adicionarLembreteText = app.staticTexts["Adicionar lembrete"]
        let nomeTextField = app.textFields["Nome"]
        let descricaoTextField = app.textFields["Descrição"]
        let salvarButton = app.buttons["Salvar"]

        XCTAssertTrue(adicionarLembreteText.exists, "Tela de adição de lembrete não foi apresentada após tocar no botão 'Adicionar lembretes'")
        XCTAssertTrue(nomeTextField.exists, "Campo de nome não está visível na tela de adição de lembrete")
        XCTAssertTrue(descricaoTextField.exists, "Campo de descrição não está visível na tela de adição de lembrete")
        XCTAssertTrue(salvarButton.exists, "Botão 'Salvar' não está visível na tela de adição de lembrete")
    }



    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
