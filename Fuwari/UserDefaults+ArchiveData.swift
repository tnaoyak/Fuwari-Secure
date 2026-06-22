//
//  UserDefaults+ArchiveData.swift
//  Fuwari
//
//  Created by Kengo Yokoyama on 2016/12/24.
//  Copyright © 2016年 AppKnop. All rights reserved.
//

import Cocoa

extension UserDefaults {
    func setCodableData<T: Codable>(_ object: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            set(data, forKey: key)
        } catch {
            print("Failed to encode codable object: \(error)")
        }
    }
    
    func codableDataForKey<T: Codable>(_: T.Type, key: String) -> T? {
        guard let data = object(forKey: key) as? Data else { return nil }
        
        // 1. Try to decode as JSON (Codable)
        if let object = try? JSONDecoder().decode(T.self, from: data) {
            return object
        }
        
        // 2. Fallback to legacy NSKeyedArchiver format for migration
        if let CodingType = T.self as? NSCoding.Type {
            // Deprecated API is used here strictly for backward compatibility migration.
            // Since we are migrating away from NSKeyedUnarchiver, this is safe and necessary.
            if let legacyObject = NSKeyedUnarchiver.unarchiveObject(with: data) as? T {
                // Re-save in the new Codable format (JSON)
                setCodableData(legacyObject, forKey: key)
                return legacyObject
            }
        }
        
        return nil
    }
}
