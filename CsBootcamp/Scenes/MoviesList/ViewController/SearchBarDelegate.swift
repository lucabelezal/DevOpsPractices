import UIKit

class SearchBarDelegate: NSObject, UISearchBarDelegate {
    var searchBarIsActive = false
    var textDidChange: ((String) -> Void)?

    init(searchBar: UISearchBar) {
        super.init()
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarIsActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBarIsActive = false
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text.map { text in
            self.textDidChange?(text)
        }
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        textDidChange?("")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textDidChange?(searchText)
    }
}
