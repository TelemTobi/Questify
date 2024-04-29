//
//  Comparable+Extension.swift
//  Questify
//
//  Created by Telem Tobi on 26/04/2024.
//

import Foundation

extension Comparable {
    
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
