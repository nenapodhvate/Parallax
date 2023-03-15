//
//  Home.swift
//  Parallax
//
//  Created by Akari on 11.03.23.
//

import SwiftUI

struct Home: View {
    //MARK: - State Object of MM
    @StateObject var motionManager: MotionManager = .init()
    var body: some View {
        VStack(spacing: 15){
            HStack{
                ParallaxCards()
                    .padding(.horizontal,-15)
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background {
                Rectangle()
                    .fill(Color("background"))
                    .ignoresSafeArea()
            }
        }
    }
    //MARK: - Parallax Cards
    @ViewBuilder
    func ParallaxCards()->some View{
        TabView(selection: $motionManager.currentSlide){
            ForEach(resources){place in
                GeometryReader{proxy in
                    let size = proxy.size
                    
                    //MARK: - Adding Parallax Effect To Currently Showing Slide
                    ZStack{
                        Image(place.bgName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: motionManager.currentSlide.id == place.id ? -motionManager.xValue * 75 : 0)
                            .frame(width: size.width, height: size.height)
                            .clipped()
                        
                        Image(place.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: motionManager.currentSlide.id == place.id ? overlayOffset() : 0)
                            .frame(width: size.width, height: size.height)
                            .clipped()
                            .scaleEffect(1.05,anchor: .bottom)
                            
                            Text(place.placeName)
                                .font(.title)
                                .foregroundColor(.white.opacity(0.6))
                                .shadow(color: .black.opacity(0.3), radius: 15, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.3), radius: 15, x: -5, y: -5)
                            
                            .padding(.top,15)
                        
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top,60)
                        .offset(x: motionManager.currentSlide.id == place.id ? -motionManager.xValue * 15 : 0)
                    }
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .animation(.interactiveSpring(), value: motionManager.xValue)
                }
                .padding(.vertical,30)
                .padding(.horizontal,40)
                .tag(place)
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear(perform: motionManager.detectMotion)
        .onDisappear(perform: motionManager.stopMotionUpdates)
        .shadow(color: Color.black.opacity(0.3), radius: 15)


    }
    
    func overlayOffset()->CGFloat{
        let offset = motionManager.xValue * 7
        if offset > 0{
            return offset > 8 ? 8 : offset
        }
        return -offset > 8 ? -8 : offset
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
