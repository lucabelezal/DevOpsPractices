@testable
import CsBootcamp

import Quick
import Nimble
import OHHTTPStubs

class MoviesListMoyaGatewaySpec: QuickSpec {

    override func spec() {

        describe("MoviesListMoyaGateway") {

            let gateway = MoviesListMoyaGateway()

            let page = 1

            beforeEach {

                let target = MovieTarget.popular(page)
                let host = target.baseURL.host!

                stub(condition: isHost(host)) { (request) -> HTTPStubsResponse in

                    let path = Bundle(for: MoviesListMoyaGatewaySpec.self).path(forResource: "movies_list", ofType: "json")!
                    return fixture(filePath: path, headers: nil)
                }
            }

            afterEach {
                HTTPStubs.removeAllStubs()
            }

            context("when fetch movies") {

                var movies: [Movie]?

                beforeEach {
                    waitUntil(action: { done in
                        gateway.fetchMovies(page: page) { result in
                            if case let .success(value) = result {
                                movies = value
                            }
                            done()
                        }
                    })
                }

                it("should return a valid MovieList") {
                    expect(movies).toNot(beNil())
                }
            }
        }
    }
}
