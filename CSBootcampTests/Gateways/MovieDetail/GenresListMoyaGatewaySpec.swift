@testable
import CSBootcamp

import Nimble
import OHHTTPStubs
import Quick

class GenresListMoyaGatewaySpec: QuickSpec {
    override func spec() {
        describe("GenresListMoyaGateway") {
            let gateway = GenresListMoyaGateway()

            beforeEach {
                let target = GenreTarget.list
                let host = target.baseURL.host!

                stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                    let path = Bundle(
                        for: GenresListMoyaGatewaySpec.self
                    ).path(forResource: "genres_list", ofType: "json")!
                    return fixture(filePath: path, headers: nil)
                }
            }

            afterEach {
                HTTPStubs.removeAllStubs()
            }

            context("when fetch movie genres") {
                var genres: [Genre]?

                beforeEach {
                    waitUntil(action: { done in
                        gateway.fetchGenres { result in
                            if case let .success(value) = result {
                                genres = value
                            }
                            done()
                        }
                    })
                }

                it("should return a valid GenreList") {
                    expect(genres).toNot(beNil())
                }
            }
        }
    }
}
