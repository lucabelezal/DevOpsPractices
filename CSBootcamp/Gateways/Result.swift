enum Result<T> {
    case success(T)
    case failure(Error)

    var value: T? {
        if case let .success(value) = self {
            return value
        } else {
            return nil
        }
    }

    func map<U>(_ transform: (T) throws -> (U)) rethrows -> Result<U> {
        switch self {
        case let .success(value):
            let transformedValue = try transform(value)
            return Result<U>.success(transformedValue)

        case let .failure(error):
            return Result<U>.failure(error)
        }
    }
}
