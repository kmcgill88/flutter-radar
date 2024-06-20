//
//  RadarMap.swift
//  flutter_radar
//
//  Created by Kevin McGill on 6/19/24.
//
import SwiftUI
import MapLibre

struct RadarMap: UIViewRepresentable {
    
    func makeCoordinator() -> RadarMap.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MLNMapView {
        // create a map

        let style = "radar-default-v1"
        let publishableKey = "prj_test_pk_7214e93df68904e6e206575683bcf01a91cf9105"
        let styleURL = URL(string: "https://api.radar.io/maps/styles/\(style)?publishableKey=\(publishableKey)")

        let mapView = MLNMapView(frame: .zero, styleURL: styleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.logoView.isHidden = true

        mapView.setCenter(
          CLLocationCoordinate2D(latitude: 40.7342, longitude: -73.9911),
          zoomLevel: 11,
          animated: false
        )
        
        // add the Radar logo

        let logoImageView = UIImageView(image: UIImage(named: "radar-logo"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            logoImageView.leadingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoImageView.widthAnchor.constraint(equalToConstant: 74),
            logoImageView.heightAnchor.constraint(equalToConstant: 26)
        ])

        mapView.delegate = context.coordinator

        return mapView
    }
    
    func updateUIView(_ uiView: MLNMapView, context: Context) {}
    
    // add a marker on map load

    class Coordinator: NSObject, MLNMapViewDelegate {
        var control: RadarMap

        init(_ control: RadarMap) {
            self.control = control
        }

        func mapView(_ mapView: MLNMapView, didFinishLoading style: MLNStyle) {
            addMarker(style: style, coordinate: CLLocationCoordinate2D(latitude: 40.7342, longitude: -73.9911))
        }

        func addMarker(style: MLNStyle, coordinate: CLLocationCoordinate2D) {
            let point = MLNPointAnnotation()
            point.coordinate = coordinate

            let shapeSource = MLNShapeSource(identifier: "marker-source", shape: point, options: nil)

            let shapeLayer = MLNSymbolStyleLayer(identifier: "marker-style", source: shapeSource)

            if let image = UIImage(named: "default-marker") {
                style.setImage(image, forName: "marker")
            }

            shapeLayer.iconImageName = NSExpression(forConstantValue: "marker")

            style.addSource(shapeSource)
            style.addLayer(shapeLayer)
        }
    }
}
