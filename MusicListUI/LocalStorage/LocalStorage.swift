import Foundation

class LocalStorage {
    static let shared = LocalStorage()
    
    private init() {}
    
    func set<T: Encodable>(_ object: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func retrieve<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: key),
           let object = try? JSONDecoder().decode(T.self, from: data) {
            return object
        }
        return nil
    }
    
    func addOn<T: Codable & Equatable>(_ object: T, forKey key: String) {
        var array = retrieve(forKey: key, as: [T].self) ?? []
        if !array.contains(object) {
            array.append(object)
            set(array, forKey: key)
        }
    }
    
    func removeOn<T: Codable & Equatable>(_ object: T, forKey key: String) {
        var array = retrieve(forKey: key, as: [T].self) ?? []
        if let index = array.firstIndex(of: object) {
            array.remove(at: index)
            set(array, forKey: key)
        }
    }
    
    func contains<T: Codable & Equatable>(_ object: T, inArrayWithKey key: String) -> Bool {
           let array = retrieve(forKey: key, as: [T].self) ?? []
           return array.contains(object)
       }
}
