//
//  NetworkImageView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct NetworkImageView: View {
    var imageURL: URL?
    var body: some View {
        AsyncImage(url: imageURL) { data in
            switch data {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
            case .empty, .failure:
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1)
                    .tint(.black)
            @unknown default:
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1)
                    .tint(.black)
            }
        }
    }
}
