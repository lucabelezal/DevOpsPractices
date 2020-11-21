import Foundation
import UIKit.UIImage

protocol MoviesListView: class {
    
    func displayMovies(viewModel: MoviesListViewModel)
    func displayError(viewModel: MoviesListErrorViewModel)
}

final class MoviesListPresenter: MoviesListPresenterType {
    
    private unowned let view: MoviesListView
    
    init(view: MoviesListView) {
        
        self.view = view
    }
    
    func presentMovies(_ movies: [FetchMoviesListResponse]) {
        
        let cellViewModels = movies.map { movie -> MovieCollectionViewCell.ViewModel in
            let favoriteButtonImage = movie.isFavorite ? #imageLiteral(resourceName: "favorite_full_icon") : #imageLiteral(resourceName: "favorite_gray_icon")
            return MovieCollectionViewCell.ViewModel(
                imageURL: APIBase.posterImageURL(path: movie.posterPath),
                title: movie.title,
                favoriteButtonImage: favoriteButtonImage
            )
        }
        
        let viewModel = MoviesListViewModel(cellViewModels: cellViewModels)
        view.displayMovies(viewModel: viewModel)
    }
    
    func presentError() {
        
        view.displayError(viewModel: MoviesListErrorViewModel.defaultError)
    }
}
