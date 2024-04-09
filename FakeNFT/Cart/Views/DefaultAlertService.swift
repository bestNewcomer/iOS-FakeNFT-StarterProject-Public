import UIKit

@objc protocol AlertServiceDelegate {
    @objc optional func networkAlertDidCancel()
    @objc optional func networkAlertRepeatDidTap()
    @objc optional func alertOkButtonDidTap()
}

protocol AlertServiceProtocol {
    func presentGenericErrorAlert()
}

final class DefaultAlertService: AlertServiceProtocol {
    private var delegate: AlertServiceDelegate
    private var presentingViewController: UIViewController

    init(delegate: AlertServiceDelegate, controller: UIViewController) {
        self.delegate = delegate
        self.presentingViewController = controller
    }

    func presentGenericErrorAlert() {
        let title = "Упс! Что-то пошло не так :("
        let message = "Попробуйте еще раз!"
        let okActionTitle = "OK"
        
        let controller = CartAlertController(
            delegate: presentingViewController,
            title: title,
            message: message,
            actions: [
                CartAlertAction(title: okActionTitle, style: .cancel) { [weak self] _ in
                    self?.delegate.alertOkButtonDidTap?()
                }
            ]
        )
        controller.show()
    }
}
