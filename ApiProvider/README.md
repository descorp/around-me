# ApiProvider
Set of helper to make a fast wrap of public APIs.

## How does it work

1. attach .cer file of a public SLL certifical to the bundle
2. create new RequestBuilder class

```swift
class LondonMetroUrlBuilder: RequestBuilder {
    func buildRequest<T>(for endpoint: Endpoint<T>) throws -> URLRequest {
        var baseUrl = URL(string: "https://api.tfl.gov.uk")!
        baseUrl.appendPathComponent(endpoint.path)
        return URLRequest(url: baseUrl)
    }
}
```

3. create DTO and endpoints

```swift
extension Endpoint where ReturnType == Dummy {
    static func bikePoint(id: String) -> Endpoint {
        return Endpoint(
            path: "/BikePoint/\(id)", body: nil,
            queryItems: [],
            parse: ReturnType.decode
        )
    }
}
```

4. initiate instance of RemoteAPIProvider

```
let apiProvider = RemoteApiProvider(with: LondonMetroUrlBuilder())
```

5. request endpoint

```swift
apiProvider.request(Endpoint.bikePoint(id: bikePointId)) { result in 
  // TODO: treat your response nicely :)
}
```

## Configuration

You can use a configure your RequestBuilder using .plist files and use `Configuration(bundle: Bundle, name: String = "config")` class to have access to it

Example:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Common</key>
	<dict>
		<key>client_id</key>
		<string>CLIENT_ID</string>
		<key>client_secret</key>
		<string>CLIENT_SECRET</string>
		<key>url</key>
		<string>https://api.foursquare.com</string>
		<key>version</key>
		<string>v2</string>
	</dict>
</dict>
</plist>
```
