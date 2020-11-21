import Moya

enum GenreTarget: TargetType {
    case list

    var baseURL: URL {
        return APIBase.baseUrl
    }

    var path: String {
        switch self {
        case .list: return "/genre/movie/list"
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
        return ["api_key": APISettings.key]
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var headers: [String: String]? {
        return nil
    }
}
