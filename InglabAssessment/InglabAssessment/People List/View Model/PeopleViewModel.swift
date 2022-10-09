//
//  PeopleViewModel.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation

protocol PeopleViewModelProtocol {
    func fetchActivePeople()
    func onDataUpdate(handler: @escaping () -> Void)
    func onError(handler: @escaping (_ error:  String) -> Void)
    func onLoading(handler: @escaping () -> Void)
    func filterBy(text: String)
    var activePeople: [Person] { get }
}

class PeopleViewModel: PeopleViewModelProtocol {
    private var dataUpdateHandler: (() -> Void)?
    private var errorHandler: ((String) -> Void)?
    private var loadingHandler: (() -> Void)?
    private var filterText: String = ""
    private var people = [Person]()

    var activePeople: [Person] {
        guard !filterText.isEmpty else {
            return people
        }
        return people.filter {
            $0.name.lowercased().contains(filterText.lowercased())
        }
    }
    
    let service: PeopleServiceProtocol
    
    init(service: PeopleServiceProtocol = PeopleService()) {
        self.service = service
    }
    
    func fetchActivePeople() {
        loadingHandler?()
        fetchAllPeople { [weak self] people in
            guard let self = self else { return }
            self.people = self.sortActivePeople(people)
            self.dataUpdateHandler?()
        }
    }
    
    func filterBy(text: String) {
        self.filterText = text
        self.dataUpdateHandler?()
    }
    
    func onDataUpdate(handler: @escaping () -> Void) {
        dataUpdateHandler = handler
    }
    
    func onError(handler: @escaping (String) -> Void) {
        errorHandler = handler
    }
    
    func onLoading(handler: @escaping () -> Void) {
        loadingHandler = handler
    }
    
    private func fetchAllPeople(completion: @escaping (([Person]) -> Void)) {
        service.fetchAllPeople { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let people):
                    completion(people)
                case .failure(let error):
                    self.errorHandler?(error.description)
                }
            }
        }
    }
    
    private func sortActivePeople(_ people: [Person]) -> [Person] {
        let activePeople = people.filter { $0.isActive }
        return activePeople.sorted(by: { $0.index < $1.index } )
    }
}
