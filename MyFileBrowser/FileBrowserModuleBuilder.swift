//
//  FileBrowserModuleBuilder.swift
//  MyFileBrowser
//
//  Created by  Rada Hristova on 20.02.23.
//

import UIKit

enum FileBrowserModuleBuilder {
    static func build(activation: FileBrowserActivation) -> UIViewController {
        let interactor = FileBrowserInteractor()
        let presenter = FileBrowserPresenter(interactor: interactor, activation: activation)
        
        let view = FileBrowserViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}


//static func build(
//    activation: ContactDetailsActivation,
//    submoduleBuilders: ContactDetails.SubmoduleBuilders,
//    contactService: ContactService,
//    dismissHandler: ViewControllerDismissHandler,
//    navigationItem: UINavigationItem? = nil
//) -> UIViewController {
//    let interactor = ContactDetailsInteractor(contactService: contactService)
//    let router = ContactDetailsRouter()
//    let presenter = ContactDetailsPresenter(
//        activation: activation,
//        interactor: interactor,
//        router: router,
//        submoduleBuilders: submoduleBuilders
//    )
//
//    let view = ContactDetailsViewController(presenter: presenter, navigationItem: navigationItem)
//    presenter.view = view
//
//    router.selfDismisser = ViewControllerDismissTrampoline(
//        viewController: view,
//        dismissHandler: dismissHandler
//    )
//
//    return view
//}
