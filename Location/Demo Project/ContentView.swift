//
//  ContentView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import SwiftUI
import CoreLocation
import FrameworkliciousCore

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var isPresented: Bool = false
    @Environment(\.presentationMode) private var presentationMode
    var framework: Framework
    
    var body: some View {
        NavigationStack {
            ForEach(viewModel.nearbyBeacons, id: \.minor.intValue) { beacon in
                if let framework = Framework(from: beacon) {
                    List{
                        Button {
                            self.isPresented = true
                        } label: {
                            ZStack{
                                Image(systemName: framework.icon)
                                    .foregroundColor(.white.opacity(0.25))
                                    .font(.system(size: 128))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                VStack(alignment: .leading) {
                                    Text("Frameworklicious")
                                        .textCase(.uppercase)
                                        .font(.caption)
                                    Text(framework.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text(framework.subtitle)
                                        .font(.title2)
                                        .multilineTextAlignment(.leading)
                                        .padding(.bottom, 5)
                                    Text("Proximity: \(beacon.proximity.rawValue)")
                                        .font(.body)
                                }
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .padding(.vertical)
                            .background(
                                LinearGradient(colors: [
                                    .black, framework.color.opacity(0.5)
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .background(.black)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(framework.color, lineWidth: 2)
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black.opacity(0.5), lineWidth: 2)
                            }
                        }
                    }
                    .sheet(isPresented: $isPresented){
                        ZStack {
                            Color(.systemBackground)
                            ZStack {
                                VStack(alignment: .leading) {
                                    ZStack {
                                        Image(systemName: framework.icon)
                                            .foregroundColor(.white.opacity(0.25))
                                            .font(.system(size: 128))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Frameworklicious")
                                                .textCase(.uppercase)
                                                .font(.caption)
                                            Text(framework.name)
                                                .font(.title)
                                                .fontWeight(.bold)
                                            Text(framework.subtitle)
                                                .font(.title2)
                                        }
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding()
                                    .padding(.vertical)
                                    .background(
                                        LinearGradient(colors: [
                                            .black, framework.color.opacity(0.5)
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    .background(.black)
                                    .cornerRadius(8)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(framework.color, lineWidth: 2)
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.black.opacity(0.5), lineWidth: 2)
                                    }
                                    
                                    ScrollView {
                                        Text(framework.description)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.white)
                                            .padding(.top)
                                    }
                                    
                                    Button {
                                        self.isPresented = false
                                    } label: {
                                        Text("Back")
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(framework.color)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            }

                        }
                    }
                }
            }
            .navigationTitle("Nearby Beacons :")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(framework: .coreLocation)
    }
}
