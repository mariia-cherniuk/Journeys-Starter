//
//  PicksView.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import SwiftUI

struct PicksView: View {
    
    @EnvironmentObject var locations: Locations
    
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
