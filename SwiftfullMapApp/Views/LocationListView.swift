//
//  LocationListView.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 10/05/2025.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations) { location in
                Button(action: {
                    vm.showNextLocation(location: location)
                }, label: {
                    listRowView(location: location)
                    })
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
           
        }
        .listStyle(PlainListStyle())
        
        
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationsViewModel())
}


extension LocationListView {
    private func listRowView(location: Location)-> some View{
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFit( )
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(location.cityName)
                
            }
            .frame(maxWidth:.infinity, alignment: .leading)

        }
    }
}
