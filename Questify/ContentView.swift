//
//  ContentView.swift
//  Questify
//
//  Created by Telem Tobi on 26/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State var degreesRotating = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationSplitView {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: addItem) {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {}) {
                            Image(systemName: "gear")
                        }
                    }
                }
            } detail: {
                Text("Select an item")
            }
            .background {
                let viewSize = CGSize(width: geometry.size.width * 1.5, height: geometry.size.height * 3)
                
                ZStack {
                    ForEach(0..<10, id: \.self) { index in
                        let randomSize = CGFloat.random(in: 50...800)
                        let randomX = CGFloat.random(in: 0...viewSize.width)
                        let randomY = CGFloat.random(in: 0...viewSize.height)
                        let randomOpacity = CGFloat.random(in: 0.3...1)
                        
                        Color.blue
                            .frame(width: randomSize, height: randomSize)
                            .clipShape(.circle)
                            .position(x: randomX, y: randomY)
                            .opacity(randomOpacity)
                    }
                }
                .frame(width: viewSize.width, height: viewSize.height)
                .overlay(.ultraThinMaterial)
                .rotationEffect(.degrees(degreesRotating))
            }
            .onAppear {
                withAnimation(.linear(duration: 10).speed(0.2).repeatForever(autoreverses: false)) {
                    degreesRotating = 360
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
