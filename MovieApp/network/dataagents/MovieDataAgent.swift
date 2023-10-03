//
//  MovieDataAgent.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import Foundation
import RxSwift

protocol MovieDataAgent {
    
    func getNowPlayingMovies(page : Int) -> Observable<[MovieVO]>
    
    func getPopularMovies(page : Int) -> Observable<[MovieVO]>
    
    func getTopRatedMovies(page : Int) -> Observable<[MovieVO]>
    
    func getGenres() -> Observable<[GenreVO]>
    
    func getMoviesByGenre(genreId : Int?) -> Observable<[MovieVO]>
    
    func getActors() -> Observable<[ActorVO]>
    
    func getMovieDetails(movieId : Int) -> Observable<MovieVO>
    
    func getCredits(movieId : Int) -> Observable<([ActorVO],[ActorVO])>
    
    func searchMovie(query : String)-> Observable<[MovieVO]>
}

