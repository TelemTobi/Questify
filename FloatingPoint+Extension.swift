//
//  FloatingPoint+Extension.swift
//  Questify
//
//  Created by Telem Tobi on 26/04/2024.
//

import Foundation

extension FloatingPoint {
    
    func progress(in range: ClosedRange<Self>) -> Self {
        let (min, max) = (range.lowerBound, range.upperBound)
        let value = self.clamped(to: range)
        return (value - min) / (max - min)
    }
}
