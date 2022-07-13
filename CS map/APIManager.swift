//
//  APIManager.swift
//  CS map
//
//  Created by Аркадий Торвальдс on 11.07.2022.
//

import Foundation
import FirebaseFirestore
import MapKit


class APIManager {
    
    static let shared = APIManager()
//    public typealias GeoPoint = CLLocationCoordinate2D
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func writeTrack(name: String, locationsList: [CLLocationCoordinate2D]) {
        print("write start")
        let db = configureFB()
        let geoPointArray = locationsList.map { (elem) -> GeoPoint in
            let newElem = GeoPoint(latitude: elem.latitude, longitude: elem.longitude)
            return newElem
        }
        db.collection("tracks").addDocument(data: [
            "trackName": name,
            "trackPoints": geoPointArray
        ]) { err in
            if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
        print("write stop")
    }
    
    @objc func getTracks(completion: @escaping (Array<String>?) -> Void) {
        print("getTracks start")
        let db = configureFB()
        db.collection("tracks").getDocuments() { (querySnapshot, error) in
            guard error == nil else { completion(nil); return }
            print(querySnapshot?.count)
            var trackList: [String] = []
            for elem in querySnapshot!.documents {
                trackList.append(elem.documentID)
            }
            print("end")
            completion(trackList)
    }
    }
    
//    func getPost(collection: String, docName: String, completion: @escaping (trackGPS?) -> Void) {
//        let db = configureFB()
//        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
//            guard error == nil else { completion(nil); return }
//            var docSrc = Document(name: document?.get("name") as! String, locations: document?.get("locations") as! Array<GeoPoint>)
////            var doc = trackGPS(name: String, locations: [CLLocationCoordinate2D])
//            doc.name = docSrc.name
//            doc.locations = docSrc.locations.map { (elem) -> CLLocationCoordinate2D in
//                var newElem = CLLocationCoordinate2D()
//                newElem.longitude = elem.longitude
//                newElem.latitude = elem.latitude
//                return newElem
//            }
//            print(doc.name)
//            completion(doc)
//    }
//    )}
    
//    func addTrack(name: String, completion: @escaping (Bool) -> ()) {
//        let addPoints: [GeoPoint]
////        addPoints = [GeoPoint: (56.304067, 40.633854), GeoPoint: (56.404067, 40.733854), GeoPoint: (56.504067, 40.833854)]
//        var ref: DocumentReference? = nil
//        let db = configureFB()
//        ref = db.collection("cars").addDocument(data: [
//            "name": "первая запись"
//
//        ])
//    }
    
//    func myGetPost(collection: String, docName: String, completion: @escaping (Document?) -> Void) {
//        print("myGetPost started")
//        let db = configureFB()
//        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
//            guard error == nil else { completion(nil); return }
//            let doc = Document(name: document?.get("name") as! String, locations: document?.get("locations") as! Array<GeoPoint>)
//            completion(doc)
//        }
//    )}
}

