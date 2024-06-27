//
//  ImageServer.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/19.
//

import Foundation
import UIKit

struct ImageServices {
    // 图片压缩到指定大小
    static func compressImage(_ image: UIImage, toMaxSize maxSize: Double) -> Data? {
        var compression: CGFloat = 1.0
        let maxFileSize = maxSize * 1024 * 1024
        guard var imageData = image.jpegData(compressionQuality: compression) else {
            return nil
        }
        
        // 如果初始文件大小就小于目标大小，则直接返回
        if imageData.count <= Int(maxFileSize) {
            return imageData
        }
        
        // 二分法压缩图片
        var maxCompression: CGFloat = 1.0
        var minCompression: CGFloat = 0.0
        while imageData.count > Int(maxFileSize) && compression > 0.01 {
            compression = (maxCompression + minCompression) / 2
            if let newImageData = image.jpegData(compressionQuality: compression) {
                imageData = newImageData
                if imageData.count < Int(maxFileSize) {
                    minCompression = compression
                } else {
                    maxCompression = compression
                }
            }
        }
        return imageData
    }


    // 上传图片到服务器
    static func uploadImageToServer(imageData: Data, urlString: String, completion: @escaping () -> Void) {
        guard let url = URL(string: urlString) else {                               
            print("服务器URL不正确")
            completion()
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
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            guard error == nil else {
                print("网络请求错误: \(error?.localizedDescription ?? "未知错误")")
                completion()
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("图片上传成功")
            } else {
                print("服务器响应错误")
            }
            completion()
        }.resume()
    }
}
