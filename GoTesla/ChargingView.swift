//
//  ChargingView.swift
//  GoTesla
//
//  Created by Adesh Shukla  on 01/07/25.
//

import SwiftUI

struct ChargingView: View {
    @State private var chargeLimit: Double = 315

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Top: Battery Info
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Image(systemName: "bolt.fill")
                    .foregroundColor(.green)
                    .font(.body)
                Text("237 miles")
                    .font(.headline)
                    .foregroundColor(.green)
            }

            // Sub-info: Time, Amperage, Speed
            Text("3h 55m remain – 32/3A – 30 mi/hour")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))

            // Charge Limit Label
            Text("Charge Limit: \(Int(chargeLimit)) miles")
                .font(.footnote)
                .foregroundColor(.gray)

            // Progress Bar
            Slider(value: $chargeLimit, in: 0...400)
                .accentColor(.green)

            Divider()
                .background(Color.white.opacity(0.2))

            // Stop Charging Button
            Button(action: {
                // Stop charging action
            }) {
                Text("Stop Charging")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color.black)
        .cornerRadius(16)
        .padding()
    }
}

// MARK: - Preview
struct ChargingStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingView()
            .preferredColorScheme(.dark)
    }
}

