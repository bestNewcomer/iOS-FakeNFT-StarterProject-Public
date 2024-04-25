//
//  ProfilePresenter.swift
//  FakeNFT
//
//  Created by Ринат Шарафутдинов on 23.04.2024.
//

import Foundation

protocol ProfilePresenterDelegate: AnyObject {
    func goToMyNFT(with nftID: [String], and likedNFT: [String])
    func goToFavoriteNFT(with nftID: [String], and likedNFT: [String])
    func goToEditProfile(profile: Profile)
}
protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewControllerProtocol? { get set }
    func didTapMyNFT()
    func didTapFavoriteNFT()
    func didTapEditProfile()
    func updateUserProfile(with profile: Profile)
}

final class ProfilePresenter {
    // MARK: - Public Properties
    weak var view: ProfileViewControllerProtocol?
    weak var delegate: ProfilePresenterDelegate?
    
    // MARK: - Private Properties
    private var profile: Profile?
    
}

// MARK: - ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    
    func didTapMyNFT() {
        let nftID = profile?.nfts ?? []
        let likedNFT = profile?.likes ?? []
        delegate?.goToMyNFT(with: nftID, and: likedNFT)
    }
    
    func didTapFavoriteNFT() {
        let nftID = profile?.nfts ?? []
        let likedNFT = profile?.likes ?? []
        delegate?.goToFavoriteNFT(with: nftID, and: likedNFT)
    }
    
    func didTapEditProfile() {
        if let profile = profile {
            delegate?.goToEditProfile(profile: profile)
        }
    }
    
    func updateUserProfile(with profile: Profile) {
        DispatchQueue.main.async { [weak self] in
            self?.profile = profile
            self?.view?.updateProfile(profile: profile)
        }
    }
}

// MARK: - EditProfilePresenterDelegate
extension ProfilePresenter: EditProfilePresenterDelegate {
    func profileDidUpdate(_ profile: Profile, newAvatarURL: String?) {
        self.profile = profile
        view?.updateProfile(profile: profile)
    }
}
