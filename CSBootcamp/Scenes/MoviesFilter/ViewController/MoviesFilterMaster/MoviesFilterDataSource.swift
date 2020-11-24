import UIKit

final class MoviesFilterDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let cellReuseIdentifier = "cell"
    private weak var tableView: UITableView?
    var didSelectItem: ((Int) -> Void)?

    var filterOptionTypes: [String] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    var filterOptions: [Int: String] = [:] {
        didSet {
            tableView?.reloadData()
        }
    }

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: UITableViewDataSource conforms

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return filterOptionTypes.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellReuseIdentifier)
        cell.selectionStyle = .none
        cell.detailTextLabel?.textColor = UIColor.Bootcamp.yellow
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        cell.textLabel?.text = filterOptionTypes[indexPath.item]
        cell.detailTextLabel?.text = filterOptions[indexPath.item]

        return cell
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .white
        return footerView
    }

    // MARK: UITableViewDelegate conforms

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(indexPath.item)
    }
}
