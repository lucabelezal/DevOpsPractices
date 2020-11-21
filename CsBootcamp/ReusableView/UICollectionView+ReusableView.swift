import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<T: UICollectionReusableView>(_ viewType: T.Type, forSupplementaryViewOfKind elementKind: String) {
        register(viewType, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ viewType: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath) as? T
    }
}
