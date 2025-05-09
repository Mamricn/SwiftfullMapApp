//
//  LocationsViewModel.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 30/04/2025.
//

//import Foundation
//import MapKit
//import _MapKit_SwiftUI
//
//
//class LocationsViewModel: ObservableObject {
//    
//    //All loaded locations
//    @Published var locations: [Location]
//    // Current location on the map
//    @Published var mapLocation: Location
//        didSet{
//        updateMapRegion(location: mapLocation)
//    }
//    
//    
//    @Published var mapRegion: MapCameraPosition = .region (MKCoordinateRegion())
//    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    
//    init(){
//        let locations = LocationsDataService.locations
//        self.locations = locations
//        self.mapLocation = locations.first!
//        
//        self.updateMapRegion(location: locations.first!)
//        /* self.location to jest to samo co var location wyzej self.jest po to zeby przpisac do niego location z dataSerivce
//         init odpla sie pierwsze przed ladowaniem 
//         
//         */
//        
//    }
//    
//    
//    private func updateMapRegion(location: Location){
//        mapRegion = .region (MKCoordinateRegion(
//                center: location.coordinates,
//                span: mapSpan))
//        
//    }
//    
//}
//


import Foundation
import MapKit
import _MapKit_SwiftUI
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // tu wszyskie dane z array
    @Published var locations: [Location]
    // tu bedzie przypisana pierwsza lokalizacja tylko jedna
    @Published var mapLocation: Location {
        didSet {
            //tu  jak sie przycisnie przycisk automatycznie zaladuje sie kolejna lokalizacja
            updateMapRegion(location: mapLocation)
        }
    }
    
    
    
    //tu pozycja kamery
    @Published var mapRegion: MapCameraPosition = .automatic
    
    //show list of location
    @Published var showLocationList: Bool = false
    
    
    //Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    // tu odleglosc w skali jak daleko ma byc oddalona mapa
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    
    
    
    
    // to wszytsko sie zaladuje przy wywolaniu LocationsViewModel
    init() {
        // let location pobiera z array wszytskie lokalizacje
        let locations = LocationsDataService.locations
        // ten var z gory dostaje update z wszyskimi lokalizacjami
        self.locations = locations
        // ustawiony jest pierwsza localisation z array
        self.mapLocation = locations.first! // didSet NIE działa tutaj
        
        //wywolanie funkcji oraz zmiana na kolejna lokalizacje  mapLocation(czyli pierwsza lokalizacja )
        updateMapRegion(location: mapLocation) // więc wywołujemy ręcznie
    }
    
    
    
    
    
    
    // funkcja ktora zmienia localisation
    private func updateMapRegion(location: Location) {
        //przypisanie lokalizacji
        let region = MKCoordinateRegion(
            //maplocation czyli jeden z lokalizacji i pobrane z array coordinates czyli jeden z wielu podpunktu ktory mozna pobrac
            center: location.coordinates,
            // map Span czyli jak daleko ma byc mapa ustawiona u gory jest przypisane jak daleko ma byc mapa
            span: mapSpan)
        
        
        mapRegion = .region(region)
        
    }
    
    
    
    
    func toggleLocationList() {
        showLocationList.toggle()
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationList = false
        }
        
    }
        
        func nextButtonPressed(){
            // get the current locations
            
        // przypisuje do currentIndex index ktory jest rowny mapLocation(aktualne miejsce na mapie )
            guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
                print("Could not find current index! in locations array! Should never happen!")
                return
            }
            //Check if the currentIndex is valid
            
            // nextIndex dodaje do bierzacego +1
            let nextIndex = currentIndex + 1
            //sprawdza czy currentIndex +1 znajduje sie w array jezeli nie 
            guard locations.indices.contains(nextIndex) else {
                // next location is valid
                // restart from 0
                // jezeli w array jest 5 itemow a currentIndex + 1 rowny jest 6 zaczyna do mapLocation zostaje przypisana pierwsza lokalizacja 
                guard let firstLocation = locations.first else { return }
                showNextLocation(location: firstLocation)
                return
            }
            // next idndex is valid
            let nextLocation = locations[nextIndex]
            showNextLocation(location: nextLocation)
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    //  LocationsViewModel.swift
    //  SwiftfullMapApp
    //
    //  Created by Marcin Turek on 30/04/2025.
    //
    //
    //import Foundation
    //import MapKit
    //import _MapKit_SwiftUI
    //
    // Klasa odpowiadająca za zarządzanie danymi lokalizacji oraz stanem mapy
    //class LocationsViewModel: ObservableObject {
    //
    //    // Wszystkie dostępne lokalizacje pobrane z LocationsDataService (np. z JSON lub mocku)
    //    @Published var locations: [Location]
    //
    //    // Aktualnie wybrana lokalizacja na mapie
    //    // Kiedy zostanie zmieniona (np. przez kliknięcie), automatycznie aktualizuje region mapy
    //    @Published var mapLocation: Location {
    //        didSet {
    //            // Aktualizacja regionu mapy przy każdej zmianie lokalizacji
    //            updateMapRegion(location: mapLocation)
    //        }
    //    }
    //
    //    // Aktualna pozycja "kamery" mapy – czyli widoczny region
    //    @Published var mapRegion: MapCameraPosition = .automatic
    //
    //    // Ustalony poziom oddalenia mapy (zoom)
    //    private let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    //
    //    // Inicjalizator – uruchamiany przy starcie aplikacji lub gdy tworzony jest ViewModel
    //    init() {
    //        // Pobranie listy lokalizacji z "bazy danych" (mock danych)
    //        let locations = LocationsDataService.locations
    //
    //        // Przypisanie lokalizacji do zmiennej @Published – dzięki temu interfejs zostanie zaktualizowany
    //        self.locations = locations
    //
    //        // Ustawienie pierwszej lokalizacji jako domyślnej (startowej)
    //        // Używamy force unwrap (!), ale w praktyce lepiej byłoby to zabezpieczyć
    //        self.mapLocation = locations.first!
    //
    //        // Ręczne wywołanie funkcji aktualizacji mapy,
    //        // ponieważ `didSet` nie działa przy inicjalizacji zmiennej w `init()`
    //        updateMapRegion(location: mapLocation)
    //    }
    //
    //    // Funkcja odpowiedzialna za aktualizację widocznego regionu mapy
    //    // Ustawia środek mapy (center) i zoom (span) na podstawie lokalizacji
    //    private func updateMapRegion(location: Location) {
    //        let region = MKCoordinateRegion(
    //            center: location.coordinates,   // środek mapy – współrzędne lokalizacji
    //            span: mapSpan                   // stopień oddalenia mapy
    //        )
    //
    //        // Aktualizacja zmiennej mapRegion – zmiana widoczna w Map w interfejsie
    //        mapRegion = .region(region)
    //    }
    //}
}
