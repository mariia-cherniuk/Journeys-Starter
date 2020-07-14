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

struct TipNode: Identifiable {
    let id = UUID()
    let name: String
    let nodes: [TipNode]?
}

struct TipsView: View {
    
    private var nodes: [TipNode] {
        let tips = Bundle.main.decode([Tip].self, from: "tips.json")
        return tips.map { TipNode(name: $0.title, nodes: [TipNode(name: $0.body, nodes: nil)]) }
    }
    
    var body: some View {
        List(nodes, children: \.nodes) { node in
            if node.nodes != nil {
                Label(node.name, systemImage: "quote.bubble")
            }
        }
        .navigationTitle("Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        PicksView()
    }
}
