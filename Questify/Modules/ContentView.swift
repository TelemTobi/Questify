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

    var body: some View {
        NavigationStack {
            HStack {
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
                .padding(.trailing)
                
                VStack {
                    CountdownView(title: "Next Milestone", date: Date.now.advanced(by: 1000))
                    
                    CountdownView(title: "v5.15 Release", date: Date.now.advanced(by: 10000))
                }
            }
            .padding(.vertical)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: addItem) {
                        Image(systemName: "display")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "gear")
                    }
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
