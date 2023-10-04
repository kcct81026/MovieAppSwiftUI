//
//  MovieModelImpl.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import Foundation
import RxSwift

class MovieModelImpl : MovieModel{
    
    static let shared = MovieModelImpl()
    
    private init() {}
    
    //data agent
    let mDataAgent : MovieDataAgent = MovieDataAgentImpl.shared
    
    var disposeBag = DisposeBag()
    
    func getNowPlayingMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getNowPlayingMovies(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { nowPlayingMovies in
                // save to db
                //                 self.mMovieDao.saveMovies(movies: nowPlayingMovies, for: MOVIE_TYPE_NOW_PLAYING)

            }, onError: { error in
                onFailure(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getPopularMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getPopularMovies(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { popularMovies in
                //save to db
                //self.mMovieDao.saveMovies(movies: popularMovies, for: MOVIE_TYPE_POPULAR)
            }, onError: { error in
                onFailure(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getTopRatedMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getTopRatedMovies(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                topratedMovies in
               
                //save to db
                //self.mMovieDao.saveMovies(movies: topratedMovies, for: MOVIE_TYPE_TOP_RATED)
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    func getGenres(onSuccess: @escaping ([GenreVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getGenres()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                genres in
                onSuccess(genres)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
        
    }
    
    
    
    func getMoviesByGenre(genreId: Int?, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
     
        
        mDataAgent.getMoviesByGenre(genreId: genreId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                moviesByGenres in
                onSuccess(moviesByGenres)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
            
    }
    
    func getActors(onSuccess: @escaping ([ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getActors()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                actors in
                onSuccess(actors)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    func getMovieDetails(movieId: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (Error) -> Void) {
      
        
        mDataAgent.getMovieDetails(movieId: movieId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                movieDetails in
                onSuccess(movieDetails)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    func getCredits(movieId: Int, onSuccess: @escaping ([ActorVO], [ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        
        mDataAgent.getCredits(movieId: movieId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                (actor,crew) in
                onSuccess(actor,crew)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
   
    func searchMovie(query: String, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.searchMovie(query: query)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { movies in
                onSuccess(movies)
            }, onError: { error in
                onFailure(error)
            })
            .disposed(by: disposeBag)
    }
    
    //database
    func getAllMoviesFromDatabase() -> [MovieVO] {
       return []
    }
    
    func getMovieByIdFromDatabase(id: Int) -> MovieVO? {
        return MovieVO()
    }
    
    func getNowPlayingMoviesFromDatabase() -> [MovieVO] {
        return []
    }
    
    func getPopularMoviesFromDatabase() -> [MovieVO] {
        return []

    }
    
    func getTopRatedMoviesFromDatabase() -> [MovieVO] {
        return []

    }
//    func getAllMoviesFromDatabase() -> [MovieVO] {
//       return mMovieDao.getAllMovies()
//    }
//    
//    func getMovieByIdFromDatabase(id: Int) -> MovieVO? {
//        return mMovieDao.getMovieById(movieId: id)
//    }
//    
//    func getNowPlayingMoviesFromDatabase() -> [MovieVO] {
//        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_NOW_PLAYING)
//    }
//    
//    func getPopularMoviesFromDatabase() -> [MovieVO] {
//        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_POPULAR)
//
//    }
//    
//    func getTopRatedMoviesFromDatabase() -> [MovieVO] {
//        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_TOP_RATED)
//
//    }
    
    //database with observable
    func getNowPlayingMoviesFromDatabaseObservable() -> Observable<[MovieVO]> {
        return mDataAgent.getNowPlayingMovies(page: 1)
            
    }
    
    func getPopularMoviesFromDatabaseObservable() -> Observable<[MovieVO]> {
        return mDataAgent.getPopularMovies(page: 1)
    }
    
    func getTopRatedMoviesFromDatabaseObservable() -> Observable<[MovieVO]> {
        return mDataAgent.getPopularMovies(page: 1)
    }
//    func getNowPlayingMoviesFromDatabaseObservable() -> Observable<[MovieVO]> {
//        return mMovieDao.getMoviesByTypeObservable(type: MOVIE_TYPE_NOW_PLAYING)
//    }
//    
//    func getPopularMoviesFromDatabaseObservable() -> Observable<[MovieVO]> {
//        return mMovieDao.getMoviesByTypeObservable(type: MOVIE_TYPE_POPULAR)
//    }
//    
//    func getTopRatedMoviesFromDatabaseObservable() -> Observable<[MovieVO]> {
//        return mMovieDao.getMoviesByTypeObservable(type: MOVIE_TYPE_TOP_RATED)
//    }
    
    
}
