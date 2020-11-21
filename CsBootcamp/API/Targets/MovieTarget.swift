import Moya

enum MovieTarget: TargetType {
    case popular(Int)

    var baseURL: URL {
        return APIBase.baseUrl
    }

    var path: String {
        switch self {
        case .popular: return "/movie/popular"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestParameters(
            parameters: parameters,
            encoding: URLEncoding.queryString
        )
    }

    var parameters: [String: Any] {
        switch self {
        case let .popular(page): return ["api_key": APISettings.key, "page": page]
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var headers: [String: String]? {
        return nil
    }
}
