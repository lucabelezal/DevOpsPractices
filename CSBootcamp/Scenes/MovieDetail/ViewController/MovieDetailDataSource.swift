import UIKit

final class MovieDetailDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private unowned let tableView: UITableView

    var viewModel: MovieDetailViewController.ViewModel? {
        didSet {
            tableView.reloadData()
        }
    }

    var favoriteButtonTapped: (() -> Void)?

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        registerCells(in: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    private func registerCells(in _: UITableView) {
        tableView.register(MoviePosterTableViewCell.self)
        tableView.register(MovieTextTableViewCell.self)
        tableView.register(MovieOverviewTableViewCell.self)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        switch indexPath.row {
        case 0:
            let posterCell = tableView.dequeueReusableCell(MoviePosterTableViewCell.self, for: indexPath)
            viewModel.map { viewModel in
                posterCell?.setup(viewModel: viewModel.poster)
                posterCell?.favoriteButtonTapped = self.favoriteButtonTapped
            }
            cell = posterCell
        case 1:
            let releaseDateCell = tableView.dequeueReusableCell(MovieTextTableViewCell.self, for: indexPath)
            viewModel.map { viewModel in
                releaseDateCell?.setup(viewModel: viewModel.releaseDate)
            }
            cell = releaseDateCell
        case 2:
            let genresCell = tableView.dequeueReusableCell(MovieTextTableViewCell.self, for: indexPath)
            viewModel.map { viewModel in
                genresCell?.setup(viewModel: viewModel.genres)
            }
            cell = genresCell
        case 3:
            let overviewCell = tableView.dequeueReusableCell(MovieOverviewTableViewCell.self, for: indexPath)
            viewModel.map { viewModel in
                overviewCell?.setup(viewModel: viewModel.overview)
            }
            cell = overviewCell
        default: cell = nil
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return MoviePosterTableViewCell.cellHeight
        case 1:
            return MovieTextTableViewCell.cellHeight
        case 2:
            return MovieTextTableViewCell.cellHeight
        case 3:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
