//
//  GenresListGateway.swift
//  CsBootcamp
//
//  Created by Gabriel Preto on 29/03/2018.
//  Copyright © 2018 Bootcampers. All rights reserved.
//

protocol GenresListGateway {
    
    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> ())
}
