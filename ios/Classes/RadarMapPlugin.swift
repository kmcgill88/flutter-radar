//
//  RadarMapPlugin.swift
//  flutter_radar
//
//  Created by Kevin McGill on 6/19/24.
//
class RadarMapPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = RadarMapFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "com.radar.map")
    }
}
