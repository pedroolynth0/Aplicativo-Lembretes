//
//  Card.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 20/07/23.
//


import SwiftUI

struct Card: View {
    var body: some View {
        ZStack {
            //MARK: -3. BAIXO
            Color(UIColor.lightGray)
                .cornerRadius(60)
                .offset(y:12)
            
            //MARK: -2. BORDA
            Color(UIColor.white)
                .cornerRadius(60)
                .offset(y:3)
                .opacity(0.9)
            
            //MARK: -1. SUPERFICIE
            Color(UIColor.clear)
            .cornerRadius(60)
        }
    }
        
}

struct CardView: PreviewProvider {
    static var previews: some View {
        Card()
            .padding()
            
    }
}
