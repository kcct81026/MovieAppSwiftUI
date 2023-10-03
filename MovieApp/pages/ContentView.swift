//
//  ContentView.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import SwiftUI
import RxSwift

struct ContentView: View {
    
    //view model
    @StateObject var mViewModel = ConentViewModel()
   

    let disposeBag = DisposeBag()

    
    var body: some View {
        NavigationStack{
            ZStack{
                // back ground
                Color(PRIMARY_COLOR)
                
                VStack(spacing: 0.0){
                    // App Bar
                    AppBarView(isPresented: $mViewModel.isPresented)
                    
                    ScrollView(.vertical){
                        VStack(alignment: .leading, spacing: 0.0){
                            // Banner View
                            BannerSectionView(mNowPlayingMovies: mViewModel.mNowPlayingMovies )
                            
                            // Popular movie list view
                            PopularMovieSectionView(mPopularMovies: mViewModel.mPopularMovies)
                            
                            // Show Time Section
                            CheckMovieShowtimesSectionView()
                            
                            // Spacer
                            Spacer().frame(height: MARGIN_LARGE)
                            
                            // GenreTabLayoutView
                            VStack(spacing : 0.0){
                                GenreTabLayoutView(genres: mViewModel.mGenres,onTapGenre: { genreId in
                                    self.mViewModel.onTapGenre(genreId: genreId)
                                    
                                }).padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
                                HorizontalMovieListItemView(mMovieList: mViewModel.mMoviesByGenre)
                                    .padding([.top, .bottom], MARGIN_MEDIUM_2)
                                    .background(Color(PRIMARY_DARK_COLOR))
                            }
                            
                            //showcase section
                            ShowcaseSectionView(mTopRatedMovies: mViewModel.mTopRatedMovies)
                            
                            //spacer
                            Spacer().frame(height: MARGIN_LARGE)
                            
                            //actors section
                            ActorsOrCreatorsListView(mActors: mViewModel.mActors,label: LABEL_ACTORS,moreLabel: LABEL_MOREACTORS)
                                .padding([.top,.bottom],MARGIN_MEDIUM_3)
                            
                                
                        }
                    }.padding(.top, MARGIN_MEDIUM_3)
                }.padding(.top, MARGIN_XXLARGE)
            }
            .edgesIgnoringSafeArea([.top,.bottom])
            .navigationDestination(for: MovieVO.self) { movie in
                MovieDetailView(movieId: movie.id ?? 0)
            }
            .navigationDestination(isPresented: $mViewModel.isPresented) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct AppBarView: View {
    @Binding var isPresented : Bool

    var body: some View {
        HStack{
            Image(systemName: IC_HORIZONTAL_LINES)
                .resizable()
                .foregroundColor(.white)
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
            Spacer()
            Text(LABEL_DISCOVER)
                .foregroundColor(.white)
                .font(.system(size: TEXT_REGULAR_3X))
                .fontWeight(.bold)
            Spacer()
            Image(systemName: IC_MAGNIFYING_GLASS)
                .resizable()
                .foregroundColor(.white)
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                .onTapGesture {
                    isPresented = true
                }
        }.padding([.leading,.trailing], MARGIN_CARD_MEDIUM_2)
    }
}

struct ShowcaseSectionView: View {
    var mTopRatedMovies : [MovieVO]?
    
    
    var body: some View {
        
        if mTopRatedMovies?.isEmpty ?? true {
            Text("Empty")
        } else {
            VStack(alignment:.leading){
                //title
                HStack{
                    Text(LABEL_SHOWCASE)
                        .foregroundColor(Color(TITLE_LABEL_COLOR))
                        .fontWeight(.bold)
                        .font(.system(size:TEXT_REGULAR_2X))
                    
                    //spacer
                    Spacer()
                    
                    //more showcase
                    Text(LABEL_MORESHOWCASE)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: TEXT_REGULAR_2X))
                        .underline()
                }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
                
                //spacer
                Spacer().frame(height: MARGIN_CARD_MEDIUM_2)
                
                
                ScrollView(.horizontal){
                    HStack(spacing:0.0){
                        ForEach(mTopRatedMovies ?? [],id: \.id){
                            movie in
                          NavigationLink(value: movie) {
                                ShowcaseItemView(mMovie: movie)

                          }
                    
                        }
                    }.padding(.trailing,MARGIN_CARD_MEDIUM_2)
                }
                
            }.padding(.top,MARGIN_MEDIUM_2)
        }
    }
}



struct BannerSectionView: View {
    var mNowPlayingMovies  : [MovieVO]?
    init(mNowPlayingMovies : [MovieVO]?){
        self.mNowPlayingMovies = mNowPlayingMovies
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().currentPageIndicatorTintColor = .yellow
    }
    var body: some View {
        if mNowPlayingMovies?.isEmpty ?? true {
            EmptyView()
        }else {
            TabView{
                ForEach(mNowPlayingMovies ?? [], id:\.id){ movie in
                    NavigationLink(value: movie) {
                        BannerItemView(mMovie: movie)
                            .padding(.bottom, MARGIN_XLARGE)
                           
                    }
                }
            }
            .tabViewStyle(.page)
            .frame(height: BANNER_SECTION_HEIGHT)

        }
    }
}

struct PopularMovieSectionView: View {
    var mPopularMovies : [MovieVO]?

    var body: some View {
        if mPopularMovies?.isEmpty ?? true {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 0.0){
                // Title Label
                Text("BEST POPULAR MOVIES AND SERIES")
                    .foregroundColor(Color(TITLE_LABEL_COLOR))
                    .font(.system(size: TEXT_REGULAR_2X))
                    .fontWeight(.bold)
                    .padding(.leading, MARGIN_CARD_MEDIUM_2)
                
                HorizontalMovieListItemView(mMovieList: mPopularMovies)
            }.padding(.top, MARGIN_CARD_MEDIUM_2)
        }
       
    }
}

struct CheckMovieShowtimesSectionView: View {
    var body: some View {
        ZStack{
            //bg color
            Color(PRIMARY_LIGHT_COLOR).frame(height:200)
            
            //content
            HStack{
                VStack(alignment: .leading){
                    //label
                    
                    Text("Check Movie \n Showtimes")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size:TEXT_HEADING_2X))
                        .padding([.top,.leading],MARGIN_MEDIUM_2)
                    Spacer()
                    
                    //see more label
                    Text("SEE MORE")
                        .foregroundColor(.yellow)
                        .underline()
                        .padding([.leading,.bottom],MARGIN_MEDIUM_2)
                }
                
                Spacer()
                
                Image(systemName: "location.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 40,height: 40)
                    .padding(.trailing,MARGIN_XLARGE)
            }
            
        }.padding(EdgeInsets(top: MARGIN_MEDIUM_2, leading: MARGIN_MEDIUM_2, bottom: 0, trailing: MARGIN_MEDIUM_2))
    }
}
