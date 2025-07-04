//
//  LocationMapView.swift
//  GoTesla
//
//  Created by Adesh Shukla  on 30/06/25.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.503987, longitude: 77.097087),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var sliderValue: Double = 0.5
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // MARK: - Map Section
                ZStack {
                    Map(coordinateRegion: $region, annotationItems: mapAnnotations) { annotation in
                        MapAnnotation(coordinate: annotation.coordinate) {
                            AnnotationView(annotation: annotation)
                        }
                    }
                    .mapStyle(.standard(elevation: .flat))
                    .ignoresSafeArea(edges: .top)

                    // Top Navigation Bar (Only Speaker Button Now)
                    VStack {
                        HStack {
                            // Removed Back Button
                            
                            Spacer()

                            Button(action: {
                                // Speaker action
                            }) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                        
                        Spacer()
                    }
                    
                    // Car Location Indicator
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image(systemName: "car.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(.white)
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 3)
                                    )
                                    .shadow(radius: 10)
                                
                                Text("AMBIENCE ISLAND\nGURGAON")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(4)
                            }
                            Spacer()
                        }
                        Spacer()
                        Spacer()
                    }
                    
                    // Gurgaon Label
                    VStack {
                        Spacer()
                        Text("GURGAON")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.6)
                
                // MARK: - Bottom Control Section
                VStack(spacing: 0) {
                    // Location Info
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Location")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.gray)
                                Text("Ambience Island, Sector 25, Gurugram, Haryana 122001")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Summon")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Text("Press and hold controls to move vehicle")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    // Go to Target Button
                    Button(action: {}) {
                        Text("Go to Target")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                    
                    // Control Buttons and Slider
                    VStack(spacing: 16) {
                        HStack(spacing: 40) {
                            // Forward Button
                            Button(action: {}) {
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color.gray.opacity(0.3))
                                    .clipShape(Circle())
                            }
                            
                            // Backward Button
                            Button(action: {}) {
                                Image(systemName: "arrow.down")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color.gray.opacity(0.3))
                                    .clipShape(Circle())
                            }
                        }
                        
                        // Horizontal Slider
                        HStack {
                            Spacer()
                            Slider(value: $sliderValue, in: 0...1)
                                .accentColor(.white)
                                .frame(width: 120)
                            Spacer()
                        }
                    }
                    .padding(.bottom, 40)
                }
                .background(Color.black)
            }
        }
    }
}

// MARK: - Map Annotation Model
struct MapAnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let color: Color
    let icon: String
}

// MARK: - Sample Map Annotations (Updated for Gurgaon area)
let mapAnnotations = [
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.505987, longitude: 77.095087), title: "Shopping Mall", color: .orange, icon: "bag.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.502987, longitude: 77.099087), title: "Restaurant", color: .orange, icon: "fork.knife"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.508987, longitude: 77.100087), title: "Hotel", color: .orange, icon: "building.2"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.500987, longitude: 77.095087), title: "Park", color: .green, icon: "tree.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.505987, longitude: 77.092087), title: "College", color: .brown, icon: "graduationcap.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.507987, longitude: 77.097087), title: "Fashion Store", color: .orange, icon: "tshirt.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.501987, longitude: 77.100087), title: "Education Center", color: .brown, icon: "book.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.499987, longitude: 77.098087), title: "Garden", color: .green, icon: "leaf.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.498987, longitude: 77.099087), title: "City Park", color: .green, icon: "tree.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.506987, longitude: 77.094087), title: "Medical Center", color: .red, icon: "cross.fill"),
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 28.510987, longitude: 77.096087), title: "Department Store", color: .red, icon: "bag.fill")
]

// MARK: - Custom Annotation View
struct AnnotationView: View {
    let annotation: MapAnnotationItem
    
    var body: some View {
        VStack(spacing: 2) {
            Circle()
                .fill(annotation.color)
                .frame(width: 24, height: 24)
                .overlay(
                    Image(systemName: annotation.icon)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                )
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
            
            Text(annotation.title)
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(Color.black.opacity(0.7))
                .cornerRadius(4)
        }
    }
}

// MARK: - Preview
struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
            .preferredColorScheme(.dark)
    }
}
