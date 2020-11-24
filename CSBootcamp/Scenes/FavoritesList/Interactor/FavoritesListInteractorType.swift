import Foundation

protocol FavoritesListInteractorType {
    func fetchFavorites(filteringWithGenre genre: Genre?, releaseYear: Int?)
    func removeFavorite(at index: Int)
}
