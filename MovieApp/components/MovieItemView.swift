//
//  MovieItemView.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import SwiftUI

struct MovieItemView: View {
    var mMovie : MovieVO?

    var body: some View {
        VStack(alignment: .leading){
            
            // Image
            MovieListItemImageView(imageUrl: mMovie?.getPosterPathTogetherWithBaseUrl() ?? "")
                
            
            // Text
            Text(mMovie?.title ?? "")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: TEXT_REGULAR_2X))
                .lineLimit(1)
                .padding(.top, MARGIN_MEDIUM)
            
            // Rating info
            HStack{
                // Rating text
                Text("9.5")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: TEXT_REGULAR_2X))
                
                // Rating Star
                RatingStarView(maximumRating: 5, currentRating: 3)
            }.padding(.top, MARGIN_MEDIUM)
        }
        .frame(width: 150)
        .padding([.leading, .top], MARGIN_CARD_MEDIUM_2)
    }
}


struct MovieListItemImageView : View {
    var imageUrl : String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)!){
            phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150,height: 180)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
        }
    }
}


#Preview {
    MovieItemView()
}
