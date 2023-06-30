//
//  CourseVieww.swift
//  SwiftAnimation
//
//  Created by Wahyu Alfandi on 29/06/23.
//

import SwiftUI

struct CourseView: View {
    var namespace: Namespace.ID
    var course: Course
    @Binding var show: Bool
    
    var body: some View {
        
        ZStack {
            ScrollView {
                cover
            }.background(Color("Background"))
            .ignoresSafeArea()
            
            Button{
                withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(20)
            }.ignoresSafeArea()
        }
    }
    
    var cover: some View {
        VStack{
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        .background(
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
        )
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
        )
        .mask{
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        }
        .overlay{
            VStack(alignment: .leading, spacing: 12){
                Text(course.title)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(course.subtitle.uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
                
                Text(course.text)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
                
                Divider()
                
                HStack{
                    Image("Avatar Default")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .cornerRadius(10)
                        .padding(8)
                        .background(.ultraThinMaterial, in : RoundedRectangle(cornerRadius: 18.0, style: .continuous))
//                    .strokeStyle(cornerRadius: 18)
                    Text("Taught by Apple Dev Academy")
                        .font(.footnote)
                }
                
                
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
            )
            .offset(y: 250)
            .padding(20)
            
        }
    }
}

struct CourseVieww_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseView(namespace: namespace, course: courses[0], show: .constant(true))
    }
}
