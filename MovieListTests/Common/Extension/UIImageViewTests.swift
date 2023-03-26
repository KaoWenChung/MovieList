//
//  UIImageViewTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/2/4.
//

import XCTest
@testable import MovieList

final class UIImageViewTests: XCTestCase {
    class ImageRepositoryMock: ImageRepositoryType {
        var expectation: XCTestExpectation?
        var image: UIImage?
        func fetchImage(with imagePath: String, completion: @escaping (UIImage?) -> Void) -> CancellableType? {
            expectation?.fulfill()
            completion(image)
            return nil
        }
    }

    func testUIImageViewTests_downloadImageSuccessfully_getImage() {
        let imageRepository = ImageRepositoryMock()
        imageRepository.expectation = self.expectation(description: "Image with download")
        let expectedImage = UIImage(named: "test")
        imageRepository.image = expectedImage

        let sut = UIImageView()
        _ = sut.downloaded(imageLoader: imageRepository, from: "url") {
            DispatchQueue.main.async {
                XCTAssertEqual(sut.image, expectedImage)
            }
        }
        // then
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testUIImageViewTests_downloadImageFailure_getPlaceholderImage() {
        let imageRepository = ImageRepositoryMock()
        imageRepository.expectation = self.expectation(description: "Should run error and present placeholer image")

        let sut = UIImageView()

        _ = sut.downloaded(imageLoader: imageRepository, from: "url", placeholderImage: "noImage") {
            DispatchQueue.main.async {
                XCTAssertEqual(sut.image, UIImage(named: "noImage"))
            }
        }
        // then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
