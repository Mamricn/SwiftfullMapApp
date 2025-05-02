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
    

    var body: some View {
        ZStack{
            // vm odwoluje sie do foldera LocationsViewModel
            //a wszystko po vs. to sa osobne funckcje 
            Map(position: $vm.mapRegion)
            
            VStack(spacing:0){
               header
                    .padding()
                
                Spacer()
            }
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
}
