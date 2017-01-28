import Foundation
/*:
 # NetworkInterface
 
 - A simple network interface that hits REST API to return resource data.
 
 - Currently, only supports `GET` requests.

 */

typealias NetworkInterfaceCompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol NetworkInterface {

  /// The base path to be used for URL requests.
  var baseURLPath: String { get }


  /// Performs a `GET` request for a specified resource; returns data via the completion handler.
  func get(_ endpoint: String,
           completion: @escaping NetworkInterfaceCompletionHandler) -> Void

}

/*:
 ## Default Implementation
 
 - Implements the important functionality to be shared amongst all NetworkInterfaces.
 
 */

extension NetworkInterface {

  func get(_ endpoint: String,
           completion: @escaping NetworkInterfaceCompletionHandler) {

    guard let baseURL = URL(string: self.baseURLPath) else {
      fatalError("*** FAILED TO CREATE URL ***")
    }

    let requestURL = baseURL.appendingPathComponent(endpoint)
    var request = URLRequest(url: requestURL)
    request.httpMethod = "GET"

    let dataTask = URLSession.shared.dataTask(with: request,
                                              completionHandler: completion)

    dataTask.resume()
  }

}


/*:
 ## Specializing for Star Wars API
 
 - Creating new (empty) protocol that inherits from NetworkInterface.
 
 - Extend to supply API-specific information (basePathURL)
 
 - Inherits any default implementations for free!
 
 */

protocol StarWarsInterface: NetworkInterface { /* Intentionally left empty! */ }

extension StarWarsInterface {

  var baseURLPath: String {
    return "http://swapi.co/api"
  }

}

//: ----
//: ## In Action...
//: > `prepareForNetworkActivity()` is a helper method to ensure playground runs async.
//: > `JSONHelper` is a helper to encode/decode JSON data.


struct FakeStarWarsAPIClient: StarWarsInterface { /* Intentionally left empty! */ }

let client = FakeStarWarsAPIClient()

prepareForNetworkActivity() // Playground helper method

client.get("/people/2/") { data, response, error in

  JSONHelper.shared
    .decodeJSON(fromData: data)?
    .forEach { print("\($0.key) - \($0.value)") }
}

//: [Intro](@previous)  |  [Model](@next)
