//
//  Extensions.swift
//  genme
//
//  Created by Emirhan Karahan on 13.08.2023.
//

import UIKit

enum iPhone {
    case iPhone11(width: Double = 414, height: Double = 896)
}

extension Int {
    
    func rW(device: iPhone = .iPhone11()) -> CGFloat {
        switch device {
        case .iPhone11(let width, _):
            return Device.width * Double(self) / width
        }
    }
    
    func rH(device: iPhone = .iPhone11()) -> CGFloat {
        switch device {
        case .iPhone11(_, let height):
            return Device.height * Double(self) / height
        }
    }
    
}

extension CGFloat {
    
    func rW(device: iPhone = .iPhone11()) -> CGFloat {
        switch device {
        case .iPhone11(let width, _):
            return Device.width * self / width
        }
    }
    
    func rH(device: iPhone = .iPhone11()) -> CGFloat {
        switch device {
        case .iPhone11(_, let height):
            return Device.height * self / height
        }
    }
    
}
