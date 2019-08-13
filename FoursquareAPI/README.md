# FoursquareAPI

Crossplatform framework that provides building block to access Foursquare public API.
Highly customisable, allows you to creare new DTOs and endpoints to

## Out of the box
Provides set of DTOs and endpoints to request venues around specific geolocation and list of categories. 

### Endpoints
1. "/venues/categories"
2. "/venues/search"

## How to use
1. add latest SSL certificat to your bundle
2. create `.plist` file with a following structure

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
        <key>version_date</key>
        <string>20190804</string>
    </dict>
</dict>
</plist>
```

3. instantiate new instance of api provider

```
let apiProvider = RemoteApiProvider(with: ForsquareUrlRequestBuilder(with: Configuration(bundle: Bundle.main)))
```

4. call endpoint

```
apiProvider.request(Endpoint.getVenues(at: myCoordinate, radius: radius, categories: category_id)) { result in 
  print(result.response.venues)
}
```

## How to create a new endpoint
1. Crearte a DTO if needed

```
struct SingleVenueResponse: Codable {
    let venue: VenueDetails
}
```

2. Create a new instance of Endpoint. Could be a static calculated property on extension:

```
public extension Endpoint where ReturnType == FoursquareResponce<SingleVenueResponse> {
    static func getVenue(id: String) -> Endpoint {
        return Endpoint(
            path: "/venues/\(id)",
            body: nil,
            queryItems: queryItems,
            parse: ReturnType.decode
        )
    }
```

## Dependencies
Uses Swift pakage manager as dependency manager.
Requares local module [ApiProvider](https://github.com/descorp/around-me/edit/develop/ApiProvider/README.md).
