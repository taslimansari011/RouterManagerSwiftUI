//
//  MovieModel.swift
//  NavigationRouterDemo
//
//  Created by Taslim Ansari on 07/03/24.
//

import Foundation

public struct Movie: Hashable {
    let name: String
    let description: String
    let rating: Double
    let reviews: [Review]
    let year: Int
    let runtime: String
    let imageName: String
}

struct MoviesDataProvider {
    static func buildData() -> [Movie] {
        return [
            Movie(
                name: "Sunflower",
                description: "A quirky murder mystery based in a housing society called Sunflower. Its simpleton resident Sonu dives headlong into a murder mystery and becomes the chief suspect. What happens next?",
                rating: 7.5,
                reviews: [
                    Review(text: "Sonu finds himself at the center of the mess as his connection with Rosie entangles him further in the murder case. The case is finally closed with the revelation of the unexpected murderer."),
                    Review(text: "Following another Sunflower Society killing, Sonu is the lead suspect. He hopes to uncover the true criminal from the shady new tenants in the building."),
                    Review(text: "Following another Sunflower Society killing, Sonu is the lead suspect. He hopes to uncover the true criminal from the shady new tenants in the building.")
                ],
                year: 2023,
                runtime: "2h 22m",
                imageName: "sunflower"
            ),
            Movie(
                name: "Chamak",
                description: "Kaala - an aspirational rapper from Canada who flees back to Punjab, learns about the mysterious murder of his father and iconic singer Taara Singh. The story unfolds the dark side of music industry's glamour, politics and more.",
                rating: 9.3,
                reviews: [],
                year: 2024,
                runtime: "2h 15m",
                imageName: "chamak"
            ),
            Movie(
                name: "The Jengaburu Curse",
                description: "A London-based analyst returns to Odisha in search of her missing father. Her quest leads to a conspiracy involving bauxite mining, secretly backed by an international nexus, leading to unexplained deaths and a displaced community.",
                rating: 7.8,
                reviews: [
                    Review(text: "Why is there a billionaire investing in Jengaburu? The Tamba Nagraj story comes alive for Priya and Kadey as they make their way into the mines. Will they ever be able to stop the delivery and get their home back?"),
                    Review(text: "Really interesting story. Amazing cinematic experience at home. Enjoyed a lot watching this thrilling series. In regional language also it's superb to watch especially in odia language. The story is really have interesting twist and turns till the end."),
                    Review(text: "One time watch")
                ],
                year: 2020,
                runtime: "1h 33m",
                imageName: "jengbaru"
            )
        ]
    }
    
    static func moviesWith(id: Int) -> Movie {
        let data = MoviesDataProvider.buildData()
        if data.count > id {
            return MoviesDataProvider.buildData()[id]
        }
        return data.first!
    }
}
