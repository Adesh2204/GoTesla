//
//  ContentView.swift
//  GoTesla
//
//  Created by Adesh Shukla  on 29/06/25.
//

// Tesla Style App - Clean & Working SwiftUI Code

import SwiftUI
import MapKit

// MARK: - ContentView
struct ContentView: View {
    @State private var showMediaControlSheet = false
    @State private var showChargingView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HomeHeader()
                        CustomDivider()
                        CarSection()
                        CustomDivider()
                        CategoryView(
                            title: "Quick Shortcuts",
                            actionItems: quickShortcuts,
                            showMediaSheet: $showMediaControlSheet,
                            showChargingSheet: $showChargingView
                        )
                        CustomDivider()
                        CategoryView(
                            title: "Recent Actions",
                            actionItems: recentActions,
                            showMediaSheet: .constant(false),
                            showChargingSheet: .constant(false)
                        )
                        CustomDivider()
                        AllSettings()
                        ReorderButton()
                    }
                    .padding()
                }
                VoiceCommandButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DarkGrey"))
            .foregroundColor(.white)
            .navigationTitle("Mach Five")
            .navigationBarHidden(true)
            // Media Control Sheet
            .sheet(isPresented: $showMediaControlSheet) {
                ZStack {
                    Color.black.ignoresSafeArea()
                    MediaControlView()
                }
                .presentationDetents([.fraction(0.4), .medium, .large])
                .presentationDragIndicator(.visible)
            }
            // Charging Sheet
            .sheet(isPresented: $showChargingView) {
                ZStack {
                    Color.black.ignoresSafeArea()
                    ChargingView()
                }
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

// MARK: - Home Header
struct HomeHeader: View {
    @State private var showBluetoothAlert = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Model 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Color("Red"))
                    .clipShape(Capsule())
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            HStack(spacing: 16) {
                Button(action: {}) { GeneralButton(icon: "lock.fill") }
                Button(action: {}) { GeneralButton(icon: "gear") }
                Button(action: { showBluetoothAlert = true }) { GeneralButton(icon: "bluetooth") }
            }
        }
        .padding(.top)
        .alert("Bluetooth", isPresented: $showBluetoothAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Bluetooth is on")
        }
    }
}

// MARK: - General Button
struct GeneralButton: View {
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .imageScale(.large)
            .foregroundColor(.white)
            .frame(width: 44, height: 44)
            .background(Color.white.opacity(0.05))
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 0.5))
    }
}

// MARK: - Divider
struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 0.25)
            .background(Color.white)
            .opacity(0.1)
    }
}

// MARK: - Car Section
struct CarSection: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                HStack {
                    Image(systemName: "battery.75")
                        .foregroundColor(.green)
                    Text("237 MILES")
                        .foregroundColor(.green)
                }
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Parked")
                        .fontWeight(.semibold)
                    Text("Last updated 5 min ago")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            Image("Car")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

// MARK: - Category Header
struct CategoryHeader: View {
    var title: String
    var showEdit: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            if showEdit {
                Button("Edit") {}
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
            }
        }
    }
}

// MARK: - Category View
struct CategoryView: View {
    var title: String
    var showEdit: Bool = false
    var actionItems: [ActionItem]
    @Binding var showMediaSheet: Bool
    @Binding var showChargingSheet: Bool
    
    init(
        title: String,
        showEdit: Bool = false,
        actionItems: [ActionItem],
        showMediaSheet: Binding<Bool>,
        showChargingSheet: Binding<Bool>
    ) {
        self.title = title
        self.showEdit = showEdit
        self.actionItems = actionItems
        self._showMediaSheet = showMediaSheet
        self._showChargingSheet = showChargingSheet
    }
    
    var body: some View {
        VStack {
            CategoryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(actionItems, id: \.self) { item in
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            switch item.text {
                            case "Media Controls":
                                showMediaSheet = true
                            case "Charging":
                                showChargingSheet = true
                            default:
                                break
                            }
                        }) {
                            ActionButton(item: item)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Action Button
struct ActionButton: View {
    var item: ActionItem
    
    var body: some View {
        VStack(spacing: 8) {
            GeneralButton(icon: item.icon)
            Text(item.text)
                .frame(width: 72)
                .font(.system(size: 12, weight: .semibold))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Action Item
struct ActionItem: Hashable {
    var icon: String
    var text: String
}

let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "bolt.fill", text: "Charging"),
    ActionItem(icon: "fanblades.fill", text: "Fan On"),
    ActionItem(icon: "music.note", text: "Media Controls"),
    ActionItem(icon: "bolt.car", text: "Close Charge Port")
]

let recentActions: [ActionItem] = [
    ActionItem(icon: "arrow.up.square", text: "Open Trunk"),
    ActionItem(icon: "fanblades", text: "Fan Off"),
    ActionItem(icon: "person.fill.viewfinder", text: "Summon")
]

// MARK: - All Settings
struct AllSettings: View {
    var body: some View {
        VStack {
            CategoryHeader(title: "All Settings")
            LazyVGrid(columns: [GridItem(.fixed(170)), GridItem(.fixed(170))], spacing: 16) {
                NavigationLink(destination: CarControlsView()) {
                    SettingBlock(icon: "car.fill", title: "Controls", subtitle: "Car Locked")
                }
                SettingBlock(icon: "fanblades.fill", title: "Climate", subtitle: "Interior 68°F", backgroundColor: Color("Blue"))
                NavigationLink(destination: LocationMainView()) {
                    SettingBlock(icon: "location.fill", title: "Location", subtitle: "Ambience Island, Gurgaon")
                }
                SettingBlock(icon: "checkerboard.shield", title: "Security", subtitle: "0 events detected")
                SettingBlock(icon: "sparkles", title: "Upgrades", subtitle: "3 upgrades available")
            }
            .foregroundColor(.white)
        }
    }
}

// MARK: - Setting Block
struct SettingBlock: View {
    var icon: String
    var title: String
    var subtitle: String
    var backgroundColor: Color = Color.white.opacity(0.05)
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                Text(subtitle.uppercased())
                    .font(.system(size: 8))
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.1), lineWidth: 0.5))
    }
}

// MARK: - Reorder Button
struct ReorderButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Reorder Groups")
                .font(.caption)
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.white.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}

// MARK: - Voice Command Button
struct VoiceCommandButton: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "mic.fill")
                    .font(.system(size: 24, weight: .semibold))
                    .frame(width: 64, height: 64)
                    .background(Color("Green"))
                    .foregroundColor(Color("DarkGrey"))
                    .clipShape(Circle())
                    .padding()
                    .shadow(radius: 10)
            }
        }
    }
}

// MARK: - Location View
struct LocationMainView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.5043, longitude: 77.0963),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $region)
                .mapStyle(.standard(elevation: .flat))
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Location")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.white)
                    Text("Ambience Island, Sector 25, Gurugram, Haryana")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                
                Text("Summon")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Text("Press and hold controls to move vehicle")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Button(action: {}) {
                    Text("Go to Target")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                HStack {
                    Spacer()
                    ControlCircle(icon: "arrow.up")
                    Spacer()
                    ControlCircle(icon: "arrow.down")
                    Spacer()
                }
                
                Slider(value: .constant(0.5))
                    .accentColor(.white)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.black.opacity(0.85))
                    .padding(.horizontal, 0)
                    .padding(.bottom, 0)
            )
        }
    }
    
    struct ControlCircle: View {
        var icon: String
        
        var body: some View {
            Button(action: {}) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(Circle())
            }
        }
    }
    
    // MARK: - Media Control View
    struct MediaControlView: View {
        var body: some View {
            VStack {
                Text("Media Controls")
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Car Controls View
    struct CarControlsView: View {
        var body: some View {
            ZStack {
                Color("DarkGrey")
                    .ignoresSafeArea()
                Text("Car Controls")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
    
    // MARK: - Charging View
    struct ChargingView: View {
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .imageScale(.large)
                                .padding()
                        }
                    }
                    .padding(.top, 10)
                    
                    Text("Charging View Content")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    // MARK: - Preview
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
    
    struct LocationMainView_Previews: PreviewProvider {
        static var previews: some View {
            LocationMainView()
                .preferredColorScheme(.dark)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro"))
            .previewDisplayName("iPhone 16 Pro")
    }
}
