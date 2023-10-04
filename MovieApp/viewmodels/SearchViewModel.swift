//
//  SearchViewModels.swift
//  MovieApp
//
//  Created by AyeSuNaing on 05/10/2023.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject{
    // state
    @Published var query : String = ""
    @Published var results : [MovieVO] = []
    
    // cancellable == disposebag
    var cancellable : AnyCancellable?
    
    // Model
    let mMovieModel  = MovieModelImpl.shared
    
    init(){
        cancellable = $query
            // get latest event in 700 millisecond
            .debounce(for: .milliseconds(700), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                self?.searchMovie(query: text)
            })
    }
    
    private func searchMovie(query: String){
        mMovieModel.searchMovie(query: query){ [weak self] results in
            self?.results = results
            
        } onFailure: { error  in
            debugPrint(error.localizedDescription)
        }
    }
}

