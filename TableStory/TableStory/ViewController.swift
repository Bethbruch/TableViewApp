//
//  ViewController.swift
//  TableStory
//
//  Created by Bruch, Beth on 3/20/24.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Roppolos", neighborhood: "Downtown", desc: "Nobody is doing pizza in Downtown Austin like Roppolos. This Austin classic is beloved by locals and tourists alike. The sicilian style pizza is located on 6th street, so get yourself a slice and check out austins more popular bar hopping streets.", lat: 30.267568101896323, long: -97.7396985023326, imageName: "rest1"),
    Item(name: "Franklin BBQ", neighborhood: "Downtown", desc: "It's criminal to come to Austin and not eat some TX BBQ. Franklin BBQ is one of Austin's more popular BBQ restaurants and for good reason. Their meat is barked and smoked to perfection. Their menu isn't the largest but we don't fuss about our meet here in Texas. If you're interested in checking Franklin BBQ out try and get there before 1pm, one they're out of meat they close up shop and the line is not forgiving. ", lat: 30.270291763574594, long: -97.73138481767585
    , imageName: "rest2"),
    Item(name: "Gus’s World Famous Fried Chicken", neighborhood: "Downtown", desc: "Nobody is cookin' up chicken like my man Gus. If you're on the hunt for some good ol' fashion soul food, this is the place for you. Their chicken is breaded and fried to perfection and they have some of the best collard green I've ever had! ", lat: 30.263730074787198, long: -97.74169135815359
    , imageName: "rest3"),
    Item(name: "Lick Honest Ice Cream", neighborhood: "South Lamar", desc: "Want a sweet treat that's just as weird as austin? Lick honest Ice Cream has a menu of evergreen and seasonal flavors that take a unique take on your favorite flavors. My personal favorite combo is vanilla and honey with mint and beet! ", lat: 30.25578631793456, long: -97.76262715952241, imageName: "rest4"),
    Item(name: "Soto", neighborhood: "South Lamar", desc: "Need a bite before heading to Alamo for your movie? Head over to soto for some killer sushi! This Upscale asian spot is perfect for anyone looking to enjoy the more high end food Austin has to offer.", lat: 30.255823387541348, long: -97.76205853122367, imageName: "rest5")
    
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        
        //Add image references
        let image = UIImage(named: item.imageName)
        cell?.imageView?.image = image
        cell?.imageView?.layer.cornerRadius = 5
        cell?.imageView?.layer.borderWidth = 2
        cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                // Pass the selected item to the detail view controller
                detailViewController.item = selectedItem
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 30.263730074787198, longitude: -97.74169135815359)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        mapView.setRegion(region, animated: true)
        
        // loop through the items in the dataset and place them on the map
        for item in data {
            let annotation = MKPointAnnotation()
            let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
            annotation.coordinate = eachCoordinate
            annotation.title = item.name
            mapView.addAnnotation(annotation)
        }
        
        
    }
    
}

