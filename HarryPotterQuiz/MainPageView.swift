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
    @State private var animateViewsIn = false
    
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
                    HeaderView(animateViewsIn: $animateViewsIn)
                    Spacer()
                    ScoresView(animateViewsIn: $animateViewsIn)
                    Spacer()
                    FooterButtonsView(animateViewsIn: $animateViewsIn,
                                      viewHeight: geo.size.height,
                                      viewWidth: geo.size.width)
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewsIn = true
            playAudio()
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        //        audioPlayer.play()
    }
    
}

struct HeaderView: View {
    @Binding var animateViewsIn: Bool
    var body: some View {
        VStack {
            if animateViewsIn {
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
                }
                .padding(.top, 80)
                .transition(.move(edge: .top))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
    }
}

struct ScoresView: View {
    @Binding var animateViewsIn: Bool
    
    var body: some View {
        VStack {
            if animateViewsIn {
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
                .transition(.opacity)
            }
        }
        .animation(.linear(duration: 1).delay(3.8), value: animateViewsIn)
    }
}

struct FooterButtonsView: View {
    @State private var scalePlayButton = false
    @Binding var animateViewsIn: Bool
    var viewHeight: CGFloat
    var viewWidth: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if animateViewsIn {
                    
                    Button {
                        // Show Instructions
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                    }
                    .transition(.offset(x: -viewWidth / 4))
                }
            }
            .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
            
            Spacer()
            VStack {
                if animateViewsIn {
                    VStack {
                        
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
                        .transition(.offset(y: viewHeight / 3))
                    }
                }
            }
            .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
            
            Spacer()
            
            VStack {
                if animateViewsIn {
                    Button {
                        //
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .shadow(radius: 6)
                    }
                    .transition(.offset(x: viewWidth / 4))
                }
            }
            .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
            
            Spacer()
            
        }.frame(width: viewWidth)
    }
}

#Preview {
    MainPageView()
}
