@testable
import CsBootcamp
import Foundation

extension MovieDetailViewController.ViewModel: Equatable {
    
    typealias ViewModel = MovieDetailViewController.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return
            lhs.poster == rhs.poster &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.genres == rhs.genres &&
            lhs.overview == rhs.overview
    }
}

extension MoviePosterTableViewCell.ViewModel: Equatable {
    
    typealias ViewModel = MoviePosterTableViewCell.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        
        return
            lhs.imageURL == rhs.imageURL &&
            lhs.title == rhs.title
    
    }
}

extension MovieTextTableViewCell.ViewModel: Equatable {
    
    typealias ViewModel = MovieTextTableViewCell.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        
        return lhs.description == rhs.description
    
    }
}

extension MovieOverviewTableViewCell.ViewModel: Equatable {
    
    typealias ViewModel = MovieOverviewTableViewCell.ViewModel
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
    
        return lhs.overview == rhs.overview
        
    }
}

