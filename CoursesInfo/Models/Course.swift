//
//  Course.swift
//  CoursesInfo
//
//  Created by mac mini on 5/7/22.
//

import Foundation

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WebsiteDescriptions: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
