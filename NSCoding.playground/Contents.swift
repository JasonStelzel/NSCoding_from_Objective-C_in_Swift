
// sample class with different data types for illustrating NSCoding in action
class Settings: NSObject {
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
    
}
