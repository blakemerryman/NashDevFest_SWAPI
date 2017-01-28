/*:
 # NetworkInterface

 - A simple network interface that hits REST API to return resource data.

 - Currently, only supports `GET` requests.

 */

import Foundation

/// The completion callback for NetworkInterface requests includes information about the response.
///
/// - Parameters:
///   - data:     On success, the request's reponse data.
///   - response: Information about the response.
///   - error:    On failure, the error containing information about what when wrong.
public typealias NetworkInterfaceCompletionHandler = (Data?, URLResponse?, Error?) -> Void

public protocol NetworkInterface {

  /// The base path to be used for URL requests.
  var baseURLPath: String { get }


  /// Performs a `GET` request for a specified resource; returns data via the completion handler.
  func get(_ endpoint: String, completion: @escaping NetworkInterfaceCompletionHandler) -> Void

}

/*:
 ## Default Implementation

 - Implements the important functionality to be shared amongst all NetworkInterfaces.

 */

public extension NetworkInterface {

  func get(_ endpoint: String, completion: @escaping NetworkInterfaceCompletionHandler) {

    guard let baseURL = URL(string: self.baseURLPath) else {
      fatalError("*** FAILED TO CREATE URL ***")
    }

    let requestURL = baseURL.appendingPathComponent(endpoint)
    var request = URLRequest(url: requestURL)
    request.httpMethod = "GET"

    let dataTask = URLSession.shared.dataTask(with: request, completionHandler: completion)

    dataTask.resume()
  }

}


/*:
 ## Specializing for Star Wars API

 - Creating new (empty) protocol that inherits from NetworkInterface.

 - Extend to supply API-specific information (basePathURL)

 - Inherits any default implementations for free!

 */

public protocol StarWarsInterface: NetworkInterface { /* Intentionally left empty! */ }

public extension StarWarsInterface {

  var baseURLPath: String {
    return "http://swapi.co/api"
  }

}
