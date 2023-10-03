//
//  HorizontalMovieListItemView.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import SwiftUI

struct HorizontalMovieListItemView: View {
    var mMovieList : [MovieVO]?

    var body: some View {
        
        
        if mMovieList?.isEmpty ?? true {
            EmptyView()
        } else {
            ScrollView(.horizontal){
                HStack{
                    
                    ForEach(mMovieList ?? [MovieVO](), id: \.id, content: { movie in
                       NavigationLink(value: movie) {
                            MovieItemView(mMovie: movie)

                        }
                        
                    })
                }
            }
        }
    }
}


#Preview {
    HorizontalMovieListItemView()
}
