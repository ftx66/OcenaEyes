//
//  ContentView.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/19.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var showingDetail = false
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                if let image = viewModel.displayImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding()
                        .shadow(radius: 10)
                } else {
                    Text("上传图片以识别")
                        .foregroundColor(.gray)
                        .font(.title)
                        .padding()
                }
                
                Button(action: {
                    viewModel.showImagePicker = true
                    viewModel.useCamera = false
                }) {
                    Text("相册选择")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.showImagePicker = true
                    viewModel.useCamera = true
                }) {
                    Text("拍照上传")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if viewModel.displayImage != nil {
                    Button(action: {
                        viewModel.uploadImage()
                    }) {
                        Text("分析生物")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                if viewModel.isLoading {
                    ProgressView("生物分析中...")
                        .scaleEffect(1.5, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                }
                
                Spacer()
                
                if viewModel.isSpeciesInfoAvailable {
                    Button(action: {
                        showingDetail = true
                    }) {
                        Text("分析成功 查看结果")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                    .padding()
                    .sheet(isPresented: $showingDetail) {
                        SpeciesInfoView(viewModel: viewModel)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("基于多模态大模型的海洋生物识别系统")
                        .font(.title3) // 这里可以调整字体大小
                }
            }
            
//            .navigationBarItems(trailing: Button(action: {
//                print("Help tapped!")
//            }) {
//                Image(systemName: "questionmark.circle")
//                    .imageScale(.large)
//                    .accessibilityLabel("帮助")
//            })
            .padding()
            .background(Color(.systemGroupedBackground))
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(selectedImage: $viewModel.displayImage, sourceType: viewModel.useCamera ? .camera : .photoLibrary)
            }
        }
    }
}


 #Preview { // SwiftUI preview block is commented because it might cause syntax issue.
    ContentView(viewModel: MainViewModel())
 }
