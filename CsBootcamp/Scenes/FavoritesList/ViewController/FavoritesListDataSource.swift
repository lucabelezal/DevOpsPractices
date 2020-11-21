import UIKit

final class FavoritesListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    private weak var tableView: UITableView?
    var didUnfavoriteItemAtIndex: ((Int) -> ())?
    var searchDidReturnCount: ((String, Int) -> ())?
    
    var searchPredicate: String = "" {
        didSet {
            if oldValue != searchPredicate {
                tableView?.reloadData()
            }
        }
    }

    var viewModels: [FavoriteTableViewCell.ViewModel] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    var filteredViewModels: [(Int, FavoriteTableViewCell.ViewModel)] {

        let enumeratedViewModels = self.viewModels.enumerated().map { $0 }

        let viewModels = searchPredicate.isEmpty ?
            enumeratedViewModels :
            enumeratedViewModels.filter({ args -> Bool in
                args.element.title.lowercased()
                    .contains(self.searchPredicate.lowercased())
            })
        searchDidReturnCount?(searchPredicate, viewModels.count)

        return viewModels
    }

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()

        registerCells(in: tableView)

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func registerCells(in tableView: UITableView) {

        tableView.register(FavoriteTableViewCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(FavoriteTableViewCell.self, for: indexPath)!
        cell.setup(viewModel: filteredViewModels[indexPath.row].1)

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Unfavorite") {  (contextualAction, view, boolValue) in
            self.didUnfavoriteItemAtIndex?(self.filteredViewModels[indexPath.row].0)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }

    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return FavoriteTableViewCell.cellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return CGFloat.leastNonzeroMagnitude
    }
}
