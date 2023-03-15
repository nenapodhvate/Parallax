//
//  MotionManager.swift
//  Parallax
//
//  Created by Akari on 11.03.23.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    //MARK: - MM Properties
    @Published var manager: CMMotionManager = .init()
    @Published var xValue: CGFloat = 0
    //MARK: - Current Slide
    @Published var currentSlide: Place = resources.first!
    
    func detectMotion(){
        if !manager.isDeviceMotionActive{
            //MARK: - Memory Usage
            manager.deviceMotionUpdateInterval = 1/40
            manager.startDeviceMotionUpdates(to: .main) {[weak self] motion, err in
                if let attitude = motion?.attitude{
                    //MARK: - Obtaining Device Roll Value
                    self?.xValue = attitude.roll
                    print(attitude.roll)
                }
            }
        }
    }
    
    //MARK: - Stopping Updates
    func stopMotionUpdates(){
        manager.stopDeviceMotionUpdates()
    }
}
