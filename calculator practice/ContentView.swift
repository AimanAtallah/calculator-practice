//
//  ContentView.swift
//  calculator practice
//
//  Created by Aiman Atallah on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @State var currentInput = "0"
    @State var previousInput = "0"
    @State var currentOperator: String? = nil
    @State var computeDone = false
    @State var myHistory: [String] = []
    
    
    
    
    func handleNumberTap(_ symbol: String){
        if computeDone {
            currentInput = symbol
            computeDone = false
            return
        }
        if currentInput == "0" {
            currentInput = symbol
            return
        }
        currentInput += symbol
    }

    func handleOperatorTap(_ op: String){
        previousInput = currentInput
        currentOperator = op
        currentInput = "0"
        computeDone = false
    }
    
    func handleEqualsSign(){
        guard let op = currentOperator else { return }
        
        let left = Double(previousInput) ?? 0
        let right = Double(currentInput) ?? 0
        var result = 0.0
        
        switch op {
        case "x":
            result = left * right
        case "/":
            result = right == 0 ? 0 :left / right
        case "-":
            result = left - right
        case "+":
            result =  left + right
        default:
            break
        }
        currentInput = String(result)
        previousInput = String(result)
        currentOperator = nil
        computeDone = true
    }
    func handleAC(){
        currentInput = "0"
        previousInput = "0"
        currentOperator = nil
        computeDone = false
    }
    
    func handlePercentage(){
        guard let currentValue = Double(currentInput) else { return }
        currentInput = String(currentValue / 100)
    }
    
    func handleDecimals(){
        if !currentInput.contains(".") {
            currentInput.append(".")
        }
    }
    
    func handlePlusMinus(){
        guard var currentValue = Double(currentInput) else { return }
        currentValue *= -1
        currentInput = String(currentValue)
    }
    
    let buttonSymbols = [
        ["AC", "+/-", "%" ,"/",],
        ["7", "8", "9", "x",],
        ["4", "5", "6", "-",],
        ["0", ".", "=", "+",],
    ]
    var body: some View {
        VStack {
            HStack{
                if myHistory == []{
                    Text(currentInput)
                }else{
                    ForEach(myHistory, id: \.self) { text in
                        Text(text)
                    }
                }
            }
            ForEach(buttonSymbols, id: \.self){ row in
                HStack{
                    ForEach(row, id: \.self){ symbol in
                        Button(symbol) {
                            if symbol >= "0" && symbol <= "9" {
                                
                                handleNumberTap(symbol)
                            }else if  symbol == "+" || symbol == "-" || symbol == "x" || symbol == "/"{
                                myHistory.append(symbol )
                                handleOperatorTap(symbol)
                            }else if symbol == "="{
                                handleEqualsSign()
                            }else if symbol == "AC" {
                                handleAC()
                            }else if symbol == "%"{
                                myHistory.append(symbol )
                                handlePercentage()
                            }else if symbol == "."{
                                myHistory.append(symbol )
                                handleDecimals()
                            }else if symbol == "+/-"{
                                myHistory.append(symbol )
                                handlePlusMinus()
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(width: 50, height: 45, alignment: .center)
                        .foregroundColor(Color.black)
                        .background((symbol == "/" ||
                           symbol == "x"   ||
                           symbol == "-"   ||
                           symbol == "+"    ) ?
                                    Color.orange : Color.gray)
                        .clipShape(Capsule())
                        .foregroundColor(Color.black)
                        
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
