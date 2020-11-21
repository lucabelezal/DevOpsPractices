@testable
import CsBootcamp

import CoreData
import Nimble
import Quick

final class GenresCacheCoreDataGatewaySpec: QuickSpec {
    override func spec() {
        describe("GenresCacheCoreDataGateway") {
            context("when it is initialized") {
                var coreDataStack: InMemoryCoreDataStack!
                var genresCacheCoreDataGateway: GenresCacheCoreDataGateway!

                beforeEach {
                    coreDataStack = InMemoryCoreDataStack()
                    genresCacheCoreDataGateway = GenresCacheCoreDataGateway(coreDataStack: coreDataStack)
                }

                context("and add genres is called") {
                    let addedGenres = (0 ..< 3).map { i in
                        Genre(id: i, name: "name\(i)")
                    }

                    beforeEach {
                        waitUntil { done in
                            genresCacheCoreDataGateway.addGenres(addedGenres) { _ in
                                done()
                            }
                        }
                    }

                    context("and fetch genres is called") {
                        var fetchedGenres: [Genre]!

                        beforeEach {
                            let ids = addedGenres.map { $0.id }
                            genresCacheCoreDataGateway.fetchGenres(withIds: ids) { result in
                                fetchedGenres = result.value
                            }
                        }

                        it("should return added genres") {
                            expect(fetchedGenres).to(contain(addedGenres))
                        }
                    }
                }
            }
        }
    }
}
