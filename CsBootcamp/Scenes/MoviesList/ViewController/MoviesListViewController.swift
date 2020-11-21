import UIKit

final class MoviesListViewController: UIViewController, MoviesListView, ShowMovieDetailNavigator, ScrollEventListener {
    private var page = 1
    private var state: State = .list([])

    lazy var errorView: MovieListErrorView = {
        let errorView = MovieListErrorView(frame: .zero, iconDiameterRatio: 0.5)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true

        return errorView
    }()

    lazy var emptySearchView: MovieListErrorView = {
        let emptySearchView = MovieListErrorView(frame: .zero, iconDiameterRatio: 0.3)
        emptySearchView.translatesAutoresizingMaskIntoConstraints = false
        emptySearchView.isHidden = true

        return emptySearchView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndicator
    }()

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()

        let margin = CGFloat(16).proportionalToWidth
        flowLayout.sectionInset = UIEdgeInsets(
            top: margin,
            left: margin,
            bottom: margin,
            right: margin
        )

        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag

        return collectionView
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor.Bootcamp.yellow
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.Bootcamp.yellow.cgColor
        searchBar.setTextBackgroundColor(UIColor.Bootcamp.darkYellow)
        searchBar.placeholder = "Search"

        return searchBar
    }()

    // MARK: Scene components

    lazy var dataSource: MoviesListDataSource = {
        let dataSource = MoviesListDataSource(collectionView: collectionView, indicatorView: activityIndicator)
        dataSource.didSelectItem = self.movieSelected
        dataSource.didPressedItemButton = self.toggleFavoriteMovie

        return dataSource
    }()

    lazy var searchBarDelegate: SearchBarDelegate = {
        let searchBarDelegate = SearchBarDelegate(searchBar: searchBar)
        return searchBarDelegate
    }()

    var listInteractor: MoviesListInteractorType?
    var showDetailInteractor: MoviesListShowDetailInteractorType?
    var favoriteInteractor: MovieListFavoriteInteractorType?

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        return nil
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "Movies"
        dataSource.scrollEventListener = self
        tabBarItem = UITabBarItem(title: "Movies", image: #imageLiteral(resourceName: "list_icon"), tag: 0)
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()

        searchBarDelegate.textDidChange = setSearchPredicate
        dataSource.searchDidReturnCount = searchResults
        super.viewDidLoad()

        fetchMovies(from: page)
    }

    override func viewWillAppear(_ animated: Bool) {
        listInteractor?.reloadMovies()
        super.viewWillAppear(animated)
    }

    func didReachToScrollBottom() {
        let isSearching = searchBarDelegate.searchBarIsActive
        if !isSearching,
            case .list = state {
            page += 1
            fetchMovies(from: page)
        }
    }

    private func fetchMovies(from page: Int) {
        setup(state: .loading)
        listInteractor?.fetchMovies(from: page)
    }

    private func toggleFavoriteMovie(at index: Int) {
        let movie = listInteractor?.movie(at: index)

        if let movie = movie {
            favoriteInteractor?.toggleMovieFavorite(movie)
        }
    }

    private func movieSelected(at index: Int) {
        if let movie = listInteractor?.movie(at: index) {
            showDetailInteractor?.showDetail(forMovie: movie)
        }
    }

    // MARK: Filter

    private func setSearchPredicate(_ predicate: String) {
        dataSource.searchPredicate = predicate
    }

    private func searchResults(from predicate: String, didReturnCount count: Int) {
        let isEmptySearch = count == 0 && !predicate.isEmpty
        emptySearchView.isHidden = !isEmptySearch
        if isEmptySearch {
            emptySearchView.setup(viewModel: MoviesListErrorViewModel.defaultEmptySearch(predicate: predicate))
        }
    }

    // MARK: MoviesListView conforms

    func displayMovies(viewModel: MoviesListViewModel) {
        setup(state: .list(viewModel.cellViewModels))
    }

    func displayError(viewModel: MoviesListErrorViewModel) {
        setup(state: .error(viewModel))
    }

    // MARK: ShowMovieDetailNavigator conforms

    func navigate(toDetailOf movie: Movie) {
        let vc = MovieDetailSceneFactory.make(with: movie)
        show(vc, sender: nil)
    }

    // MARK: Setups

    private func setup(state: State) {
        self.state = state
        if case let .list(viewModels) = state {
            dataSource.viewModels = viewModels
        } else if case let .error(viewModel) = state {
            errorView.setup(viewModel: viewModel)
        }

        collectionView.isHidden = state.hidesCollectionView
        activityIndicator.setAnimating(state.animatesActivityIndicator)
        errorView.isHidden = state.hidesErrorView
        searchBar.isUserInteractionEnabled = state.enablesSearchBar
    }

    private func setupViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        view.addSubview(emptySearchView)
    }

    private func setupConstraints() {
        searchBar
            .topAnchor(equalTo: view.topAnchor)
            .heightAnchor(equalTo: 48.0)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)

        collectionView
            .topAnchor(equalTo: searchBar.bottomAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)

        activityIndicator
            .centerXAnchor(equalTo: view.centerXAnchor)
            .centerYAnchor(equalTo: view.centerYAnchor)

        errorView
            .topAnchor(equalTo: searchBar.bottomAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)

        emptySearchView
            .topAnchor(equalTo: searchBar.bottomAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
    }
}

extension MoviesListViewController {
    enum State {
        case list([MovieCollectionViewCell.ViewModel])
        case loading
        case error(MoviesListErrorViewModel)

        var hidesCollectionView: Bool {
            switch self {
            case .list, .loading: return false
            case .error: return true
            }
        }

        var hidesErrorView: Bool {
            switch self {
            case .error: return false
            case .list, .loading: return true
            }
        }

        var animatesActivityIndicator: Bool {
            switch self {
            case .loading: return true
            case .list, .error: return false
            }
        }

        var enablesSearchBar: Bool {
            switch self {
            case .list: return true
            case .loading, .error: return false
            }
        }
    }
}
