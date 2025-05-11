//
//  LocationDetailView.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 07/05/2025.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
   
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    var body: some View {
        ScrollView {
            VStack{
               
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
               
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                       
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            
            .background(.ultraThinMaterial)
            .overlay(alignment: .topLeading) {
                backButton
            }
            
        }
        
        
        
    }
    
}


#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}




extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self){image in
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height:500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        
    }
    
    private var descriptionSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link){
                Link("Read more on Wikipedia", destination:url)
                    .font(.headline)
                    .tint(Color.blue)
            }
        }
    }
    
    
    private var mapLayer: some View {
        
        Map(position: $vm.mapRegion){
            ForEach([location]){ location in
//                Marker(location.name, coordinate: location.coordinates)
                Annotation(location.name,
                           coordinate: location.coordinates){
                    LocationMapAnnotationView()
                }
            }
        }
        .onAppear {
                // Set appropriate zoom level when the view appears
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                vm.mapRegion = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: location.coordinates,
                        span: span
                    )
                )
            }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
        
        
        // vm odwoluje sie do foldera LocationsViewModel
        //a wszystko po vs. to sa osobne funckcje
//        Map(position: $vm.mapRegion){
//            ForEach(vm.locations){ location in
//                Marker(location.name, coordinate: location.coordinates)
//            }
//            
//        }
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.primary)
                .background(.thickMaterial)
                .cornerRadius(20)
                .shadow(radius: 4)
                .padding()
                
        }

    }
    
}



