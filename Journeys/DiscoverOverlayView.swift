//
//  DiscoverOverlayView.swift
//  Journeys
//
//  Created by Mariia Cherniuk on 14/07/2020.
//

import SwiftUI

struct DiscoverOverlayView: View {
    
    @Binding var selectedPicture: String?
    var picture: String
    var animation: Namespace.ID
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image(picture)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity)
                        .matchedGeometryEffect(id: picture, in: animation)

                    Button {
                        withAnimation {
                            selectedPicture = nil
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding(2)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding()
                    .offset(x: -10, y: 30)
                }

                Text("Important title")
                    .font(.title)
                    .bold()
                    .padding([.top, .horizontal])

                Text("This is some text")
                    .font(.title3)
                    .padding(.horizontal)
            }
        }
        .background(Color.white)
    }
}
