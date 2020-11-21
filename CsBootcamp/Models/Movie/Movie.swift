import Foundation

struct Movie: Decodable {
    
    let id: Int
    let genreIds: [Int]
    let title: String
    let overview: String
    let releaseDate: Date
    let posterPath: String
}
