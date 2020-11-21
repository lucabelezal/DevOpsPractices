import UIKit

final class MoviesFilterDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedOptionIndex: Int? {
        willSet {
            if let index = selectedOptionIndex,
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) {
                cell.accessoryType = .none
            }
        }
    }
    var didSelectOptionAtIndex: ((Int) -> Void)?
    let options: [String]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    init(options: [String]) {
        self.options = options
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setupViewHierarchy()
        setupConstraints()
        tableView.reloadData()
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            didSelectOptionAtIndex?(indexPath.row)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView
            .topAnchor(equalTo: view.topAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let index = selectedOptionIndex,
            index == indexPath.row {
            cell.accessoryType = .checkmark
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: .zero)
        cell.selectionStyle = .none
        let option = options[indexPath.row]
        cell.textLabel?.text = option

        if let index = selectedOptionIndex,
            indexPath.row == index {
            cell.accessoryType = .checkmark
            self.tableView(tableView, didSelectRowAt: indexPath)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedOptionIndex = indexPath.row
    }
}
