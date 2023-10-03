//
//  BannerItemView.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import SwiftUI

struct BannerItemView: View {
    var mMovie : MovieVO?

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
            ZStack{
                // Image
                BannerImageView(imageUrl: mMovie?.getBackdropPathTogetherWithBaseUrl() ?? "")

                
                // Gradient
                LinearGradient(colors: [.clear, Color(PRIMARY_COLOR)],
                               startPoint: .top, endPoint: .bottom)
                
                // Play Button
                Image(systemName: IC_PLAY_BUTTON)
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: MARGIN_XXLARGE, height: MARGIN_XXLARGE)
                
            }
            Text(mMovie?.title ?? "")
                .foregroundColor(.white)
                .font(.system(size: TEXT_HEADING_1X))
                .padding(EdgeInsets(top: 0.0, leading: MARGIN_CARD_MEDIUM_2, bottom: MARGIN_MEDIUM_2, trailing: 0.0))
        }
    }
}
struct BannerImageView: View {
    var imageUrl : String = ""
    
    var body: some View  {
        AsyncImage(url: URL(string: imageUrl)!) { phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: BANNER_IMAGE_HEIGHT, maxHeight: BANNER_IMAGE_HEIGHT)
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
    BannerItemView()
}
