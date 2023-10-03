//
//  GenreTabLayoutView.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import SwiftUI

struct GenreTabLayoutView: View {
    var genres : [GenreVO]? 
    var onTapGenre: ((Int)->Void)?
    
    var body: some View {
        
        if genres?.isEmpty ?? true {
            Text("Empty")
        }else {
            ScrollView(.horizontal, showsIndicators: false){
                ScrollViewReader{ scrollView in
                    HStack(spacing: MARGIN_MEDIUM_2){
                        ForEach(genres ?? [], id: \.id) { genre in
                            VStack{
                                Text(genre.name ?? "")
                                    .foregroundColor(genre.isSelected ?  Color(.white)  : Color(TITLE_LABEL_COLOR))
                                    .fontWeight(genre.isSelected ? .bold : .medium)
                                    .font(.system(size: TEXT_REGULAR))
                                
                                Rectangle()
                                    .fill(genre.isSelected ? .yellow : .clear)
                                    .frame(height: 1)
                                
                            }
                            .onTapGesture {
                                
                                guard let onTapGenre = self.onTapGenre else {
                                    return
                                }
                                onTapGenre(genre.id ?? 0 )
                               
                                withAnimation {
                                    
                                    scrollView.scrollTo(genre.id,anchor: .center)
                                 
                                }
                                
                            }
//                            .onTapGesture {
//                                genres = genres.map{ iteratedGenre in
//                                    if genre.name == iteratedGenre.name {
//                                        return GenreVO(name: iteratedGenre.name, isSelected: true)
//                                    }
//                                    else{
//                                        return GenreVO(name: iteratedGenre.name, isSelected: false)
//                                    }
//                                }
//                                withAnimation{
//                                    scrollView.scrollTo(genre.name, anchor: .center)
//                                }
//                            }
                        }
                    }
                }
            }
        }
        
      
    }
}

#Preview {
    GenreTabLayoutView()
}



let dummyGenres = [
    GenreVO(name: "ACTION",isSelected: true),
    GenreVO(name: "ADVENTURE",isSelected: false),
    GenreVO(name: "CRIMINAL",isSelected: false),
    GenreVO(name: "DRAMA",isSelected: false),
    GenreVO(name: "COMEDY",isSelected: false),
    GenreVO(name: "HORROR",isSelected: false)

    
    
]


