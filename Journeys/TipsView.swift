//
//  TipsView.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import SwiftUI

struct Tip: Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case title, body
    }

    let id = UUID()
    let title: String
    let body: String
}

struct TipsView: View {
    let tips = Bundle.main.decode([Tip].self, from: "tips.json")

    var body: some View {
        List(tips) { tip in
            VStack(alignment: .leading) {
                Text(tip.title)
                    .font(.headline)
                Text(tip.body)
            }
            .padding(.vertical)
        }
        .navigationTitle("Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        PicksView()
    }
}
