//
//  ImageUtils.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/19.
//

import Foundation
import UIKit

/// 压缩图片到指定的最大文件大小
/// - Parameters:
///   - image: 要压缩的原始UIImage对象
///   - maxSize: 最大文件大小（单位：MB）
/// - Returns: 压缩后的图片数据
func compressImage(_ image: UIImage, toMaxSize maxSize: Double) -> Data? {
    var compression: CGFloat = 1.0
    let maxFileSize = maxSize * 1024 * 1024
    var imageData = image.jpegData(compressionQuality: compression)
    
    while ((imageData?.count ?? 0) > Int(maxFileSize) && compression > 0) {
        compression -= 0.1
        imageData = image.jpegData(compressionQuality: compression)
    }
    
    return imageData
}
