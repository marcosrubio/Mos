//
//  ExceptionalApplication.swift
//  Mos
//  例外的应用程序对象
//  Created by Caldis on 2018/2/20.
//  Copyright © 2018年 Caldis. All rights reserved.
//

import Cocoa

class ExceptionalApplication: Codable, Equatable {
    
    // 基础
    var name: String?
    var path: String?
    var bundleId: String
    // 继承 (smooth 及 reverse 不走这个)
    var inherit = true
    // 滚动
    var scroll = OPTIONS_SCROLL_DEFAULT()
    
    // 初始化
    // 从应用程序路径选择初始化
    init(path: String, bundleId: String) {
        self.path = path
        self.bundleId = bundleId
    }
    // 手动输入初始化（会没有图标）
    init(name: String, bundleId: String) {
        self.name = name
        self.bundleId = bundleId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // 基础
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? nil
        self.path = try container.decodeIfPresent(String.self, forKey: .path) ?? nil
        self.bundleId = try container.decodeIfPresent(String.self, forKey: .bundleId) ?? ""
        // 开关
        self.inherit = try container.decodeIfPresent(Bool.self, forKey: .inherit) ?? true
        // 滚动
        self.scroll = try container.decodeIfPresent(OPTIONS_SCROLL_DEFAULT.self, forKey: .scroll) ?? OPTIONS_SCROLL_DEFAULT()
    }
    
    static func == (lhs: ExceptionalApplication, rhs: ExceptionalApplication) -> Bool {
        return lhs.bundleId == rhs.bundleId
    }
}

/**
 * 工具函数
 */
extension ExceptionalApplication {
    func getIcon() -> NSImage {
        return Utils.getApplicationIcon(from: path)
    }
    func getName() -> String {
        if let validName = name {
            return validName
        }
        return Utils.getAppliactionName(from: path)
    }
}
