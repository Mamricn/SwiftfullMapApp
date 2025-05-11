//
//  LocatiosView.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 09/05/2025.
//

import SwiftUI
import MapKit




struct LocatiosView: View {
    @EnvironmentObject var vm: LocationsViewModel
    

    
    var body: some View {
       
        ZStack {
            Map(position: $vm.mapRegion){
                
            }
            
            
            VStack (spacing: 0){
                header
                
                Spacer()
            }
        }
        
        
        
           
        
    }
}
#Preview {
    LocatiosView()
        .environmentObject(LocationsViewModel())
}



extension LocatiosView {
    
    
    private var header: some View{
        VStack {
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.up")
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            }

            
            if vm.showLocationList{
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}
