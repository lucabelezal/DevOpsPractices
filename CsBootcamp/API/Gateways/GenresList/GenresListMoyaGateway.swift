//
//  GenresListMoyaGateway.swift
//  CsBootcamp
//
//  Created by Gabriel Preto on 29/03/2018.
//  Copyright © 2018 Bootcampers. All rights reserved.
//

import Moya
import Result

final class GenresListMoyaGateway: GenresListGateway {
    
    private let provider = MoyaProvider<GenreTarget>()
    private let jsonDecoder = JSONDecoder()
    
    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> ()) {
        
        provider.requestDecodable(.list, jsonDecoder: jsonDecoder) { (result: Result<GenreList>) in
            
            let result = result.map { genresList in genresList.genres }
            completion(result)
            
        }
        
    }
    
}

