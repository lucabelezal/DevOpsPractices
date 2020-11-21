import UIKit

protocol MoviesFilterInteractorType: AnyObject {
    func fetchDetailOptionTypes(movieFilter: MovieFilterTransaction)
    func showFilterDetail(at index: Int)
    func genre(at index: Int) -> Genre
    func releaseYear(at index: Int) -> Int
}

class MoviesFilterViewController: UIViewController, FilterView {
    let movieFilter: MovieFilterTransaction

    var updateFilter: (([String]) -> (Int) -> Void) = { _ in { _ in } }
    private var presentingOptionsIndex = 0
    private var curentSelectedOptionIndexes: [Int: Int] = [:]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var applyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.Bootcamp.yellow
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyFilterAction), for: .touchUpInside)
        return button
    }()

    lazy var dataSource: MoviesFilterDataSource = {
        let dataSource = MoviesFilterDataSource(tableView: tableView)
        return dataSource
    }()

    var moviesFilterInteractor: MoviesFilterInteractorType?

    init(movieFilter: MovieFilterTransaction) {
        self.movieFilter = movieFilter

        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filter"
        view.backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()

        dataSource.didSelectItem = self.filterSelected
        moviesFilterInteractor?.fetchDetailOptionTypes(movieFilter: movieFilter)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieFilter.rollback()
    }

    private func filterSelected(at index: Int) {
        presentingOptionsIndex = index
        setUpdateFilter(withIndex: index)
        moviesFilterInteractor?.showFilterDetail(at: index)
    }

    func displayFilterOptions(types: [String], options: [Int: String]) {
        dataSource.filterOptionTypes = types
        dataSource.filterOptions = options
    }

    func displayFilterDetail(viewModels: [String]) {
        navigateToDetailOfFilter(options: viewModels)
    }

    func navigateToDetailOfFilter(options: [String]) {
        let currentSelectedOptionIndex: Int?
        if presentingOptionsIndex == 0 {
            currentSelectedOptionIndex = movieFilter.releaseYearFilterIndex
        } else if presentingOptionsIndex == 1 {
            currentSelectedOptionIndex = movieFilter.genreFilterIndex
        } else {
            currentSelectedOptionIndex = nil
        }

        let vc = MoviesFilterDetailViewControllerFactory.make(
            withOptions: options,
            currentSelectedOptionIndex: currentSelectedOptionIndex,
            didSelectOptionAtIndex: updateFilter(options)
        )
        show(vc, sender: nil)
    }

    @objc private func applyFilterAction(sender: UIButton) {
        movieFilter.commit()
        navigationController?.popViewController(animated: true)
    }

    private func setUpdateFilter(withIndex index: Int) {
        updateFilter = { options in { optionIndex in
                let option = options[optionIndex]
                self.dataSource.filterOptions[index] = option

                if index == 0 {
                    self.setReleaseYearFilter(at: optionIndex)
                } else if index == 1 {
                    self.setGenreFilter(at: optionIndex)
                }
            }
        }
    }

    private func setReleaseYearFilter(at index: Int) {
        movieFilter.releaseYearFilterIndex = index
        movieFilter.releaseYearFilter = moviesFilterInteractor?.releaseYear(at: index)
    }

    private func setGenreFilter(at index: Int) {
        movieFilter.genreFilterIndex = index
        movieFilter.genreFilter = moviesFilterInteractor?.genre(at: index)
    }

    private func setupViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(applyButton)
    }

    private func setupConstraints() {
        tableView
            .topAnchor(equalTo: view.topAnchor)
            .bottomAnchor(equalTo: applyButton.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)

        applyButton
            .bottomAnchor(equalTo: view.bottomAnchor, constant: -16)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -32)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 32)
            .heightAnchor(equalTo: 44)
    }
}
