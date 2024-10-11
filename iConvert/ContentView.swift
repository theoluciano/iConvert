//
//  ContentView.swift
//  iConvert
//
//  Created by Theo Luciano on 10/11/24.
//

import SwiftUI


struct ContentView: View {
    @State private var input = 0.0
    @State private var startingInput = "cup"
    @State private var startingOutput = "cup"
    @FocusState private var inputIsFocused: Bool
    
    let inputUnits = ["cup(s)", "pint(s)", "quart(s)", "gallon(s)", "swimming pool(s)"]
    let outputUnits = ["cup(s)", "pint(s)", "quart(s)", "gallon(s)", "swimming pool(s)"]
    
    var baseAmount: Double {
        switch startingInput {
        case "pint(s)":
            return input * 2
        case "quart(s)":
            return input * 4
        case "gallon(s)":
            return input * 16
        case "swimming pool(s)":
            return  input * 10_566_882
        default:
            return input
        }
    }
    
    var output: Double {
        switch startingOutput {
        case "pint(s)":
            return baseAmount / 2
        case "quart(s)":
            return baseAmount / 4
        case "gallon(s)":
            return baseAmount / 16
        case "swimming pool(s)":
            return baseAmount / 10_566_882
        default:
            return baseAmount
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("What do you want to convert?") {
                    TextField("Amount", value: $input, format: .number)
                    .focused($inputIsFocused)
                    .keyboardType(.decimalPad)
                    
                    Picker("Unit of Measurement", selection: $startingInput) {
                        ForEach(inputUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                        
                }
                
                Section("What do you want to convert it to?") {
                    Picker("Unit of Measurement", selection: $startingOutput) {
                        ForEach(outputUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Converted Output") {
                    Text("\(input.formatted()) \(startingInput) is \(output.formatted()) \(startingOutput)")
                    
                }
            }
            .navigationTitle("iConvert")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
