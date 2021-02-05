import XCTest
import VeritranSDK

class TestsUser: XCTestCase {
    
    var mockusers: [User]!
    var mockInterface: UserApiInterface!
    var sdkInstance: VeritranSDK!
    
    override func setUp() {
        super.setUp()
        mockusers = [ User(identifier: "francisco", name: "Pancho") ]
        mockInterface = UserApiImpl(usersDb: mockusers)
        sdkInstance = VeritranSDK(interface: mockInterface)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testGetUserById() {
        XCTAssert((sdkInstance.usersAPI.getUserById(id: "francisco") != nil), "User exist. Search by Id")
    }
    
    func testGetUserByName() {
        XCTAssert((sdkInstance.usersAPI.getUsersByName(name: "Pancho") != nil), "User exist. Search by name")
    }
    
    func testGetUsersByName() {
        //TODO: Should init the SDK again if the userDb has changed ?
        mockusers.append(User(identifier: "francisco2", name: "Pancho"))
        let mockInterface = UserApiImpl(usersDb: mockusers)
        let sdk = VeritranSDK(interface: mockInterface)
        XCTAssert((sdk.usersAPI.getUsersByName(name: "Pancho")?.count ?? 0 >= 2), "User exist. Search by name")
    }
    
    func testGetUserNotFoundById() {
        XCTAssert((sdkInstance.usersAPI.getUserById(id: "Pancho") == nil), "User doesn't exist")
    }
    
    func testGetUserNotFoundByName() {
        XCTAssert((sdkInstance.usersAPI.getUsersByName(name: "francisco") == nil), "User exist")
    }
    
    func testCreateUser() {
        let identifierInDB = sdkInstance.usersAPI.addUser(user: User(identifier: "matias", name: "Matias Duarte"))
        XCTAssertEqual(identifierInDB, "matias")
        XCTAssert((sdkInstance.usersAPI.getUserById(id: "matias") != nil), "User exist")
    }
    
    func testCreateUserFailedDuplicatedID() {
        let identifierInDB = sdkInstance.usersAPI.addUser(user: User(identifier: "francisco", name: "Matias Duarte"))
        XCTAssert((identifierInDB == nil), "User doesn't exist in DB")
        XCTAssert((sdkInstance.usersAPI.getUserById(id: "francisco") != nil), "User exist")

    }
    
    func tesCreateUserEmptyID() {
        let identifierInDB = sdkInstance.usersAPI.addUser(user: User(identifier: "", name: "Matias Duarte"))
        XCTAssert((identifierInDB == nil), "User doesn't exist in DB")
        XCTAssert((sdkInstance.usersAPI.getUsersByName(name: "") == nil), "User doesn't exist in DB")
    }
    
    func testCreateUserEmptyName() {
        let identifierInDB = sdkInstance.usersAPI.addUser(user: User(identifier: "example", name: ""))
        XCTAssert((identifierInDB == nil), "User doesn't exist in DB")
        XCTAssert((sdkInstance.usersAPI.getUserById(id: "") == nil), "User doesn't exist in DB")
    }
    
    func testCreateAccount() {
        guard let user = sdkInstance.usersAPI.getUserById(id: "francisco") else {
            return XCTFail("User doesn't exist")
        }
        
        let account = Account(type: Currency.ARS)
        user.addAccount(account: account) { result in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTFail("Fail adding an account")
            }
        }
        
        user.getAccountByCurrency(currency: .ARS) { [weak self] result in
            switch result {
            case .success(let account):
                XCTAssertTrue(account.type == .ARS)
            case .failure(_):
                XCTFail("The account isn't available")
            }
            
            self?.expectation(description: "account").fulfill()
            
            self?.waitForExpectations(timeout: 5, handler: nil)
        
        }
        
        
    }
}
