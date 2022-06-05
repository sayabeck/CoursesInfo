//
//  MainViewController.swift
//  CoursesInfo
//
//  Created by mac mini on 5/7/22.
//

import UIKit

enum UserAction: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
    case ourCoursesV2 = "Capital to Lowcase"
    case postRequestWithDict = "Post RQST with Dict"
    case postRequestWithModel = "POST RQST with Model"
}

class MainViewController: UICollectionViewController {
    private let reuseIdentifier = "cell"
    
    let userActions = UserAction.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showImage" {
            let coursesVC = segue.destination as! CoursesViewController
            switch segue.identifier {
            case "showCourses": coursesVC.fetchCourses()
            case "showCoursesV2": coursesVC.fetchCoursesV2()
            default: break
            }
        }
    }
    


//MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserActionCell
        
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }

//MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        
        case .downloadImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .exampleOne: exampleOnePressed()
        case .exampleTwo: exampleTwoPressed()
        case .exampleThree: exampleThreePressed()
        case .exampleFour: exampleFourPressed()
        case .ourCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        case .ourCoursesV2: performSegue(withIdentifier: "showCoursesV2", sender: nil)
        case .postRequestWithDict: postRequestWithDict()
        case .postRequestWithModel: postRequestWithModel()
        }
    }

    // MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

//MARK: - extension

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

extension MainViewController {
    private func exampleOnePressed() {
        NetworkManager.shared.fetch(dataType: Course.self, from: Link.exampleOne.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                print(error.localizedDescription)
                self.failedAlert()
            }
        }
    }
    
    private func exampleTwoPressed() {
        NetworkManager.shared.fetch(dataType: [Course].self, from: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.successAlert()
                for course in courses {
                    print("Course: \(course.name ?? "")")
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.failedAlert()
            }
        }
    }
    
    private func exampleThreePressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescriptions.self, from: Link.exampleThree.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.successAlert()
                print(websiteDescription)
            case .failure(let error):
                print(error.localizedDescription)
                self.failedAlert()
            }
        }
    }
    
    private func exampleFourPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescriptions.self, from: Link.exampleThree.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.successAlert()
                print(websiteDescription)
            case .failure(let error):
                print(error.localizedDescription)
                self.failedAlert()
            }
        }
    }
    
    private func postRequestWithDict() {
        let course = [
            "name": "Networking",
            "imageUrl": "image url",
            "numberOfLessons": "11",
            "numberOfTests": "9"
        ]
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
    
    private func postRequestWithModel() {
        let course = CourseV3(
            name: "Networking",
            imageUrl: Link.imageURL.rawValue,
            numberOfLessons: "10",
            numberOfTests: "8")
        
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
}
