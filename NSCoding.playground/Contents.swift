import Foundation
// sample class with different data types for illustrating NSCoding in action
class Settings: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var username: String
    var age: Int
    var lastLogin: Date
    var friends: [String]
    var darkMode: Bool

    init(username: String, age: Int, lastLogin: Date, friends: [String], darkMode: Bool) {
      self.username = username
      self.age = age
      self.lastLogin = lastLogin
      self.friends = friends
      self.darkMode = darkMode
    }
    
    // these lines effect conformance to NSSecureCoding required when using the
    // "requiringSecureCoding" NSKeyedArchiver switch below.
    // It also requires the addition of the static var "supportsSecureCoding: Bool = true" above.
    // let obj = decoder.decodeObject(of: ProperNSClass.self, forKey: "myKey") (and cast as needed)
    // let int = decoder.decodeInteger(forKey: "myKey")
    // let bool = decoder.decodeBool(forKey: "myKey")

    required init?(coder aDecoder: NSCoder) {
//      self.username = aDecoder.decodeObject(forKey: "username") as! String // NSCoding
        self.username = aDecoder.decodeObject(of: NSString.self, forKey: "username")! as String // NSSecureCoding
        self.age = aDecoder.decodeInteger(forKey: "age") // NS(Secure)Coding
//      self.lastLogin = aDecoder.decodeObject(forKey: "lastLogin")as! Date // NSCoding
        self.lastLogin = aDecoder.decodeObject(of: NSDate.self, forKey: "lastLogin")! as Date // NSSecureCoding
//      self.friends = aDecoder.decodeObject(forKey: "friends") as! [String] // NSCoding
        self.friends = aDecoder.decodeObject(of: NSArray.self, forKey: "friends") as! [String] // NSSecureCoding
        self.darkMode = aDecoder.decodeBool(forKey: "darkMode") // NS(Secure)Coding
    }

    func encode(with aCoder: NSCoder) {
      aCoder.encode(username, forKey: "username")
      aCoder.encode(age, forKey: "age")
      aCoder.encode(lastLogin, forKey: "lastLogin")
      aCoder.encode(friends, forKey: "friends")
      aCoder.encode(darkMode, forKey: "darkMode")
    }

}

do {
  let settings = Settings(username: "JStelzel", age: 30, lastLogin: Date.now, friends: ["pcJmac", "Prince"], darkMode: true)
    let data = try NSKeyedArchiver.archivedData(withRootObject: settings, requiringSecureCoding: true)
    // look at str to show that data was archived...
    let str = String(decoding: data, as: UTF8.self)
    print("Archived String of data...\n--------------------------")
    print(str) // show encoded data
    // then decode it from encoded string and extract original class values
    if let loadedSettings = try?
    NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as?
    Settings {
        print("\nExtracted original class values from archived data...\n-----------------------------------------------------")
        print(loadedSettings.username)
        print(loadedSettings.age)
        print(loadedSettings.lastLogin)
        print(loadedSettings.friends)
        print(loadedSettings.darkMode)
    }

} catch {
  print("Encode failed", error)
}

