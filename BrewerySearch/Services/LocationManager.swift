//
//  LocationManager.swift
//  BrewerySearch
//
//  Created by Robert Faist on 2/1/23.
//

import Foundation
import CoreLocation
import AsyncLocationKit
import Combine

protocol LocationManager: AnyObject {
    func getLastLocation() async throws -> CLLocation?
}

enum LocationManagerError: Error, CustomStringConvertible {
    case locationNotFound
    
    var description: String {
        switch self {
        case .locationNotFound:
            return "Location not found."
        }
    }
}

class LocationManagerImpl: NSObject, LocationManager {
    private let locationManager = AsyncLocationManager(desiredAccuracy: .bestAccuracy)
    
    override init() {
        super.init()
        
        Task {
            await locationManager.requestPermission(with: .whenInUsage)
        }
    }
    
    func getLastLocation() async throws -> CLLocation? {
        let locationAuthStatus = checkAuthorizationStatus()
        
        guard locationAuthStatus == .authorizedWhenInUse || locationAuthStatus == .authorizedAlways else {
            return nil
        }
        
        do {
            let locationEvent = try await locationManager.requestLocation()
            
            switch locationEvent {
            case .didUpdateLocations(let locations):
                if let firstLocation = locations.first {
                    return firstLocation
                }
            case .didFailWith(let error):
                throw error
                
            default:
                break
            }
        } catch {
            print("Location exception error \(error)")
        }
        
        return nil
    }
    
    private func checkAuthorizationStatus() -> CLAuthorizationStatus {
        self.locationManager.getAuthorizationStatus()
    }
}
