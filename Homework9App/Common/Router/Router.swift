//
//  Router.swift
//  Homework9App
//
//  Created by 1 on 30.03.2022.
//

import UIKit

enum ControllerType: String {
    case assets = "AssetsViewControllerIdentifier"
    case allWallets = "AllWalletsViewControllerIdentifier"
    case createWallet = "CreateWalletContainerViewControllerIdentifier"
    case createWalletPage = "CreateWalletPageIdentifier"
    case recoveryPhrasePage = "RecoveryPhrasePageIdentifier"
    case verifyPhrasePage = "VerifyPhrasePageIdentifier"
    case termsPage = "TermsPageIdentifier"
    case connectWalletPage = "ConnectWalletPageIdentifier"
    case enterVerificationPhrasesPage = "EnterVerificationPhrasesPageIdentifier"
}

enum StoryboardType: String {
    case assets = "Assets"
    case allWallets = "AllWallets"
    case createWallet = "CreateWallet"
}

struct Router {
    
    public static let shared = Router()
    
    private init() {
    }
    
    func dismiss(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: true, completion: completion)
    }
    
    func present(storyboardType: StoryboardType, controllerType: ControllerType, viewController: UIViewController, modalPresentationStyle: UIModalPresentationStyle = .fullScreen, completion: (() -> Void)? = nil, presentingViewControllerCompletion: ((_ viewController: UIViewController) -> Void)? = nil) {
        
        let presentingViewController = self.instantiateViewController(storyboardType: storyboardType, controllerType: controllerType)
        presentingViewController.modalPresentationStyle = modalPresentationStyle
        presentingViewControllerCompletion?(presentingViewController)
        viewController.present(presentingViewController, animated: true, completion: completion)
    }
    
    func showError(error: Error, in viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    func instantiateViewController(storyboardType: StoryboardType, controllerType: ControllerType) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: controllerType.rawValue)
        return viewController
    }
}

