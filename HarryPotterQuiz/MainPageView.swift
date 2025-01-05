//
//  MainPageView.swift
//  HarryPotterQuiz
//
//  Created by Berkin Demirel on 9.12.2024.
//

import SwiftUI
import AVKit

// MARK: - MainPageView
struct MainPageView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var moveBackgroundImage = false
    @State private var animateViewsIn = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AnimatedBackgroundView(moveBackgroundImage: $moveBackgroundImage, geo: geo)
                
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
            //            playAudio()
        }
    }
    
    private func playAudio() {
        guard let soundPath = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: soundPath))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Audio playback failed: \(error.localizedDescription)")
        }
    }
}

// MARK: - AnimatedBackgroundView
struct AnimatedBackgroundView: View {
    @Binding var moveBackgroundImage: Bool
    var geo: GeometryProxy
    
    var body: some View {
        Image(.hogwarts)
            .resizable()
            .frame(width: geo.size.width * 3, height: geo.size.height)
            .padding(.top, 3)
            .offset(x: moveBackgroundImage ? geo.size.width / 1.1 : -geo.size.width / 1.1)
            .onAppear {
                withAnimation(.linear(duration: Constants.backgroundAnimationDuration).repeatForever()) {
                    moveBackgroundImage.toggle()
                }
            }
    }
}

// MARK: - HeaderView
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
        .animation(.easeOut(duration: Constants.animationDuration).delay(Constants.delayForHeader), value: animateViewsIn)
    }
}

// MARK: - ScoresView
struct ScoresView: View {
    @Binding var animateViewsIn: Bool
    
    var body: some View {
        VStack {
            if animateViewsIn {
                VStack {
                    Text("Recent Scores")
                        .font(.title2)
                    ForEach([33, 22, 12], id: \.self) { score in
                        Text("\(score)")
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .foregroundStyle(.white)
                .background(.black.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .transition(.opacity)
            }
        }
        .animation(.linear(duration: 1).delay(Constants.delayForScores), value: animateViewsIn)
    }
}

// MARK: - FooterButtonsView
struct FooterButtonsView: View {
    @State private var scalePlayButton = false
    @Binding var animateViewsIn: Bool
    var viewHeight: CGFloat
    var viewWidth: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            animatedButton(icon: "info.circle.fill", offset: -viewWidth / 4)
            Spacer()
            animatedPlayButton()
            Spacer()
            animatedButton(icon: "gearshape.fill", offset: viewWidth / 4)
            Spacer()
        }
        .frame(width: viewWidth)
    }
    
    @ViewBuilder
    private func animatedButton(icon: String, offset: CGFloat) -> some View {
        VStack {
            if animateViewsIn {
                Button {
                    // Perform action
                } label: {
                    Image(systemName: icon)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                .transition(.offset(x: offset))
            }
        }
        .animation(.easeOut(duration: Constants.animationDuration).delay(Constants.delayForButtons), value: animateViewsIn)
    }
    
    @ViewBuilder
    private func animatedPlayButton() -> some View {
        VStack {
            if animateViewsIn {
                Button {
                    // Perform action
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
        .animation(.easeOut(duration: Constants.animationDuration).delay(Constants.delayForButtons - 0.7), value: animateViewsIn)
    }
}

#Preview {
    MainPageView()
}
