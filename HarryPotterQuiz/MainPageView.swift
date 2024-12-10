//
//  MainPageView.swift
//  HarryPotterQuiz
//
//  Created by Berkin Demirel on 9.12.2024.
//

import SwiftUI
import AVKit

struct MainPageView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var moveBackgroundImage = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .offset(x: moveBackgroundImage ? geo.size.width/1.1 : -geo.size.width/1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
                VStack {
                    HeaderView()
                    Spacer()
                    ScoresView()
                    Spacer()
                    FooterButtonsView()
                        .frame(width: geo.size.width)
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            playAudio()
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
}

#Preview {
    MainPageView()
}

struct HeaderView: View {
    var body: some View {
        VStack {
            Image(systemName: "bolt.fill")
                .font(.largeTitle)
                .imageScale(.large)
            
            Text("Harry Potter")
                .font(.custom(Constants.hpFont, size: 70))
                .fontWeight(.bold)
                .padding(.bottom, -50)
            Text("Quiz")
                .font(.custom(Constants.hpFont, size: 60))
        }.padding(.top, 80)
    }
}

struct ScoresView: View {
    var body: some View {
        VStack {
            Text("Recent Scores")
                .font(.title2)
            Text("33")
            Text("22")
            Text("12")
            
        }
        .font(.title3)
        .padding(.horizontal)
        .foregroundStyle(.white)
        .background(.black.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct FooterButtonsView: View {
    @State private var scalePlayButton = false
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                // Show Instructions
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
            }
            
            Spacer()
            
            Button {
                //
            } label: {
                Text("Play")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 50)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 6)
            }
            .scaleEffect(scalePlayButton ? 1.2 : 1)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                    scalePlayButton.toggle()
                }
            }
            
            Spacer()
            
            Button {
                //
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .shadow(radius: 6)
            }
            Spacer()
        }
    }
}
