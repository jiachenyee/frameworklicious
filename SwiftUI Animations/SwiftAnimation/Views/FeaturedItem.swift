//
//  FeaturedItem.swift
//  SwiftAnimation
//
//  Created by Wahyu Alfandi on 29/06/23.
//

import SwiftUI

struct FeaturedItem: View {
    var course:Course = courses[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            Image(course.logo)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26.0, height: 26.0)
                .cornerRadius(20.0)
                .padding(9)
                .background(.ultraThinMaterial, in:RoundedRectangle(cornerRadius: 20, style:.continuous))
//                .strokeStyle(cornerRadius: 16)
            
            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .lineLimit(1)
            
            Text(course.subtitle.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            
            Text(course.text)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
        .padding(.all, 20.0)
        .padding(.vertical, 20)
        .frame(height: 350.0)
        .background(.ultraThinMaterial, in:RoundedRectangle(cornerRadius: 30, style:.continuous))
        .mask(RoundedRectangle(cornerRadius: 30, style:.continuous))
        
        //        .modifier(StorkeStyle())
//        .strokeStyle()
        .padding(.horizontal, 20.0)
    }
}
