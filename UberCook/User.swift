class User: Codable {
    var account = ""
    var password = ""
    var user_name = ""
    
    init(_ account: String, _ password: String) {
        self.account = account
        self.password = password
    }
    
    init(_ user_name: String){
        self.user_name = user_name
    }
}
