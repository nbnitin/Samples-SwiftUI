//
//  MapView.swift
//  PracticeSwiftUI
//
//  Created by Nitin Bhatia on 15/09/22.
//

import SwiftUI
import MapKit

struct MyCoordinates : Identifiable {
    let id = UUID()
    var coordinates : CLLocationCoordinate2D
}

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    @State var annotations: [MyCoordinates] = []
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    var body: some View {
        Map(coordinateRegion: $region,annotationItems: $annotations) {_ in
           // MapPin(coordinate: coordinate)
            
            MapAnnotation(
               coordinate: coordinate,
               content: {
                  Image(systemName: "pin.circle.fill").foregroundColor(.red)
                  Text("California")
               }
            )
            
//            MapAnnotation(coordinate: coordinate) {
//                Circle()
//                    .strokeBorder(.red, lineWidth: 4)
//                    .frame(width: 40, height: 40)
//            }
        }
    
            .onAppear{
                setRegion(coordinate)
                annotations = [
                    MyCoordinates( coordinates: coordinate)
                    ]
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))

    }
}
