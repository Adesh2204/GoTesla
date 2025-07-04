//
//  MediaControlView.swift
//  GoTesla
//
//  Created by Adesh Shukla  on 30/06/25.
//

import SwiftUI
import AVFoundation

struct MediaControlView: View {
    // MARK: - Audio State
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var totalDuration: Double = 1
    @State private var volume: Double = 0.8
    @State private var timer: Timer?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Header
            HStack(alignment: .top, spacing: 12) {
                Image("BaandBaajaBarat") // Ensure it's in Assets
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(4)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Ainvayi Ainvayi")
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(1)

                        Spacer()

                        Image(systemName: "music.note")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.green)
                    }

                    Text("Salim–Sulaiman, Sunidhi Chauhan")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }

                Spacer()
            }

            // MARK: - Progress Bar
            VStack(spacing: 8) {
                Slider(value: $currentTime, in: 0...totalDuration, onEditingChanged: { editing in
                    if !editing {
                        player?.currentTime = currentTime
                    }
                })
                .accentColor(.green)

                HStack {
                    Text(timeString(from: currentTime))
                    Spacer()
                    Text("-\(timeString(from: totalDuration - currentTime))")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }

            // MARK: - Playback Controls
            HStack(spacing: 30) {
                Button(action: {
                    player?.currentTime = 0
                    currentTime = 0
                }) {
                    Image(systemName: "backward.fill")
                        .font(.title3)
                }

                Button(action: {
                    if isPlaying {
                        player?.pause()
                        stopTimer()
                    } else {
                        player?.play()
                        startTimer()
                    }
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title3)
                }

                Button(action: {
                    guard let player = player else { return }
                    let newTime = min(player.currentTime + 10, player.duration)
                    player.currentTime = newTime
                    currentTime = newTime
                }) {
                    Image(systemName: "forward.fill")
                        .font(.title3)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)

            // MARK: - Volume Control
            HStack(spacing: 12) {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.white)

                Slider(value: $volume, in: 0...1)
                    .onChange(of: volume) { newValue in
                        player?.volume = Float(newValue)
                    }
                    .accentColor(.green)

                Image(systemName: "speaker.wave.3.fill")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
        .onAppear {
            loadAudio()
        }
        .onDisappear {
            stopTimer()
            player?.stop()
        }
    }

    // MARK: - Helpers
    func timeString(from seconds: Double) -> String {
        let min = Int(seconds) / 60
        let sec = Int(seconds) % 60
        return String(format: "%d:%02d", min, sec)
    }

    func loadAudio() {
        if let url = Bundle.main.url(forResource: "AinvayiAinvayi", withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                totalDuration = player?.duration ?? 1
                player?.prepareToPlay()
                player?.volume = Float(volume)
            } catch {
                print("❌ Failed to load audio: \(error)")
            }
        } else {
            print("❌ Audio file not found in bundle.")
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            guard let player = player else { return }
            currentTime = player.currentTime
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Preview
struct MediaControlView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            MediaControlView()
        }
        .preferredColorScheme(.dark)
    }
}
