//
//  URLSession.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/19.
//

import Foundation
/// 发送图片到服务器
/// - Parameters:
///   - imageData: 要上传的图片数据
///   - urlString: 服务器的API URL
func uploadImageToServer(imageData: Data, urlString: String) {
    guard let url = URL(string: urlString) else {
        print("服务器URL不正确")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let boundary = "Boundary-\(UUID().uuidString)"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    var body = Data()
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
    body.append(imageData)
    body.append("\r\n".data(using: .utf8)!)
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    
    request.httpBody = body
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("网络请求错误: \(error?.localizedDescription ?? "未知错误")")
            return
        }
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("图片上传成功")
        } else {
            print("服务器响应错误")
        }
    }.resume()
}
