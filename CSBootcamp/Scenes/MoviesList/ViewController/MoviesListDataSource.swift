import UIKit

protocol ScrollEventListener: AnyObject {
    func didReachToScrollBottom()
}

final class MoviesListDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private weak var collectionView: UICollectionView?
    private weak var indicatorView: UIActivityIndicatorView?
    weak var scrollEventListener: ScrollEventListener?

    var didSelectItem: ((Int) -> Void)?
    var searchDidReturnCount: ((String, Int) -> Void)?
    var searchPredicate: String = "" {
        didSet {
            if oldValue != searchPredicate {
                collectionView?.reloadData()
            }
        }
    }

    var didPressedItemButton: ((Int) -> Void)?

    var viewModels: [MovieCollectionViewCell.ViewModel] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    private var filteredViewModels: [(Int, MovieCollectionViewCell.ViewModel)] {
        let enumeratedViewModels = self.viewModels.enumerated().map { $0 }
        let viewModels = searchPredicate.isEmpty ?
            enumeratedViewModels :
            enumeratedViewModels.filter { args in
                args.element.title.lowercased().contains(self.searchPredicate.lowercased())
            }

        searchDidReturnCount?(searchPredicate, viewModels.count)

        return viewModels
    }

    init(collectionView: UICollectionView, indicatorView: UIActivityIndicatorView) {
        self.collectionView = collectionView
        self.indicatorView = indicatorView
        super.init()
        registerCells(in: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

    private func registerCells(in collectionView: UICollectionView) {
        collectionView.register(MovieCollectionViewCell.self)
        collectionView.register(ActivityIndicatorFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
    }

    private func favoriteButtonTapped(sender: AnyObject) {
        let buttonPosition = sender.convert(CGPoint.zero, to: collectionView)
        let indexPath = collectionView?.indexPathForItem(at: buttonPosition)

        if let indexPath = indexPath {
            didPressedItemButton?(indexPath.item)
        }
    }

    // MARK: UICollectionViewDataSource conforms

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return filteredViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(MovieCollectionViewCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(viewModel: filteredViewModels[indexPath.item].1)

        cell.didFavoriteButtonPressed = { [weak self] button in
            self?.favoriteButtonTapped(sender: button)
        }

        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout conforms

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return MovieCollectionViewCell.cellSize
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = filteredViewModels[indexPath.item].0
        didSelectItem?(index)
    }

    // MARK: Loading footer

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:

            guard let footer = collectionView.dequeueReusableSupplementaryView(
                ActivityIndicatorFooterView.self,
                ofKind: UICollectionView.elementKindSectionFooter, for: indexPath
            ) else {
                return UICollectionReusableView()
            }

            if let indicatorView = indicatorView {
                footer.setup(activityIndicator: indicatorView)
            }
            return footer
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForFooterInSection _: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }

    // MARK: Pagination

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellBuffer: CGFloat = 1
        let cellHeight: CGFloat = MovieCollectionViewCell.cellSize.height

        let bottomOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let heightBuffer = cellBuffer * cellHeight
        let scrollPosition = scrollView.contentOffset.y

        if scrollPosition > bottomOffset - heightBuffer {
            scrollEventListener?.didReachToScrollBottom()
        }
    }
}
