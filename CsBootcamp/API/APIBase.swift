import Foundation

struct APIBase {
    static let baseUrl = URL(string: "https://api.themoviedb.org/3")!

    private static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")!

    static func posterImageURL(path: String) -> URL {
        return imageBaseURL.appendingPathComponent(path)
    }
}
