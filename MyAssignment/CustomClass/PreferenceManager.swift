//
//  PreferenceManager.swift
//  MyAssignment
//
//  Created by pthakare on 25/06/24.
//

import Foundation


class PreferenceManager{
    
    static let shared = PreferenceManager()
    let preferences = UserDefaults.standard
   
    private init(){}
    
    enum Keys{
       
        case isLoggedIn
       
        var key : String
        {
            switch self{
                
            
            case .isLoggedIn:
                return Config.shared.keys.isLoggedIn
            }
        }
        
    }
    
    func writeInt(key: Keys, value: Int) {
        preferences.set(value, forKey: key.key);
        preferences.synchronize()
    }
    
    func readInt(key: Keys) -> Int  {
        return preferences.integer(forKey: key.key)
    }

    func writeString(key: Keys, value: String) {
        preferences.set(value, forKey: key.key);
        preferences.synchronize()
    }

    func readString(key: Keys) -> String  {
        return preferences.string(forKey: key.key) ?? ""
    }
    
    func writeDouble(key: Keys, value: Double) {
        preferences.set(value, forKey: key.key);
        preferences.synchronize()
    }
   
    func readDouble(key: Keys) -> Double {
        return preferences.double(forKey: key.key)
    }

    func writeBoolean(key: Keys, value: Bool) {

        preferences.set(value, forKey: key.key);
        preferences.synchronize()
    }

    func readBoolean(key: Keys) -> Bool  {
        return preferences.bool(forKey: key.key)
    }

    func writeData(key: Keys, value: Data?) {
        preferences.set(value, forKey: key.key);
        preferences.synchronize()
    }

    func readData(key: Keys) -> Data? {
        return preferences.data(forKey: key.key) ?? nil
    }

    func writeAny(key: Keys, value: Any) {
        preferences.set(value, forKey: key.key)
        preferences.synchronize()
    }

    func readAny(key: Keys) -> Any  {
        return preferences.value(forKey: key.key) as Any
    }

   
//    func resetDefaults() {
//        let dictionary = preferences.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            guard key != Config.shared.prefrences.KEY_HAS_SEEN_INTRO_SCREEN && key != Config.shared.prefrences.KEY_DEVICE_TOKEN else {return} // For logout should not remove intro screen details
//            preferences.removeObject(forKey: key)
//        }
//    }
    
    
    
    
    
    
    
    
    
}

class Config{
    
    static let shared = Config()
    
    
    private init(){}
    
    let keys = PreferenceKey()
}

class PreferenceKey
{
   
    let isLoggedIn = "isLoggedIn"
    
}
