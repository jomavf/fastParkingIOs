//
//  SettingsSection.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social 
    case Opciones
    
    var description: String {
        switch self {
        case .Social: return "Social"
        case .Opciones: return "Opciones"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType {
    case logout
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .logout: return "Salir"
        }
    }
}

enum CommunicationOptions: Int, CaseIterable, SectionType {
    case onBoarding
    case email
    
    var containsSwitch: Bool {
        switch self {
        case .onBoarding: return true
        case .email: return true
        }
    }
    
    var description: String {
        switch self {
        case .onBoarding: return "Página de inicio"
        case .email: return "Email"
        }
    }
}
