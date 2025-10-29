//
//  UIView.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//
import Foundation
import UIKit

// 对UIView进行扩展，方便获取视图的尺寸和位置信息
extension UIView {
    // 获取视图的宽度
    var width: CGFloat {
        return frame.size.width
    }
    
    // 获取视图的高度
    var height: CGFloat {
        return frame.size.height
    }
    
    // 获取视图的左边缘坐标（相对于父视图）
    var left: CGFloat {
        return frame.origin.x
    }
    
    // 获取视图的右边缘坐标（相对于父视图）
    var right: CGFloat {
        return left + width
    }
    
    // 获取视图的上边缘坐标（相对于父视图）
    var top: CGFloat {
        return frame.origin.y
    }
    
    // 获取视图的下边缘坐标（相对于父视图）
    var bottom: CGFloat {
        return top + height
    }
}
