//
//  ContentView.swift
//  MoonPhasesCycle
//
//  Created by Gina Van Buren on 12/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var moonPhase: String = getMoonPhase()
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("The Moon is currently in the \(moonPhase) phase!")
                .font(.largeTitle)
                .padding()
            
            Text("The phase updates dynamically based on the lunar cycle.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .onAppear {
            // Update the moon phase once a day
            timer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { _ in
                moonPhase = getMoonPhase()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

func getMoonPhase() -> String {
    // Reference New Moon Date (e.g., January 6, 2000, at 18:14 UTC)
    let referenceDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 6, hour: 18, minute: 14))!
    
    // Current Date
    let currentDate = Date()
    
    // Days since reference date
    let daysSinceReference = currentDate.timeIntervalSince(referenceDate) / (60 * 60 * 24)
    
    // Precise lunar cycle duration
    let moonCycle = 29.53059
    
    // Moon phase percentage (0 to 1)
    let phase = (daysSinceReference.truncatingRemainder(dividingBy: moonCycle)) / moonCycle
    let normalizedPhase = phase < 0 ? phase + 1 : phase // Handle negative remainders
    
    // Determine phase based on percentage
    switch normalizedPhase {
    case 0.0..<0.03:
        return "New Moon"
    case 0.03..<0.25:
        return "Waxing Crescent"
    case 0.25..<0.28:
        return "First Quarter"
    case 0.28..<0.53:
        return "Waxing Gibbous"
    case 0.53..<0.56:
        return "Full Moon"
    case 0.56..<0.78:
        return "Waning Gibbous"
    case 0.78..<0.81:
        return "Last Quarter"
    case 0.81..<1.0:
        return "Waning Crescent"
    default:
        return "New Moon"
    }
}



#Preview {
    ContentView()
}
