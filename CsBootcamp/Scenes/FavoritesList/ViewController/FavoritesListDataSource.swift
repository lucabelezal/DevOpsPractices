import UIKit

final class FavoritesListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private weak var tableView: UITableView?
    var didUnfavoriteItemAtIndex: ((Int) -> Void)?
    var searchDidReturnCount: ((String, Int) -> Void)?

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
            enumeratedViewModels.filter { args -> Bool in
                args.element.title.lowercased()
                    .contains(self.searchPredicate.lowercased())
            }
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

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return filteredViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(FavoriteTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        cell.setup(viewModel: filteredViewModels[indexPath.row].1)
        return cell
    }

    func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        return true
    }

    func tableView(_: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Unfavorite") { _, _, _ in
            self.didUnfavoriteItemAtIndex?(self.filteredViewModels[indexPath.row].0)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }

    // MARK: - UITableView Delegate

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return FavoriteTableViewCell.cellHeight
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
