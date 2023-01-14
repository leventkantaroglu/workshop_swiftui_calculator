//
//  ContentView.swift
//  workshoo_swiftui_calculator
//
//  Created by Levent Kantaroğlu on 14.01.2023.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent

    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .divide: return "/"
        case .ac: return "AC"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .decimal: return "."
        }
    }

    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        case .divide, .multiply, .minus, .plus, .equals:
            return .orange
        }
    }
}

class GlobalEnvironment: ObservableObject {
    @Published var display = ""

    func receiveInput(button: CalculatorButton) {
        self.display = button.title
    }
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnvironment

    let buttonArrays: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals],
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(.white).font(.system(size: 64))
                }.padding()
                ForEach(buttonArrays, id: \.self) { buttonArray in
                    HStack(spacing: 12) {
                        ForEach(buttonArray, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct CalculatorButtonView: View {
    var button: CalculatorButton
    @EnvironmentObject var env: GlobalEnvironment
    var body: some View {
        Button(action: {
            self.env.receiveInput(button: button)
        }) {
            Text(button.title).font(.system(size: 32)).frame(width: self.buttonWidth(button: button), height: self.buttonHeight()).foregroundColor(.white).background(button.backgroundColor).cornerRadius(self.buttonWidth(button: button))
        }
    }

    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - (4 * 12)) / 4 * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
