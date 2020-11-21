import UIKit.UIImage

struct MoviesListViewModel {
    
    let cellViewModels: [MovieCollectionViewCell.ViewModel]
}

struct MoviesListErrorViewModel {

    private static let defaultErrorMessage = "Um error ocorreu. Por favor, tente novamente."
    private static let defaultEmptySearchFormat = "Sua busca por \"%@\" não resultou em nenhum resultado."
    
    static var defaultError: MoviesListErrorViewModel {
        return MoviesListErrorViewModel(image: #imageLiteral(resourceName: "error_icon"), message: defaultErrorMessage)
    }
    
    static func defaultEmptySearch(predicate: String) -> MoviesListErrorViewModel {
        return MoviesListErrorViewModel(image: #imageLiteral(resourceName: "search_icon"), message: String(format: defaultEmptySearchFormat, predicate))
    }
    
    let image: UIImage
    let message: String
    
}
