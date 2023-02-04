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
        let imagesRepository = ImageRepositoryMock()
        imagesRepository.expectation = self.expectation(description: "Image with download")
        let expectedImage = UIImage(named: "test")
        imagesRepository.image = expectedImage

        let sut = UIImageView()
        _ = sut.downloaded(imageLoader: imagesRepository, from: "url") {
            DispatchQueue.main.async {
                XCTAssertEqual(sut.image, expectedImage)
            }
        }
        // then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
