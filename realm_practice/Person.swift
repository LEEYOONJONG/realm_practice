import Foundation
import RealmSwift

class Person: Object{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var name: String = ""
    @Persisted var age: Int?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
