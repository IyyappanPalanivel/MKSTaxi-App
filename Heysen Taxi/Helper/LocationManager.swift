//
//  LocationManager.swift
//  HyraApp
//
//  Created by muthuraja on 03/06/21.
//
 
 import Foundation
 import CoreLocation
 import SwiftyJSON

enum GooglePlaceType {
    case drag
    case place
}

protocol SelectionLocationDelegate {
    func didUpdatePlace(withLocation selectLoc: SelectLocationModel)
}

struct SelectLocationModel {
    var fullAddress = ""
    var coordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var country     = ""
    var address     = ""
    var state       = ""
    var city        = ""
    var street      = ""
    var area        = ""
    var zipcode     = ""
}
 
 class LocationManager {
    
    public static let sharedInstance = LocationManager()
    public typealias AddressType = (Bool, SelectLocationModel) -> Void
    
    private init() { }
    
    func getLocationBetweenTwoCoordinates(from source: CLLocation, to destination: CLLocation) -> CLLocationDistance {
        return source.distance(from: destination)
    }
    
    func getAddress(withLat latitude: String, withLong longitude: String, completionHandler: @escaping AddressType) {
        var locationCoordinate = CLLocationCoordinate2D()
        let geoCoder = CLGeocoder()
        locationCoordinate.latitude = Double(latitude)!
        locationCoordinate.longitude = Double(longitude)!
        
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                completionHandler(false, SelectLocationModel())
                return
            }
            
            if let placeMarks = placemarks {
                if placeMarks.count > 0 {
                    let firstPlacemark = placeMarks.first!
                    var address = ""
                    var selectedLocation = SelectLocationModel()
                    if firstPlacemark.thoroughfare != nil {
                        address = address + firstPlacemark.thoroughfare! + ", "
                        selectedLocation.street = firstPlacemark.thoroughfare!
                     }
                    
                    if firstPlacemark.subThoroughfare != nil {
                         address = address + firstPlacemark.subThoroughfare! + ", "
                        selectedLocation.area = firstPlacemark.subThoroughfare!
                    }
                    
                    
                    if firstPlacemark.subLocality != nil {
                        address = address + firstPlacemark.subLocality! + ", "
                        selectedLocation.address = firstPlacemark.subLocality!
                    }
                
                    if firstPlacemark.locality != nil {
                        address = address + firstPlacemark.locality! + ", "
                        selectedLocation.city = firstPlacemark.locality!
                    }
                
                    if firstPlacemark.country != nil {
                        address = address + firstPlacemark.country! + ", "
                        selectedLocation.country = firstPlacemark.country!
                    }
                
                
                    if firstPlacemark.administrativeArea != nil {
                        selectedLocation.state = firstPlacemark.administrativeArea!
                   }
                    print("REVERSE GEOCODING ADDRESS : \(address)")
                    selectedLocation.coordinates = locationCoordinate
                    selectedLocation.fullAddress = address
                    completionHandler(true, selectedLocation)
                }
            }
        }
    }
 }
