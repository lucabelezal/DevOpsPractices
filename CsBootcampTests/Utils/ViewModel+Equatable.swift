@testable
import CsBootcamp

extension MovieDetailViewController.ViewModel: Equatable {
    
    public typealias ViewModel = MovieDetailViewController.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return
            lhs.poster == rhs.poster &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.genres == rhs.genres &&
            lhs.overview == rhs.overview
    }
}

extension MoviePosterTableViewCell.ViewModel: Equatable {
    
    public typealias ViewModel = MoviePosterTableViewCell.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return
            lhs.imageURL == rhs.imageURL &&
            lhs.title == rhs.title
    }
}

extension MovieTextTableViewCell.ViewModel: Equatable {
    
    public typealias ViewModel = MovieTextTableViewCell.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return lhs.description == rhs.description
    }
}

extension MovieOverviewTableViewCell.ViewModel: Equatable {
    
    public typealias ViewModel = MovieOverviewTableViewCell.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return lhs.overview == rhs.overview
    }
}

