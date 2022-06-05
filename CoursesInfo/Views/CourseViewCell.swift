//
//  CourseViewCell.swift
//  CoursesInfo
//
//  Created by mac mini on 5/7/22.
//

import UIKit

class CourseViewCell: UITableViewCell {

    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lessonsLabel: UILabel!
    @IBOutlet weak var testsLabel: UILabel!
    
    func configure(with course: Course) {
        
        nameLabel.text = course.name
        lessonsLabel.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        testsLabel.text = "Number of tests: \(course.numberOfTests ?? 0)"
        NetworkManager.shared.fetchImage(from: course.imageUrl) { result in
            switch result {
            case .success(let imageData):
                self.courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configure(with courseV2: CourseV2) {
        
        nameLabel.text = courseV2.name
        lessonsLabel.text = "Number of lessons: \(courseV2.numberOfLessons ?? 0)"
        testsLabel.text = "Number of tests: \(courseV2.numberOfTests ?? 0)"
        NetworkManager.shared.fetchImage(from: courseV2.imageUrl) { result in
            switch result {
            case .success(let imageData):
                self.courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
