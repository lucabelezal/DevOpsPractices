@testable
import CsBootcamp

import CoreData
import Nimble
import Quick

final class FavoriteMoviesListCoreDataGatewaySpec: QuickSpec {
    override func spec() {
        describe("FavoriteMoviesListCoreDataGatewaySpec") {
            context("when it is initialized") {
                var favoriteMoviesListCoreDataGateway: FavoriteMoviesListCoreDataGateway!

                beforeEach {
                    let coreDataStack = InMemoryCoreDataStack()
                    favoriteMoviesListCoreDataGateway = FavoriteMoviesListCoreDataGateway(coreDataStack: coreDataStack)
                }

                let movie = Movie(id: 0, genreIds: [], title: "", overview: "", releaseDate: Date(), posterPath: "")
                context("and isMovieFavorite is called") {
                    var result: Result<Bool>!
                    beforeEach {
                        result = favoriteMoviesListCoreDataGateway.isMovieFavorite(movie)
                    }

                    it("should return false") {
                        expect(result.value) == false
                    }
                }

                context("and fetchMovies is called") {
                    var result: Result<[Movie]>!
                    beforeEach {
                        result = favoriteMoviesListCoreDataGateway.fetchMovies()
                    }

                    it("should return empty list") {
                        expect(result.value) == []
                    }
                }

                context("and setMovieFavorite true is called") {
                    beforeEach {
                        favoriteMoviesListCoreDataGateway.setMovie(movie, favorite: true)
                    }

                    context("and isMovieFavorite is called") {
                        var result: Result<Bool>!
                        beforeEach {
                            result = favoriteMoviesListCoreDataGateway.isMovieFavorite(movie)
                        }

                        it("should return true") {
                            expect(result.value) == true
                        }
                    }

                    context("and fetchMovies is called") {
                        var result: Result<[Movie]>!
                        beforeEach {
                            result = favoriteMoviesListCoreDataGateway.fetchMovies()
                        }
                        it("should return added movies") {
                            expect(result.value) == [movie]
                        }
                    }

                    context("and setMovieFavorite false is called") {
                        beforeEach {
                            favoriteMoviesListCoreDataGateway.setMovie(movie, favorite: false)
                        }

                        context("and isMovieFavorite is called") {
                            var result: Result<Bool>!
                            beforeEach {
                                result = favoriteMoviesListCoreDataGateway.isMovieFavorite(movie)
                            }

                            it("should return false") {
                                expect(result.value) == false
                            }
                        }

                        context("and fetchMovies is called") {
                            var result: Result<[Movie]>!
                            beforeEach {
                                result = favoriteMoviesListCoreDataGateway.fetchMovies()
                            }
                            it("should return empty list") {
                                expect(result.value) == []
                            }
                        }
                    }
                }

                context("and toggleMovieFavorite is called") {
                    var result: Result<Bool>!

                    beforeEach {
                        result = favoriteMoviesListCoreDataGateway.toggleMovieFavorite(movie)
                    }

                    it("should return true") {
                        expect(result.value) == true
                    }

                    context("and isMovieFavorite is called") {
                        var result: Result<Bool>!
                        beforeEach {
                            result = favoriteMoviesListCoreDataGateway.isMovieFavorite(movie)
                        }

                        it("should return true") {
                            expect(result.value) == true
                        }
                    }

                    context("and fetchMovies is called") {
                        var result: Result<[Movie]>!
                        beforeEach {
                            result = favoriteMoviesListCoreDataGateway.fetchMovies()
                        }
                        it("should return added movies") {
                            expect(result.value) == [movie]
                        }
                    }

                    context("and toggleMovieFavorite is called") {
                        var result: Result<Bool>!

                        beforeEach {
                            result = favoriteMoviesListCoreDataGateway.toggleMovieFavorite(movie)
                        }

                        it("should return false") {
                            expect(result.value) == false
                        }

                        context("and isMovieFavorite is called") {
                            var result: Result<Bool>!
                            beforeEach {
                                result = favoriteMoviesListCoreDataGateway.isMovieFavorite(movie)
                            }

                            it("should return false") {
                                expect(result.value) == false
                            }
                        }

                        context("and fetchMovies is called") {
                            var result: Result<[Movie]>!
                            beforeEach {
                                result = favoriteMoviesListCoreDataGateway.fetchMovies()
                            }
                            it("should return empty list") {
                                expect(result.value) == []
                            }
                        }
                    }
                }
            }
        }
    }
}
