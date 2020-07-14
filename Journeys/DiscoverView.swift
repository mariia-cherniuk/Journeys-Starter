//
//  DiscoverView.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import AVKit
import MapKit
import SwiftUI
import VisualEffects

struct DiscoverView: View {
    
    let location: Location
    @State private var region: MKCoordinateRegion
    
    let disclosureTitle = "Travel advisory"
    @State private var disclosureShowing = false
    
    @State private var selectedPicture: String?
    @Namespace var animation
    
    init(location: Location) {
        self.location = location
        _region = State(wrappedValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(location.heroPicture)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: geo.size.width)
                    .frame(height: geo.size.height * 0.7)
                
                ScrollView(showsIndicators: false) {
                    Spacer().frame(height: geo.size.height * 0.35)
                    
                    HStack {
                        Text(location.name)
                            .font(.system(size: 48, weight: .bold))
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(1), radius: 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(location.country)
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            Button {
                                print("Bookmarked")
                            } label: {
                                Image(systemName: "heart")
                                    .font(.title)
                                    .padding(20)
                                    .background(Circle().fill(Color.white))
                                    .shadow(radius: 10)
                            }
                            .offset(y: -40)
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(location.pictures, id: \.self) { picture in
                                    if picture == selectedPicture {
                                        Color.clear.frame(width: 150)
                                    } else {
                                        Image("\(picture)-thumb")
                                            .resizable()
                                            .frame(width: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                            .matchedGeometryEffect(id: picture, in: animation)
                                            .onTapGesture {
                                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.9)) {
                                                    selectedPicture = picture
                                                }
                                            }
                                    }
                                }
                            }
                            .frame(height: 100)
                            .padding([.horizontal, .bottom], 20)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(location.description)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("Don't miss")
                                .font(.title3)
                                .bold()
                                .padding(.top, 20)
                            
                            Text(location.more)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 50)
                        
                        Map(coordinateRegion: $region, interactionModes: [])
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .frame(height: 200)
                            .padding([.horizontal, .bottom], 20)
                        
                        
                        if !location.advisory.isEmpty {
                            DisclosureGroup {
                                Text(location.advisory)
                                    .font(.body)
                            } label: {
                                Text(disclosureTitle)
                                    .font(.title)
                                    .contentShape(Rectangle())
                                    
                                    .onTapGesture {
                                        withAnimation {
                                            disclosureShowing.toggle()
                                        }
                                    }
                            }
                            .padding()
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Background"))
                    )
                }
                
                if let picture = selectedPicture {
                    DiscoverOverlayView(selectedPicture: $selectedPicture, picture: picture, animation: animation)
                }
            }
        }
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(location: Location.example)
    }
}
