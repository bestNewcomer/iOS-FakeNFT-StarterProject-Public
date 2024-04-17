//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Леонид Турко on 12.04.2024.
//

import UIKit
import WebKit
import Combine

final class WebViewController: UIViewController {
  
  private lazy var webView: WKWebView = {
    let view = WKWebView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var progressView: UIProgressView = {
    let view = UIProgressView()
    view.progressTintColor = .ypBlack
    view.trackTintColor = .ypLightGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let url: URL
  
  private var presenter: WebViewPresenterProtocol
  private var subscribes = [AnyCancellable]()
  
  init(presenter: WebViewPresenterProtocol, url: URL?) {
    self.presenter = presenter
    self.url = URL(string: "https://practicum.yandex.ru/ios-developer/")!
    super.init(nibName: nil, bundle: nil)
    
    setupUI()
    presenter.viewDidLoad()
    loadWebView(with: url)
    
    bind()
  }
  
  required init?(coder: NSCoder) {
    assertionFailure("init(coder:) has not been implemented")
    return nil
  }
  
  private func setupUI() {
    view.backgroundColor = .ypWhite
    addSubviews()
    applyConstraints()
  }
  
  private func addSubviews() {
    view.addSubview(webView)
    view.addSubview(progressView)
  }
  
  private func applyConstraints() {
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      progressView.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor),
      progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
      progressView.trailingAnchor.constraint(equalTo: webView.trailingAnchor)
    ])
  }
  
  private func bind() {
    presenter.progressPublisher.receive(on: DispatchQueue.main)
      .sink { [weak self] (newValue: Float)  in
        guard let self = self else { return }
        
        self.setProgressValue(newValue)
        self.presenter.didUpdateProgressValue(self.webView.estimatedProgress)
        
      }.store(in: &subscribes)
    
    presenter.progressStatePublisher.receive(on: DispatchQueue.main)
      .sink { [weak self] (shouldHide: Bool) in
        guard let self = self else { return }
        
        if shouldHide {
          self.setProgressHidden(shouldHide)
        }
      }.store(in: &subscribes)
  }
  
  private func setProgressValue (_ newValue: Float) {
    progressView.progress = newValue
  }
  
  private func setProgressHidden(_ isHidden: Bool) {
    progressView.isHidden = isHidden
  }
  
  private func loadWebView(with url: URL?) {
    if let url = url {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
  
  @objc private func didTapBackButton() {
    webView.stopLoading()
    navigationController?.popViewController(animated: true)
  }
}
