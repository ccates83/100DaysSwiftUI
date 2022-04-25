//
//  ContentView.swift
//  UnitConversions
//
//  Created by Connor Cates on 4/25/22.
//

import SwiftUI

struct ContentView: View {
    
    enum Units: String, CaseIterable {
        case sec = "Sec"
        case min = "Min"
        case hour = "Hours"
        case day = "Days"
    }
    
    // MARK: - State
    @State private var selectedFromUnit: Units = .sec
    @State private var selectedToUnit: Units = .sec
    
    @State private var fromValue: Double = 0
    
    // MARK: - Properties
    let units = ["Sec", "Min", "Hours", "Days"]
    
    var convertedVal: Double {
        let conversion = (self.selectedFromUnit, self.selectedToUnit)
        
        switch conversion {
        case (.sec, .sec), (.min, .min), (.hour, .hour), (.day, .day):
            return self.fromValue
            
        // From sec
        case (.sec, .min):
            return self.fromValue / 60
        case (.sec, .hour):
            return self.fromValue / 60 / 60
        case (.sec, .day):
            return self.fromValue / 60 / 60 / 24
            
        // From min
        case (.min, .sec):
            return self.fromValue * 60
        case (.min, .hour):
            return self.fromValue / 60
        case (.min, .day):
            return self.fromValue / 60 / 24
            
        // From hour
        case (.hour, .sec):
            return self.fromValue * 60 * 60
        case (.hour, .min):
            return self.fromValue * 60
        case (.hour, .day):
            return self.fromValue / 24
            
        // From day
        case (.day, .sec):
            return self.fromValue * 60 * 60 * 24
        case (.day, .min):
            return self.fromValue * 60 * 24
        case (.day, .hour):
            return self.fromValue * 24
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    HStack {
                        TextField("", value: self.$fromValue, formatter: NumberFormatter())
                            .frame(maxWidth: 100)
                        Text("\(self.selectedFromUnit.rawValue)")
                        Spacer()
                    }
                    Picker("Convert from", selection: self.$selectedFromUnit) {
                        ForEach(Units.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert")
                }
                
                Section() {
                    Picker("Convert to", selection: self.$selectedToUnit) {
                        ForEach(Units.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section() {
                    Text("\(self.convertedVal) \(self.selectedToUnit.rawValue)")
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Time Conversion")
        }
    }
    
    private func secToMin(_ from: Double) -> Double {
        return from / 60
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
