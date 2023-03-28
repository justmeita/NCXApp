// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let geocoderInfo = try? JSONDecoder().decode(GeocoderInfo.self, from: jsonData)

import Foundation

// MARK: - GeocoderInfoElement
struct GeocoderInfoElement: Codable {
    var name: String
    var localNames: LocalNames?
    var lat, lon: Double
    var country: String
    var state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    var af, ar: String?
    var ascii: String?
    var az, bg, ca, da: String?
    var de, el: String?
    var en: String?
    var eu, fa: String?
    var featureName: String?
    var fi, fr, gl, he: String?
    var hi, hr, hu, id: String?
    var it, ja, la, lt: String?
    var mk, nl, no, pl: String?
    var pt, ro, ru, sk: String?
    var sl, sr, th, tr: String?
    var vi, zu: String?

    enum CodingKeys: String, CodingKey {
        case af, ar, ascii, az, bg, ca, da, de, el, en, eu, fa
        case featureName = "feature_name"
        case fi, fr, gl, he, hi, hr, hu, id, it, ja, la, lt, mk, nl, no, pl, pt, ro, ru, sk, sl, sr, th, tr, vi, zu
    }
}

typealias GeocoderInfo = [GeocoderInfoElement]
