//
//  ContentView.swift
//  WatchFX Watch App
//
//  Created by Mateusz Brychczynski on 07/06/2023.
//

import SwiftUI

struct ContentView: View {
    static let currencies = ["USD", "AUD", "CAD", "CHF", "CNY", "EUR", "GBP", "HKD", "JPY", "SGD", "PLN"]
    static let selectedCurrenciesKey = "SelectedCurrencies"
    static let defaultCurrencies = ["USD", "EUR"]
    
    @AppStorage("amount") var amount = 500.0
    @FocusState private var amountFocused: Bool
    @State private var selectedCurrency = "USD"
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    Text("\(Int(amount))")
                        .font(.system(size: 52))
                        .padding()
                        .frame(width: proxy.size.width)
                        .contentShape(Rectangle())
                        .focusable()
                        .focused($amountFocused)
                        .digitalCrownRotation($amount, from: 0, through: 1000, by: 20, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .strokeBorder(amountFocused ? .green : .white, lineWidth: 2)
                        )
                        .padding(.bottom)
                    
                    HStack {
                        Picker("Select a currency", selection: $selectedCurrency) {
                            ForEach(Self.currencies, id: \.self, content: Text.init)
                        }
                        .labelsHidden()
                        
                        NavigationLink("Go") {
                            ResultsView(amount: amount, baseCurrency: selectedCurrency)
                        }
                        .frame(width: proxy.size.width * 0.4)
                    }
                    .frame(height: proxy.size.height / 3)
                }
            }
            .navigationTitle("WatchFX")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
