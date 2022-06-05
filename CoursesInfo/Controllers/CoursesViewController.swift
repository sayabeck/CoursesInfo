//
//  CoursesViewController.swift
//  CoursesInfo
//
//  Created by mac mini on 5/7/22.
//

import UIKit

class CoursesViewController: UITableViewController {
    
    var courses: [Course] = []
    var coursesV2: [CourseV2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.isEmpty ? coursesV2.count : courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseViewCell
        
        if courses.isEmpty {
            let courseV2 = coursesV2[indexPath.row]
            cell.configure(with: courseV2)
        } else {
            let course = courses[indexPath.row]
            cell.configure(with: course)
        }
        
        return cell
    }

//MARK: - Private function
    
    func fetchCourses() {
        NetworkManager.shared.fetch(dataType: [Course].self, from: Link.exampleTwo.rawValue) {result in
            switch result {
            case .success(let courses):
                self.courses = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCoursesV2() {
        NetworkManager.shared.fetch(dataType: [CourseV2].self,
                                    from: Link.exampleFive.rawValue,
                                    convertFromSnakeCase: false) { result in
            switch result {
            case .success(let courses):
                self.coursesV2 = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}
