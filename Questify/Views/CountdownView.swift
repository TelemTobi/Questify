//
//  CountdownView.swift
//  Questify
//
//  Created by Telem Tobi on 27/04/2024.
//

import SwiftUI

struct CountdownView: View {
    
    let title: String
    let date: Date
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
            
            Text(timerInterval: Date.now...date)
                .fontWeight(.bold)
                .font(.system(size: 150))
        }
        .padding(50)
        .frame(width: 600)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    CountdownView(title: "v5.15 Release", date: Date.now.advanced(by: 10000))
}
