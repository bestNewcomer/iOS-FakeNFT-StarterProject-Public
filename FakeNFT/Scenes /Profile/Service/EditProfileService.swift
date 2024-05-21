//
//  EditProfileService.swift
//  FakeNFT
//
//  Created by Ринат Шарафутдинов on 25.04.2024.
//

import Foundation

final class EditProfileService {
    //MARK:  - Public Properties
    static let shared = EditProfileService()
    
    //MARK:  - Private Properties
    private weak var view: EditProfileViewControllerProtocol?
    private var urlSession = URLSession.shared
    private var urlSessionTask: URLSessionTask?
    private let profileService = ProfileService.shared
    
    // MARK: - Initialization
    init() {}
    
    //MARK: - Public Methods
    func setView(_ view: EditProfileViewControllerProtocol) {
        self.view = view
    }
    
    func updateProfile(with model: EditProfile, completion: @escaping (Result<Profile, Error>) -> Void) {
        
        guard let request = makePutRequest(with: model) else {
            assertionFailure("Invalid request")
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        urlSessionTask = urlSession.objectTask(for: request) { (response: Result<Profile, Error>) in
            switch response {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Private Methods
    private func makePutRequest(with profile: EditProfile) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkConstants.urlScheme
        urlComponents.host  = NetworkConstants.urlHost
        urlComponents.path = NetworkConstants.urlPath
        
        guard let url = urlComponents.url else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NetworkConstants.tokenKey, forHTTPHeaderField: "X-Practicum-Mobile-Token")
        
        var profileData: String = ""
        for like in profile.likes ?? [] {
            profileData += "&likes=\(like)"
        }
        if let name = profile.name {
            profileData += "&name=\(name)"
        }
        if let avatar = profile.avatar {
            profileData += "&avatar=\(avatar)"
        }
        if let description = profile.description {
            profileData += "&description=\(description)"
        }
        if let website = profile.website {
            profileData += "&website=\(website)"
        }
        request.httpBody = profileData.data(using: .utf8)
        
        return request
        
    }
}

