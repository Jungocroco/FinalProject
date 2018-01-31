import UIKit
import MapKit
import CoreLocation
import Contacts
import YelpAPI
import BrightFutures

class MapViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    // outlet
    @IBOutlet weak var map: MKMapView!
    
    // vars & lets
    var storeLatitude = Double()
    var storeLongitude = Double()
    var storeName = String()
    var storeCity = String()
    var storeAddress = String()
    var pin: StorePin?
    var storeArray = [YLPBusiness]()
    var pinArray = [MKAnnotation]()
    var storeSite = String()
    var webViewUrl: URL?
    let webSegueIdentifier = "showWebSegue"
    
    
    // location manager to trigger user tracking
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Print for test
//        print(storeLatitude)
//        print(storeLongitude)
//        print(storeName)
//        print(storeAddress)
        
        // appends specific storedetails to array
        for i in 0...(storeArray.count-1) {
            pinArray.append(StorePin(title: storeArray[i].name, city: storeArray[i].location.city, address: storeArray[i].location.address.first!, coordinate: CLLocationCoordinate2DMake((storeArray[i].location.coordinate?.latitude)!, (storeArray[i].location.coordinate?.longitude)!), url: storeArray[i].url))
            // adds pins to mapview
            map.addAnnotation(pinArray[i])
        }
        
        // data for mapcentering
        let location = CLLocationCoordinate2DMake(storeLatitude, storeLongitude)
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegionMake(location, span)
        
        map.delegate = self
        
        // initialization of user tracking
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        map.setRegion(region, animated: true)
        
        setupCompassButton()
        setupUserTrackingButtonAndScaleView()
        }
    
    // creates a compass in the map
    func setupCompassButton() {
        let compass = MKCompassButton(mapView: map)
        compass.compassVisibility = .visible
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
        map.showsCompass = false
    }
    
    //
    func setupUserTrackingButtonAndScaleView() {
        map.showsUserLocation = true
        
        let button = MKUserTrackingButton(mapView: map)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        map.addSubview(button)
        
        // Not working? DELETE
        let scale = MKScaleView(mapView: map)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        map.addSubview(scale)
        
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == webSegueIdentifier,
            let destination = segue.destination as? WebViewController {
            destination.url = webViewUrl
        }
    }
    
}

// extension for the initialization of custom pin callouts, images and functions
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ map: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? StorePin else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = map.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            
            let leftItemTag = 1
            let leftLinkButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            leftLinkButton.setBackgroundImage(UIImage(named: "assortment"), for: UIControlState())
            leftLinkButton.tag = leftItemTag
            view.leftCalloutAccessoryView = leftLinkButton
            
            let rightItemTag = 2
            let rightMapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            rightMapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
            rightMapsButton.tag = rightItemTag
            view.rightCalloutAccessoryView = rightMapsButton
            
            view.glyphImage = UIImage(named: "vinyl-small")
            view.markerTintColor = UIColor.black
        }
        return view
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        let pin = view.annotation as! StorePin
        
        // IMPLEMENT UISiteView
        
        if control.tag == 2 {
            let location = view.annotation as! StorePin
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMaps(launchOptions: launchOptions)
        // To first Google result or Yelp
        } else if control.tag == 1 {
            if let url = URL(string: "https://www.google.nl/search?q=\(pin.title!)+\(pin.city!)&btnI=1") {
                self.webViewUrl = url
                performSegue(withIdentifier: "showWebSegue", sender: self)
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
                self.webViewUrl = pin.url
                performSegue(withIdentifier: "showWebSegue", sender: self)
//                UIApplication.shared.open(pin.url, options: [:], completionHandler: nil)
            }
        }
    }
}
