import UIKit

final class FavoritesListViewController: UIViewController, FavoritesListView {
    
    let movieFilter = MovieFilterTransaction()
    
    var removeFilterButtonTopConstraint: NSLayoutConstraint?
    
    lazy var removeFilterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.Bootcamp.darkBlue
        button.setTitleColor(UIColor.Bootcamp.yellow, for: .normal)
        button.setTitle("Remove Filter", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeFilterAction), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.estimatedSectionHeaderHeight = 1
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.Bootcamp.yellow.cgColor
        searchBar.barTintColor = UIColor.Bootcamp.yellow
        searchBar.setTextBackgroundColor(UIColor.Bootcamp.darkYellow)
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    lazy var searchBarDelegate: SearchBarDelegate = {
        let searchBarDelegate = SearchBarDelegate(searchBar: searchBar)
        return searchBarDelegate
    }()
    
    var interactor: FavoritesListInteractorType?
    
    lazy var dataSource: FavoritesListDataSource = {
        let dataSource = FavoritesListDataSource(tableView: tableView)
        dataSource.didUnfavoriteItemAtIndex = unfavoriteMovie
        return dataSource
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Favorites"
        tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorite_empty_icon"), tag: 1)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDelegate.textDidChange = setSearchPredicate
        view.backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()
        let rightBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "filter_icon"),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonAction)
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateRemoveFilterButtonLayout()
    }
    
    func unfavoriteMovie(at index: Int) {
        interactor?.removeFavorite(at: index)
    }
    
    @objc
    func rightBarButtonAction(sender: UIBarButtonItem) {
        let moviesFilterViewController = MoviesFilterSceneFactory.make(movieFilter: movieFilter)
        show(moviesFilterViewController, sender: nil)
    }
    
    private func fetchFavorites() {
        interactor?.fetchFavorites(filteringWithGenre: movieFilter.genreFilter, releaseYear: movieFilter.releaseYearFilter)
    }

    @objc
    private func removeFilterAction(sender: UIButton) {
        movieFilter.clearFilter()
        movieFilter.commit()
        updateRemoveFilterButtonLayout()
        fetchFavorites()
    }
    
    private func updateRemoveFilterButtonLayout() {
        let constant = movieFilter.hasFilter ?
            0 : -searchBar.bounds.height
        removeFilterButtonTopConstraint?.constant = constant
    }
    
    private func setSearchPredicate(_ predicate: String) {
        dataSource.searchPredicate = predicate
    }
    
    // MARK: FavoritesListView Protocol
    
    func displayFavorites(viewModels: [FavoriteTableViewCell.ViewModel]) {
        
        setup(state: .list(viewModels))
    }

    // MARK: Setups
    
    private func setup(state: State) {
        if case let .list(viewModels) = state {
            dataSource.viewModels = viewModels
        }
    }
    
    private func setupViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.insertSubview(removeFilterButton, belowSubview: searchBar)
    }
    
    private func setupConstraints() {
        
        let viewHeights = CGFloat(48)
        
        searchBar
            .topAnchor(equalTo: view.topAnchor)
            .heightAnchor(equalTo: viewHeights)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
        
        removeFilterButton
            .heightAnchor(equalTo: viewHeights)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
        
        removeFilterButtonTopConstraint = removeFilterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: -viewHeights)
        removeFilterButtonTopConstraint!.isActive = true
        
        tableView
            .topAnchor(equalTo: removeFilterButton.bottomAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
    }
}

extension FavoritesListViewController {
    enum State {
        case list([FavoriteTableViewCell.ViewModel])
    }
}
