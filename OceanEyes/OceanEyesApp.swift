//
//  OceanEyesApp.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/19.
//

import SwiftUI

@main
struct OceanEyesApp: App {
    @StateObject var viewModel = MainViewModel()
    @Environment(\.scenePhase) var scenePhase  // 声明 scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .onChange(of: scenePhase) { newPhase in  // 使用更新后的 onChange
                    if newPhase == .background || newPhase == .inactive {
                        viewModel.clearData()  // 清理数据当应用进入后台或变为非活跃
                    }
                }
        }
    }
}

