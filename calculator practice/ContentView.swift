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
    
    // limit the symbols displayed to 10
    // fix the delete button
    // create a previous history tab
    
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
            let resultString = String(result)
            myHistory.append(resultString)
        case "/":
            result = right == 0 ? 0 :left / right
            let resultString = String(result)
            myHistory.append(resultString)
        case "-":
            result = left - right
            let resultString = String(result)
            myHistory.append(resultString)
        case "+":
            result =  left + right
            let resultString = String(result)
            myHistory.append(resultString)
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
        myHistory = []
    }
    
    func handlePercentage(){
        guard let currentValue = Double(currentInput) else { return }
        currentInput = String(currentValue / 100)
    }
    
    func handleDecimals(){
        if !currentInput.contains(".") {
            currentInput.append(".")
            myHistory.append(currentInput)
        }
    }
    
    func handlePlusMinus(){
        guard var currentValue = Double(currentInput) else { return }
        currentValue *= -1
        currentInput = String(currentValue)
        myHistory.append(currentInput)
    }
    
    func handleDelete(){
        if !currentInput.isEmpty{
            currentInput.removeLast()
        }
        if currentInput.isEmpty{
            currentInput = "0"
        }
        
        myHistory.count > 0 ? myHistory.count -= 1 : ()
    }
    
    let buttonSymbols = [
        ["del", "AC", "%" ,"/",],
        ["7", "8", "9", "x",],
        ["4", "5", "6", "-",],
        ["1", "2", "3", "+",],
        ["+/-","0", ".", "=",],
    ]
    var body: some View {
        VStack {
            Spacer(minLength: 120)
            HStack{
                if myHistory.isEmpty{
                    Text(currentInput)
                        .font(.system(size: 67, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                }else{
                    ForEach(myHistory, id: \.self) { text in
                        Text(text)
                            .font(.system(size: 67, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.3)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            ForEach(buttonSymbols, id: \.self){ row in
                HStack{
                    ForEach(row, id: \.self){ symbol in
                        Button(action: {
                            if symbol >= "0" && symbol <= "9" {
                                if myHistory.count <= 10{
                                    myHistory.append(symbol)
                                    handleNumberTap(symbol)
                                }
                            }else if  symbol == "+" || symbol == "-" || symbol == "x" || symbol == "/"{
                                myHistory.append(symbol)
                                handleOperatorTap(symbol)
                            }else if symbol == "="{
                                myHistory.append(symbol)
                                handleEqualsSign()
                            }else if symbol == "AC" {
                                handleAC()
                            }else if symbol == "%"{
                                handlePercentage()
                            }else if symbol == "."{
                                handleDecimals()
                            }else if symbol == "+/-"{
                                handlePlusMinus()
                            }else if symbol == "del"{
                                handleDelete()
                            }
                        }){
                            if symbol == "del" {
                                Image(systemName: "delete.left.fill")
                                    .font(.title)
                            }else if symbol == "AC"{
                                Image(systemName: "ac")
                                    .font(.title)
                            }else if symbol == "=" {
                                Image(systemName: "equal.circle")
                                    .font(.title)
                            }else if symbol == "x" {
                                Image(systemName: "multiply.circle")
                                    .font(.title)
                            }else if symbol == "/"{
                                Image(systemName: "equal.circle")
                                    .font(.title)
                            }else if symbol == "-" {
                                Image(systemName: "minus.circle")
                                    .font(.title)
                            }else if symbol == "+"{
                                Image(systemName: "plus.circle")
                                    .font(.title)
                            }else if symbol == "%"{
                                Image(systemName: "percent")
                                    .font(.title)
                            }else{
                                Text(symbol)
                                    .font(.title)
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(width: 86, height: 81, alignment: .center)
                        .foregroundColor(Color.black)
                        .background((symbol == "/" ||
                           symbol == "x"   ||
                           symbol == "-"   ||
                           symbol == "+"   ||
                           symbol == "="         ) ?
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
