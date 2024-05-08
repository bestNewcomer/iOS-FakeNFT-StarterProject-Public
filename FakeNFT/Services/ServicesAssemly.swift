final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let orderStorage: OrderStorageProtocol
    private let nftByIdStorage: NftByIdStorageProtocol

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        orderStorage: OrderStorageProtocol,
        nftByIdStorage: NftByIdStorageProtocol
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.orderStorage = orderStorage
        self.nftByIdStorage = nftByIdStorage
    }

    var nftService: NftServiceProtocol {
        NftService(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var orderService: OrderServiceProtocol {
        OrderService(
            networkClient: networkClient,
            orderStorage: orderStorage,
            nftByIdService: nftByIdService,
            nftStorage: nftByIdStorage)
    }
    
    var nftByIdService: NftByIdServiceProtocol {
        NftByIdService(
            networkClient: networkClient,
            storage: nftByIdStorage)
    }
    
    var paymentService: PaymentServiceProtocol {
        PaymentService(
            networkClient: networkClient)
    }
}
