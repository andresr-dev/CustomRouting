//
//  SegueOption.swift
//  ArchitectureBootcamp
//
//  Created by Andres Raigoza on 20/05/25.
//

public enum SegueOption {
    case push, sheet, fullScreenCover
    
    var shouldAddNavigationStack: Bool {
        switch self {
        case .push:
            return false
        default:
            return true
        }
    }
}
