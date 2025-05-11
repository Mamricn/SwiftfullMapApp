//
//  LocationPreviewView.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 10/05/2025.
//

import SwiftUI

struct LocationPreviewView: View {
    
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                
                titleSection
            }
            VStack{
                LearnMoreButton
                NextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
               
        )
        .clipped()

        
        
        
    }
}






#Preview {
    ZStack{
        Color.green.ignoresSafeArea(edges: .all)
        LocationPreviewView(location: LocationsDataService.locations.first!)
    }
   
}









extension LocationPreviewView {
    private var imageSection: some View {
        ZStack{
            if let image = location.imageNames.first{
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
   private var LearnMoreButton: some View {
        VStack{
            Button {
                
            } label: {
                Text("Learn more")
                    .frame(width: 125, height: 35)
                   
            }
            .buttonStyle(.bordered)
            
          

        }
        
    }


private var NextButton: some View {
    VStack{
        Button {
            
        } label: {
            Text("Next")
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)

    }
    
}
}
