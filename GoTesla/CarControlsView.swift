//
//  CarControlsView.swift
//  GoTesla
//
//  Created by Adesh Shukla  on 30/06/25.
//

import SwiftUI

struct CarControlsView: View {
    // MARK: - State Variables
    @State private var isValetModeOn: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            // MARK: - Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Car Controls")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                // Unlock Button
                Button(action: {}) {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Unlock Car")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6).opacity(0.15))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            // MARK: - Control Buttons
            VStack(spacing: 20) {
                HStack(spacing: 32) {
                    CarControlButton(icon: "flashlight.on.fill", label: "Flash")
                    CarControlButton(icon: "speaker.wave.2.fill", label: "Honk")
                    CarControlButton(icon: "power", label: "Start")
                }

                HStack(spacing: 32) {
                    CarControlButton(icon: "car.front.waves.up.fill", label: "Front Trunk")
                    CarControlButton(icon: "car.rear.waves.up.fill", label: "Trunk")
                }
            }

            // MARK: - Valet Mode Toggle
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Valet Mode")
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isValetModeOn)
                        .labelsHidden()
                }

                if isValetModeOn {
                    Text("Valet Mode is Enabled")
                        .font(.title)
                        .foregroundColor(.green)
                        .transition(.opacity)
                }
            }
            .padding(.horizontal)
            .padding(.top)

            Spacer()
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .animation(.easeInOut, value: isValetModeOn)
    }
}

// MARK: - Reusable Control Button View
struct CarControlButton: View {
    let icon: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Button(action: {}) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.systemGray6).opacity(0.15))
                    .clipShape(Circle())
            }
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.9))
        }
    }
}

// MARK: - Preview
struct CarControlsView_Preview: PreviewProvider {
    static var previews: some View {
        CarControlsView()
    }
}
