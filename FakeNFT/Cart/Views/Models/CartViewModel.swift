protocol CartViewModelProtocol {
    //TODO: убрать переменные в дальнейшем, они для моков
    var nftList: [CartNftInfo] {get set}
    
    func viewDidLoad()
    func viewWillAppear()
    func pullToRefreshDidTrigger()
    func bind(_ bindings: CartViewModelBindings)
    func payButtonDidTap()
}

final class CartViewModel: CartViewModelProtocol {
    @Observable private var numberOfNft: Int
    @Observable private var priceTotal: Float64
    @Observable internal var nftList: [CartNftInfo]
    @Observable private var isEmptyCartPlaceholderDisplaying: Bool
    @Observable private var isNetworkAlertDisplaying: Bool
    @Observable private var isPaymentScreenDisplaying: Bool
    
    var selectedCurrency: String
    
    private var mock1 = CartNftInfo(name: "MockPic1", imageURLString: "", rating: 5, price: 1.78, id: "1")
    private var mock2 = CartNftInfo(name: "MockPic2", imageURLString: "", rating: 3, price: 1.11, id: "2")

    init() {
        self.numberOfNft = 0
        self.priceTotal = 0
        self.nftList = []
        self.selectedCurrency = ""
        self.isEmptyCartPlaceholderDisplaying = true
        self.isNetworkAlertDisplaying = false
        self.isPaymentScreenDisplaying = false
    }
    
    func viewWillAppear() {
    }

    func viewDidLoad() {
        //self.nftList = [mock1, mock2]
    }
    
    func pullToRefreshDidTrigger() {
        //self.nftList = [mock1, mock2]
    }

    func bind(_ bindings: CartViewModelBindings) {
        self.$numberOfNft.bind(action: bindings.numberOfNft)
        self.$priceTotal.bind(action: bindings.priceTotal)
        self.$nftList.bind(action: bindings.nftList)
        self.$isEmptyCartPlaceholderDisplaying.bind(action: bindings.isEmptyCartPlaceholderDisplaying)
        //self.$isNetworkAlertDisplaying.bind(action: bindings.isNetworkAlertDisplaying)
        self.$isPaymentScreenDisplaying.bind(action: bindings.isPaymentScreenDisplaying)
    }

    func payButtonDidTap() {
        isPaymentScreenDisplaying = true
    }
}
