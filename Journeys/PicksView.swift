//
//  PicksView.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import SwiftUI

struct PicksView: View {
    
    @EnvironmentObject var locations: Locations
    @ScaledMetric var frame: CGFloat = 100
    
    private let layout = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                TabView {
                    ForEach(locations.primary.pictures, id: \.self) { picture in
                        VStack {
                            Image(picture)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .frame(width: geo.size.width, height: 250)
                            
                            Spacer()
                        }
                    }
                }
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(locations.places) { place in
                        NavigationLink(destination: DiscoverView(location: place)) {
                            VStack {
                                Image(place.heroPicture)
                                    .resizable()
                                    .frame(width: max(90, min(frame, 120)), height:  max(90, min(frame, 120)))
                                    .overlay(
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Text(place.name)
                                                    .font(.caption)
                                                    .padding(8)
                                                    .foregroundColor(.white)
                                                Spacer()
                                            }
                                            .background(Color.black.opacity(0.2))
                                        }
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Our Top Picks")
    }
}

struct PicksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PicksView()
        }
        .environmentObject(Locations())
    }
}
