//
//  InglabAssessmentFetchPeopleTests.swift
//  InglabAssessmentTests
//
//  Created by Mohamed Fawzy on 10/10/2022.
//

import XCTest
@testable import InglabAssessment

final class InglabAssessmentFetchPeopleTests: XCTestCase {
    var sut: PeopleViewModel!
    
    func viewModel(data: [Person], error: ServiceError? = nil) -> PeopleViewModel {
        return PeopleViewModel(service: MockPeopleService(data: data, error: error))
    }
    
    override func tearDown()  {
        sut = nil
    }
    
    func test_fetch_people_when_all_users_not_active() {
        // given
        var data = [Person]()
        (1...20).forEach { i in
            data.append(
                makePerson(isActive: false, index: i)
            )
        }
        sut = viewModel(data: data)
        let expectaion = expectation(description: "fetch people expectation")
        let expected = [Person]()
        var actual: [Person]?
        // when
        sut.onError { result in
            fatalError("not expected to get an error")
        }
        sut.onDataUpdate { [weak self] in
            actual = self?.sut.activePeople
            expectaion.fulfill()
        }
        sut.fetchActivePeople()
        // then
        wait(for: [expectaion], timeout: 0.1)
        XCTAssertEqual(expected, actual)
    }
    
    func test_fetch_people_when_notSorted_should_be_sorted() {
        // given
        let p1 = makePerson(isActive: true, index: 1)
        let p2 = makePerson(isActive: false, index: 2)
        let p3 = makePerson(isActive: true, index: 3)
        let data = [p2, p1, p3] // not sorted data
        sut = viewModel(data: data)
        let expectaion = expectation(description: "fetch people expectation")
        let expected = [p1,p3]
        var actual: [Person]?
        // when
        sut.onError { result in
            fatalError("not expected to get an error")
        }
        sut.onDataUpdate { [weak self] in
            actual = self?.sut.activePeople
            expectaion.fulfill()
        }
        sut.fetchActivePeople()
        // then
        wait(for: [expectaion], timeout: 0.1)
        XCTAssertEqual(expected, actual)
    }
    
    func test_fetch_people_when_filtering_peopleNames_contains_substring() {
        // given
        let p1 = makePerson(isActive: true, index: 1, name: "Add")
        let p2 = makePerson(isActive: true, index: 2, name: "bbA")
        let p3 = makePerson(isActive: true, index: 3, name: "CC")
        let data = [p1, p2, p3]
        let filterText = "a"
        sut = viewModel(data: data)
        let expectaion = expectation(description: "fetch people expectation")
        let expected = [p1, p2] // only  both contains 'a'
        var actual: [Person]?
        var counter = 1
        // when
        sut.onError { result in
            fatalError("not expected to get an error")
        }
        sut.onDataUpdate { [weak self] in
            actual = self?.sut.activePeople
            if counter == 1 {
                counter += 1
                self?.sut.filterBy(text: filterText)
                return
            }
            expectaion.fulfill()
        }
        sut.fetchActivePeople()
        // then
        wait(for: [expectaion], timeout: 1)
        XCTAssertEqual(expected, actual)
    }
    
    func test_fetch_people_when_receiving_networkError() {
        // given
        sut = viewModel(data: [], error: ServiceError.network)
        let expectaion = expectation(description: "fetch people expectation")
        let expected = ServiceError.network.description
        var actual: String?
        // when
        sut.onError { result in
            actual = result
            expectaion.fulfill()
        }
        sut.onDataUpdate {
            fatalError("not expected to get data result")
        }
        sut.fetchActivePeople()
        // then
        wait(for: [expectaion], timeout: 0.1)
        XCTAssertEqual(expected, actual)
    }
    
    func test_fetch_people_when_receiving_parsingError() {
        // given
        sut = viewModel(data: [], error: ServiceError.parsing)
        let expectaion = expectation(description: "fetch people expectation")
        let expected = ServiceError.parsing.description
        var actual: String?
        // when
        sut.onError { result in
            actual = result
            expectaion.fulfill()
        }
        sut.onDataUpdate {
            fatalError("not expected to get data result")
        }
        sut.fetchActivePeople()
        // then
        wait(for: [expectaion], timeout: 0.1)
        XCTAssertEqual(expected, actual)
    }
    
    func test_fetch_people_when_receiving_unknownError() {
        // given
        sut = viewModel(data: [], error: ServiceError.unknown)
        let expectaion = expectation(description: "fetch people expectation")
        let expected = ServiceError.unknown.description
        var actual: String?
        // when
        sut.onError { result in
            actual = result
            expectaion.fulfill()
        }
        sut.onDataUpdate {
            fatalError("not expected to get data result")
        }
        sut.fetchActivePeople()
        // then
        wait(for: [expectaion], timeout: 0.1)
        XCTAssertEqual(expected, actual)
    }
}

fileprivate class MockPeopleService: PeopleServiceProtocol {
    let error: ServiceError?
    let data: [Person]
    
    init(data: [Person], error: ServiceError?) {
        self.data = data
        self.error = error
    }
    
    func fetchAllPeople(completion: @escaping (Result<[InglabAssessment.Person], InglabAssessment.ServiceError>) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let error = self.error {
                completion(.failure(error))
            } else {
                completion(.success(self.data))
            }
        }
    }
}

fileprivate func makePerson(isActive: Bool, index: Int, name: String = "") -> Person {
    return Person(avatar: "", name: name, phone: "", email: "", isActive: isActive, index: index)
}
