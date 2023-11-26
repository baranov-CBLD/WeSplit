//
//  ContentView.swift
//  WeSplit
//
//  Created by Kirill Baranov on 24/11/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0.20
    
    @FocusState private var amountIsFocused: Bool
    @State private var isEditing = false
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let grandTotal = checkAmount + checkAmount * tipSelection
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        
        
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach (2..<100) {
                            Text ("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    
                    Slider(value: $tipPercentage, in: 0...1, step: 0.01)
                
                    Text(tipPercentage, format: .percent)
                    
                    

                    
                    
                }
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}



#Preview {
    ContentView()
}
