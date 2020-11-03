//
//  HomeContentView.swift
//  Retflix
//
//  Created by RENO1 on 2020/11/03.
//

import SwiftUI
import Combine

struct HomeContentView: View {
    let movies: [Movie]
//    @ObservedObject private var viewModel = HomeContentViewModel()
    @ObservedObject var imageLoader = ImageLoader()
    @ObservedObject var movieState = MovieListState()
    
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        
        //ScrollView
        ScrollView{
            VStack(spacing: 0){
                //Movie Poster
                VStack{
                    
                    ZStack{
                        
                        if self.imageLoader.image != nil {
                            Image(uiImage: self.imageLoader.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                                .shadow(radius: 4)
                            
                            Text(movies[0].title)
                                .multilineTextAlignment(.center)
                        }
                        
                        VStack{
                            
                            HStack{
                                Spacer()
                                Image(uiImage: #imageLiteral(resourceName: "logo"))
                                    .resizable()
                                    .frame(width: 32, height: 50)
                                Spacer()
                                Button("TV Shows"){
                                    
                                }.foregroundColor(.white)
                                .frame(height: 40)
                                .font(.headline)
                                Spacer()
                                
                                Button("Movies"){
                                    
                                }.foregroundColor(.white)
                                .frame(height: 40)
                                .font(.headline)
                                Spacer()
                                
                                Button("My List"){
                                    
                                }.foregroundColor(.white)
                                .frame(height: 40)
                                .font(.headline)
                                Spacer()
                                
                            }.padding(.top, 40).padding(.leading, 20)
                            
                            Spacer()
                            //controls Buttons
                            HStack{
                                Spacer()
                                Button(action: {
                                    print("My wish list")
                                },label: {
                                    VStack{
                                        Text("＋").foregroundColor(.white)
                                            .font(.system(size: 30))
                                        Text("My List").font(.custom("Helvetica-Bold", size: 16)).foregroundColor(.white)
                                    }
                                })
                                .frame(height: 40)
                                .padding()
                                
                                Spacer()
                                
                                Button(action: {
                                    print("Play Video")
                                },label: {
                                    HStack{
                                        Text("▶︎").foregroundColor(.black)
                                            .font(.system(size: 30))
                                        Text("Play").font(.custom("Helvetica-Bold", size: 16)).foregroundColor(.black)
                                    }
                                    
                                })
                                .frame(width: 160)
                                .cornerRadius(10)
                                .background(Color.white)
                                
                                Spacer()
                                
                                Button(action: {
                                    print("Info")
                                },label: {
                                    VStack{
                                        Text("ⓘ").foregroundColor(.white)
                                            .font(.system(size: 30))
                                        Text("My List").font(.custom("Helvetica-Bold", size: 16)).foregroundColor(.white)
                                    }
                                })
                                .frame(height: 40)
                                .padding()
                                
                                Spacer()
                                
                            }.background(Color.black)
                        }
                    }
                    
                }.background(Color.red)
                .frame(width: screenSize.width, height: screenSize.height / 1.3, alignment: .top)
                Spacer()
            }
            
            // Scrollable movies list
            VStack{
                HStack{
                    Text("Tranding Now").font(.largeTitle).foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 10)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(self.movies){ movie in
                            VStack{
                                
                                if self.imageLoader.image != nil {
                                    Image(uiImage: self.imageLoader.image!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(8)
                                        .shadow(radius: 4)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .cornerRadius(8)
                                        .shadow(radius: 4)
                                    
                                    Text(movie.title)
                                        .multilineTextAlignment(.center)
                                }
                                
                            }.frame(width: 120, height: 180)
                            .background(Color.green)
                            
                        }
                    }
                    
                }
                
            }.background(Color.black)
            
            
            
            Spacer()
            
        }.edgesIgnoringSafeArea(.all)
        .background(Color.black)
        
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(movies: Movie.stubbedMovies)
    }
}
