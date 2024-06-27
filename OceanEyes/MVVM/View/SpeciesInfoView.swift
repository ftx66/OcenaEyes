//
//  SpeciesInfoView.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/21.
//

import SwiftUI

struct SpeciesInfoView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var typingAnimationText = ""
    @State private var typingIndex = 0
    @State private var timer: Timer?
    @Environment(\.presentationMode) var presentationMode // 环境变量用于控制视图显示

    var body: some View {
        VStack(spacing: 20) {
            if let info = viewModel.speciesInfo {
                // 标题
                Text(info.name)
                    .font(.largeTitle) // 使用大号标题
                    .fontWeight(.bold) // 字体加粗
                    .foregroundColor(.green) // 标题颜色
                    .padding(.top, 20) // 顶部间距

                // 描述文字的打字机效果
                ScrollView {
                    Text(typingAnimationText)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onAppear {
                            // 开始打字机效果
                            startTypingAnimation(for: info.describe)
                        }
                        .onDisappear {
                            // 界面消失时停止定时器
                            stopTypingAnimation()
                        }
                }
                .background(Color(white: 0.95)) // 轻微灰色背景
                .cornerRadius(10) // 圆角
                .shadow(radius: 5) // 阴影
            } else {
                Text("No data available")
                    .foregroundColor(.red) // 没有数据时的文本颜色
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchSpeciesInfo()
        }
        .navigationTitle("Species Information")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // 添加返回按钮
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.backward")
//                    Image(systemName: "arrow.down")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding() // 视图的外部间距
        .background(Color(white: 0.98).edgesIgnoringSafeArea(.all)) // 整个视图的背景颜色
    }

    func startTypingAnimation(for text: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if typingIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: typingIndex)
                typingAnimationText.append(text[index])
                typingIndex += 1
            } else {
                stopTypingAnimation()
            }
        }
    }

    func stopTypingAnimation() {
        timer?.invalidate()
        timer = nil
    }
}
#Preview {
    SpeciesInfoView(viewModel: MainViewModel())
}

