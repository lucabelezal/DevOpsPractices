@testable
import CsBootcamp

import Quick
import Nimble

class MovieSpec: QuickSpec {
    
    override func spec() {
        
        describe("Movie") {
            
            context("when initialized from json") {
                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let bundle = Bundle(for: MovieSpec.self)
                
                context("when json is valid") {
                    
                    let fixtureUrl = bundle.url(forResource: "movie_valid", withExtension: "json")!
                    let jsonData = try! Data(contentsOf: fixtureUrl)
                    
                    it("should parse correctly") {
                        expect {
                            try decoder.decode(Movie.self, from: jsonData)
                        }.notTo(throwError())
                    }
                }
                
                context("when json is invalid") {
                    
                    let fixtureUrl = bundle.url(forResource: "movie_invalid", withExtension: "json")!
                    let jsonData = try! Data(contentsOf: fixtureUrl)
                    
                    it("should throw error") {
                        
                        expect {
                            try decoder.decode(Movie.self, from: jsonData)
                        }.to(throwError())
                    }
                }
            }
        }
    }
}
