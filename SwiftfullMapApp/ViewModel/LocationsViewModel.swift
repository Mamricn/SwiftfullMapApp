//
//  LocationsViewModel.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 09/05/2025.
//

import Foundation
import MapKit
import _MapKit_SwiftUI
import SwiftUI



class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    // cala array
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
     
    // lokalizacja kamery
    @Published var mapRegion: MapCameraPosition  = .region (MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    //show list of location
    @Published var showLocationList: Bool = false
    
    
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        updateMapRegion(location: locations.first!)
    }
    
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = .region(MKCoordinateRegion(
                center:location.coordinates,
                span: mapSpan))
        }
      
    }
    
    
     func toggleLocationList(){
        withAnimation(.easeInOut){
            showLocationList.toggle()
        }
    }
    
    
    func showNextLocation(location: Location){
        
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationList = false
        }
    }
    
    
}
