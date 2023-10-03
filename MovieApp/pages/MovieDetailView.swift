//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import SwiftUI

struct MovieDetailView: View {
    
    var movieId : Int?
    
    // dismiss
    @Environment(\.presentationMode) var presentationMode
    
    
    @StateObject var mDetailViewModel : MovieDetailViewModel
    
    init( movieId : Int? ){
        _mDetailViewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId : movieId ?? 0 ))
    }
    
    var body: some View {
        ZStack{
            Color(PRIMARY_DARK_COLOR)
            
            if mDetailViewModel.mMovieVO  == nil {
                EmptyView()
            }
            else{
                ScrollView(.vertical){
                    VStack(alignment: .leading, spacing: 0.0){
                        AppBarDetailView(mMovieVO: mDetailViewModel.mMovieVO,onTapBack: {
                            presentationMode.wrappedValue.dismiss()
                        })
                        
                        Spacer().frame(height: MARGIN_MEDIUM_2)
                        
                        TimeGenreAndFavView(mMovieVO: mDetailViewModel.mMovieVO)
                        //storyline
                        StorylineSectionView(mMovieVO: mDetailViewModel.mMovieVO)

                        Spacer().frame(height: MARGIN_MEDIUM_2)

                        //actors
                        ActorsOrCreatorsListView(mActors: mDetailViewModel.mCasts,label: LABEL_DETAILS_ACTOR,moreLabel: "")
                            .padding(EdgeInsets(top: MARGIN_LARGE, leading: MARGIN_CARD_MEDIUM_2, bottom: MARGIN_MEDIUM_2, trailing: MARGIN_CARD_MEDIUM_2))
                            .background(Color(PRIMARY_COLOR))
                            .padding(.top,MARGIN_MEDIUM_2)
                        
                        AboutFilmSectionView(mMovieVO:mDetailViewModel.mMovieVO)

                        
                        //creator
                        
                        ActorsOrCreatorsListView(mActors: mDetailViewModel.mCrews,label:LABEL_CREATORS,moreLabel: LABEL_MORE_CREATORS)
                            .padding(EdgeInsets(top: MARGIN_LARGE, leading: MARGIN_CARD_MEDIUM_2, bottom: MARGIN_MEDIUM_2, trailing: MARGIN_CARD_MEDIUM_2))
                            .background(Color(PRIMARY_COLOR))
                            .padding(.top,MARGIN_MEDIUM_2)
                    }
                }
            }
            
           
        }.edgesIgnoringSafeArea([.top, .bottom])
            .navigationBarBackButtonHidden(true)

    }
}

struct PlayTrailerButtonView: View {
    var body: some View {
        HStack {
            ZStack{
                Circle()
                    .fill(.black.opacity(30))
                    .frame(width: MARGIN_XLARGE,height: MARGIN_XLARGE)
                
                Image(systemName: "play.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: MARGIN_MEDIUM,height: MARGIN_MEDIUM)
            }
            Text("PLAY TRAILER")
                .foregroundColor(.white)
                .font(.system(size: TEXT_REGULAR_2X))
                .fontWeight(.bold)
        }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
            .frame(height: MARGIN_XXLARGE)
            .background(.yellow)
            .cornerRadius(MARGIN_LARGE)
    }
}

struct RateMovieButtonView: View {
    var body: some View {
        HStack{
            Image(systemName: IC_STARFILL)
                .foregroundColor(.yellow)
            
            Text("RATE MOVIE")
                .foregroundColor(.white)
                .font(.system(size:TEXT_REGULAR_2X))
                .fontWeight(.bold)
        }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
            .frame(height: MARGIN_XXLARGE)
            .overlay(RoundedRectangle(cornerRadius: MARGIN_LARGE).stroke(.white))
    }
}

struct StorylineSectionView: View {
    var mMovieVO : MovieVO?
    var body: some View {
        VStack(alignment:.leading,spacing: 0.0){
            Text("STORYLINE")
                .foregroundColor(Color(TITLE_LABEL_COLOR))
                .font(.system(size: TEXT_REGULAR_2X))
                .fontWeight(.bold)
            
            Text(mMovieVO?.overview ?? "")
                .foregroundColor(.white)
                .font(.system(size:TEXT_REGULAR))
                .padding(.top,MARGIN_MEDIUM)
                .lineLimit(5)
            
            //play trailer and rate movie
            HStack {
                PlayTrailerButtonView()
                
                RateMovieButtonView()
                
            }.padding(.top,MARGIN_MEDIUM_2)
            
            
        }.padding(EdgeInsets(top: MARGIN_MEDIUM_3, leading: MARGIN_LARGE, bottom: 0, trailing: MARGIN_LARGE))
    }
}

struct AboutFilmRowView: View {
    var key: String =  ""
    var value: String = ""
    var body: some View {
        HStack(alignment:.top){
            Text("\(key):")
                .foregroundColor(Color(TITLE_LABEL_COLOR))
                .font(.system(size: TEXT_REGULAR))
                .frame(width: UIScreen.main.bounds.width * 0.4,alignment: .leading)
                .fontWeight(.medium)
            
            Text(value)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .font(.system(size: TEXT_REGULAR_2X))
                .lineLimit(5)
            
        }.padding(.top,MARGIN_CARD_MEDIUM_2)
    }
}

struct AboutFilmSectionView: View {
    var mMovieVO : MovieVO?
    var body: some View {
        VStack( alignment: .leading, spacing: 0.0){
            Text("ABOUT FILM")
                .foregroundColor(Color(TITLE_LABEL_COLOR))
                .font(.system(size: TEXT_REGULAR_2X))
                .fontWeight(.bold)
            AboutFilmRowView(key: "Original Title",value: mMovieVO?.title ?? "")
            
            AboutFilmRowView(key: "Type",value: mMovieVO?.getGenresAsCommaSeparatedString() ?? "")
            
            AboutFilmRowView(key: "Production",value: mMovieVO?.getProductionCountryAsCommaSeparatedString() ?? "")
            
            AboutFilmRowView(key: "Premiere", value: mMovieVO?.releaseDate ?? "")
            
            AboutFilmRowView(key: "Description",value: mMovieVO?.overview ?? "")
        }.padding(EdgeInsets(top: MARGIN_MEDIUM_2, leading: MARGIN_LARGE, bottom: 0, trailing: MARGIN_LARGE))
    }
}


struct TimeGenreAndFavView: View {
    var mMovieVO : MovieVO?
    var body: some View {
        HStack(spacing:MARGIN_MEDIUM){
            Image(systemName: "clock")
                .foregroundColor(.yellow)
            
            Text("2h 30mins")
                .foregroundColor(.white)
                .font(.system(size: TEXT_REGULAR))
                .fontWeight(.medium)
            //genres
            ForEach(mMovieVO?.genres?.prefix(2) ?? [],id: \.id){ genre in
                
                Text(genre.name ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: TEXT_REGULAR))
                    .padding(EdgeInsets(top: MARGIN_SMALL, leading: MARGIN_MEDIUM, bottom: MARGIN_SMALL, trailing: MARGIN_MEDIUM))
                    .background(Color(PRIMARY_LIGHT_COLOR))
                    .cornerRadius(MARGIN_CARD_MEDIUM_2)
                
            }
            Spacer()
            Image(systemName: "heart")
                .foregroundColor(.white)
        }.padding([.leading,.trailing],MARGIN_LARGE)
    }
}

struct BackAndSearchButtonView: View {
    var onTapBack: () -> Void
    var body: some View {
        HStack{
            Image(systemName: IC_BACK)
                .resizable()
                .foregroundColor(.gray)
                .frame(width: MARGIN_XLARGE,height: MARGIN_XLARGE)
                .onTapGesture {
                    onTapBack()
                }
            Spacer()
            Image(systemName: IC_MAGNIFYING_GLASS)
                .resizable()
                .foregroundColor(.gray)
                .frame(width: MARGIN_XLARGE,height: MARGIN_XLARGE)
                .onTapGesture {
                    //onTapBack()
                }
            
            
        }
    }
}

struct AppBarDetailView: View {
    var mMovieVO : MovieVO?
    var onTapBack: () -> Void

    var body: some View {
        // App Bar
        ZStack{
            // Image
            MovieDetailsImageView(imageUrl: mMovieVO?.getBackdropPathTogetherWithBaseUrl() ?? "")


            // Gradient
            LinearGradient(colors: [.clear,.clear,Color(PRIMARY_DARK_COLOR)],
                           startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading){
                
                
                //ic back and search
                BackAndSearchButtonView(){
                    self.onTapBack()
                }
                
                Spacer()
                //year and rating
                YearAndRatingView(year: mMovieVO?.releaseDate ?? "", numberOfVotes: mMovieVO?.voteCount ?? 0, rating: mMovieVO?.voteAverage ?? 0)
                
                // movie name
                Text(mMovieVO?.title ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: TEXT_HEADING_1X))
                    .fontWeight(.bold)
                
                
                
                
            }
            .padding(EdgeInsets(top: MARGIN_XXLARGE, leading: MARGIN_LARGE, bottom: MARGIN_CARD_MEDIUM_2, trailing: MARGIN_LARGE))
                
                
            
        }.frame(height: 300)
    }
}


struct MovieDetailsImageView : View {
    var imageUrl : String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)){
            phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .frame(width:UIScreen.main.bounds.width,height: MOVIE_DETAILS_APPBAR_HEIGHT)
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct YearAndRatingView: View {
    var year : String
    var numberOfVotes : Int
    var rating : Double
    var body: some View {
        HStack{
            
            Text(year.prefix(4))
                .font(.system(size: TEXT_REGULAR_2X))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: YEAR_VIEW_WIDTH,height: MARGIN_XLARGE)
                .background(.yellow)
                .cornerRadius(MARGIN_MEDIUM_2)
            
            
            
            Spacer()
            HStack{
                VStack{
                    RatingStarView(maximumRating: 5,currentRating: 2)
                    
                    Text("\(numberOfVotes) VOTES")
                        .foregroundColor(Color(TITLE_LABEL_COLOR))
                        .fontWeight(.bold)
                        .font(.system(size: TEXT_REGULAR))
                    
                    
                }
                
                Text("\(String(format:"%.2f",rating))")
                    .foregroundColor(.white)
                    .font(.system(size: TEXT_BIG))
                
            }
            
            
            
            
        }
    }
}
