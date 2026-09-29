//
//  Task.swift
//  photoScavengerHunt
//
//  Created by Snezhana Valchuk on 3/19/23.
//

import UIKit
import CoreLocation

class Task {
    let title: String
    let description: String
    var image: UIImage?
    var imageLocation: CLLocation?
    var isComplete: Bool {
        image != nil
    }

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    func set(_ image: UIImage, with location: CLLocation) {
        self.image = image
        self.imageLocation = location
    }
}


extension Task {
    static var mockedTasks: [Task] {
        return [
            Task(title: "Favorite place to study 📚",
                 description: "Take a picture of your favorite place to get work done."),
            Task(title: "Favorite lunch spot 🍔",
                 description: "Take a picture of your favorite meal at your favorite spot."),
            Task(title: "Favorite place to spend your free time 🤔",
                 description: "Take a picture of where you like to be/go when you have free time."),
            Task(title: "Least favorite class 😩",
                 description: "Take a picture of you in your least favorite class."),
            Task(title: "Favorite class 🥰",
                 description: "Take a picture of you in your favorite class.")
        ]
    }
}

