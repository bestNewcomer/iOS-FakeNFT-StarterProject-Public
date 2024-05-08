import Foundation

final class StatisticPresenter {
    
    var onNeedUpdate: (() -> Void)?
    
    private var listOfLeaderboard: [UsersModel] = []
    weak var view: StatisticProtocol?
    private var usersService: UsersService
    
    private let dispatchGroup = DispatchGroup()
    
    init(
        view: StatisticProtocol,
        servicesAssembly: ServicesAssembly
    ) {
        self.usersService = servicesAssembly.usersService
        self.view = view
        dispatchGroup.enter()
        self.setListOfLeaderboard()
        dispatchGroup.notify(queue: .main) {
            self.onNeedUpdate?()
        }
    }
    
    deinit {
        print("DEINIT")
    }
    
    func setListOfLeaderboard() {
        
        DispatchQueue.main.async {
            self.usersService.loadNft { [weak self] result in
                defer { self?.dispatchGroup.leave() }
                switch result {
                case .success(let users):
                    self?.listOfLeaderboard = users
                    self?.getSortedLeaderboard()
                case .failure(let error):
                    self?.view?.showError(with: error)
                    
                }
            }
        }
    }
    
    @discardableResult
    func getSortedLeaderboard() -> [UsersModel] {
        
        listOfLeaderboard = listOfLeaderboard.sorted {
            $0.getRating() > $1.getRating()
        }
        return listOfLeaderboard
    }
    
    func getCountOfLeaderboard() -> Int {
        
        listOfLeaderboard.count
    }
    
    func getUserFromLeaderboard(by index: Int) -> UsersModel {
        
        listOfLeaderboard[index]
    }
    
    func sortLeaderboardByName() {
        
        listOfLeaderboard = listOfLeaderboard.sorted {
            $0.name < $1.name
        }
        view?.reloadData()
    }
    
    func sortLeaderboardByRating() {
        
        getSortedLeaderboard()
        view?.reloadData()
    }
}
