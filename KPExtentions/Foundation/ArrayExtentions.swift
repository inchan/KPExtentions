//
//  ArrayExtentions.swift
//  ICExtentions
//
//  Created by INCHAN KANG on 2018. 4. 5..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import Foundation

extension Array {
    
    /// 배열에서 안전하게 아이탬을 꺼내자
    /// Safe atIndex
    ///
    ///     [1,2].item(index: 2) -> nil
    ///     [1,2].item(index: 1) -> Optional(2)
    ///
    
    public func item(safe atIndex: Int) -> Element? {
        if atIndex < count { return self[atIndex] }
        return nil
    }
}
