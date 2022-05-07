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
        lessonsLabel.text = "Number of lessons: \(course.number_of_lessons ?? 0)"
        testsLabel.text = "Number of tests: \(course.number_of_tests ?? 0)"
        
        DispatchQueue.global().async {
            guard let url = URL(string: course.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.courseImage.image = UIImage(data: imageData)
            }
            
        }
        
    }
    
}
