//
//  LocationsView.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 28/04/2025.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    
    let maxWidthForIpad: CGFloat = 400
    

    var body: some View {
        ZStack{
            mapLayer
            
            VStack(spacing:0){
               header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
                
            }
            
            
            if vm.showLocationList {
                LocationsListView()
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
    
    
    private var mapLayer: some View {
        // vm odwoluje sie do foldera LocationsViewModel
        //a wszystko po vs. to sa osobne funckcje
        Map(position: $vm.mapRegion){
            ForEach(vm.locations){ location in
                //                Marker(location.name, coordinate: location.coordinates)
                Annotation(location.name,
                           coordinate: location.coordinates){
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1.0 : 0.7)
                }
            }
            
        }
    }
    
    private var locationsPreviewStack: some View{
        ZStack{
            // tu sie loop robi z calej array locations vm znaczy ze to jest z innej storny pobierane
            ForEach(vm.locations){ location in
                //jeszeli aktualna lokalizacja mapy jest rowna jedna z tych z array to wyswietli sie tylko jedno zdjecie
                if vm.mapLocation == location{
                    //tu jest reference do stworzonej juz strony i ona ma zostac
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading)))
                }
            }                }
    }
    
    
    
    
    
    
}
