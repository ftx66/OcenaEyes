//
//  MainViewModel.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/19.
//

import Foundation
import SwiftUI
import UIKit

extension MainViewModel {
    struct SpeciesInfo: Codable {
        let name: String
        let describe: String
    }
}

class MainViewModel: ObservableObject {
    @Published var displayImage: UIImage?
    @Published var showImagePicker: Bool = false
    @Published var useCamera: Bool = false
    @Published var isLoading: Bool = false
    @Published var speciesInfo: SpeciesInfo?
    @Published var isSpeciesInfoAvailable: Bool = false

    func pickImage(usingCamera: Bool = false) {
        DispatchQueue.main.async {
            self.useCamera = usingCamera
            self.showImagePicker = true
        }
    }

    func uploadImage() {
        guard let image = displayImage else {
            print("没有选择图片")
            return
        }

        DispatchQueue.main.async {
            self.isLoading = true
        }

        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let urlString = "https://www.wmblcx.cn/chat/chat"
            guard let url = URL(string: urlString) else {
                print("无效的 URL")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var body = Data()
            let boundaryPrefix = "--\(boundary)\r\n"

            body.append(Data(boundaryPrefix.utf8))
            body.append(Data("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".utf8))
            body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
            body.append(imageData)
            body.append(Data("\r\n".utf8))
            body.append(Data("--\(boundary)--\r\n".utf8))

            request.httpBody = body

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let error = error {
                        print("上传图片时出错: \(error)")
                    } else if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            print("图片上传成功")
                            if let data = data {
                                print("服务器返回的数据: \(String(data: data, encoding: .utf8) ?? "无法转换为字符串")")
                                self.handleServerResponse(data: data)
                                self.isSpeciesInfoAvailable = true
                            } else {
                                print("没有收到有效的数据")
                            }
                        } else {
                            print("图片上传失败，状态码: \(response.statusCode)")
                        }
                    } else {
                        print("上传图片时出错，没有收到有效的响应")
                    }
                }
            }
            task.resume()
        } else {
            DispatchQueue.main.async {
                print("图片转换失败")
                self.isLoading = false
            }
        }
    }

    func handleServerResponse(data: Data) {
        do {
            // 打印原始数据
            if let rawDataString = String(data: data, encoding: .utf8) {
                print("服务器返回的原始数据: \(rawDataString)")
                
                // 解析整个 JSON 数据
                if let outerJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let dataDict = outerJson["data"] as? [String: Any] {
                    // 使用 JSONSerialization 直接解析嵌套 JSON 对象
                    let jsonData = try JSONSerialization.data(withJSONObject: dataDict, options: [])
                    let decodedData = try JSONDecoder().decode(SpeciesInfo.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.speciesInfo = decodedData
                        print("物种信息: \(decodedData)")
                    }
                }
            }
        } catch {
            print("解码错误: \(error)")
        }
    }

    func fetchSpeciesInfo() {
        let urlString = "https://www.wmblcx.cn/chat/chat"
        guard let url = URL(string: urlString) else {
            print("无效的URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("获取数据时出错: \(error)")
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    print("未接收到任何数据")
                }
                return
            }

            self.handleServerResponse(data: data)
        }.resume()
    }
    
    func clearData() {
            displayImage = nil
            showImagePicker = false
            useCamera = false
            isLoading = false
            speciesInfo = nil
            isSpeciesInfoAvailable = false
        }
}






    
    

