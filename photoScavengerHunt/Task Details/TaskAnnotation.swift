//
//  TaskAnnotation.swift
//  photoScavengerHunt
//
//  Created by Snezhana Valchuk on 3/19/23.
//

import UIKit
import MapKit

class TaskAnnotationView: MKAnnotationView {

    static var identifier = "TaskAnnotationView"

    // Some constants to use when sizing the various views
    enum Constants {
        static let containerViewHeight: CGFloat = 80
        static let containerViewCornerRadius: CGFloat = 16
        static let imageViewPadding: CGFloat = 4
        static var pointerViewHieght: CGFloat { containerViewHeight / 3 }

        // The distance the pointer view extends downwards after rotation. Half of the hypotenuse of the view.
        static var pointerViewHeightAfterRotation: CGFloat { pointerViewHieght * sqrt(2) / 2 }
    }

    // The image view to show the image in the annotation.
    var imageView = UIImageView()

    // Init for MKAnnotationView
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    // Required init. After adding the above init, Xcode will give error/suggestion to add this method.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Use this method to pass in and set the image for the annotation.
    func configure(with image: UIImage?) {
        imageView.image = image ?? UIImage(systemName: "pin.fill")
    }

    // Internal funtion to do initial view setup
    private func setupViews() {

        // Container View: The main view for our annotation view
        let containerView = UIView()

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius

        // Add the container view to the view hierarchy.
        addSubview(containerView)

        // Set the programmatic auto-layout constraints (in this case height / width)
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: Constants.containerViewHeight),
            containerView.widthAnchor.constraint(equalToConstant: Constants.containerViewHeight)
        ])

        // Pointer View: View that forms the "pointer" tip at the bottom of the annotation view which points to the location.
        let pointerView = UIView()
        pointerView.translatesAutoresizingMaskIntoConstraints = false
        pointerView.backgroundColor = .systemBackground
        pointerView.layer.cornerRadius = 4

        containerView.addSubview(pointerView)
        NSLayoutConstraint.activate([
            pointerView.heightAnchor.constraint(equalToConstant: Constants.pointerViewHieght),
            pointerView.widthAnchor.constraint(equalToConstant: Constants.pointerViewHieght),
            // (X-axis) Pointer view should be centered in the container view.
            pointerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            // (Y-axis) The center of the pointer view should be placed on the bottom edge of the container view.
            pointerView.centerYAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])


        let fortyFiveDegreesInRadians = 45 * CGFloat.pi / 180
        pointerView.transform = CGAffineTransform(rotationAngle: fortyFiveDegreesInRadians)

        // Image View
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.containerViewCornerRadius - Constants.imageViewPadding

        // Make sure the image doesn't extend beyond the image view bounds.
        imageView.clipsToBounds = true

        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.imageViewPadding),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.imageViewPadding),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.imageViewPadding),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.imageViewPadding),
        ])

        centerOffset = CGPoint(x: -(Constants.containerViewHeight / 2),
                               y: -Constants.containerViewHeight - Constants.pointerViewHeightAfterRotation)

        // UI Candy: Add a subtle shadow to help the annotation stand out visually against the map view.
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
    }
}
