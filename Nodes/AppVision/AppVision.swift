//  AppVision.swift
//  Created by Vladimir Roganov on 26.03.2024

import SwiftUI

@main
struct AppVision: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
