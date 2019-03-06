//
//  DetailViewController.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import Kingfisher

protocol DetailPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func follow(user: GitHubUser)
}

final class DetailViewController: UIViewController, Storyboardable, DetailPresentable, DetailViewControllable {

    typealias Dependency = GitHubUser

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var followButton: UIButton!

    weak var listener: DetailPresentableListener?

    private var gitHubUser: GitHubUser?

    static func makeFromStoryboard(_ dependency: GitHubUser) -> DetailViewController {
        let viewController = DetailViewController.unsafeMakeFromStoryboard()
        viewController.gitHubUser = dependency
        return viewController
    }

    deinit {
        print("DetailViewController deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.showsVerticalScrollIndicator = false
        imageView.contentMode = .scaleAspectFit
        nameLabel.font = UIFont.systemFont(ofSize: 48)
        nameLabel.textColor = .gray
        nameLabel.textAlignment = .center
        followButton.backgroundColor = .white
        followButton.setTitle("Follow", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 24)
        followButton.setTitleColor(.darkGray, for: .normal)
        followButton.setTitleColor(UIColor.darkGray.withAlphaComponent(0.7), for: .highlighted)
        followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        followButton.layer.cornerRadius = 8
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.lightGray.cgColor

        followButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let me = self,
                    let user = self?.gitHubUser else {
                        return
                }
                me.listener?.follow(user: user)
            })
            .disposed(by: rx.disposeBag)

        if let gitHubUser = gitHubUser,
            let imageURL = URL(string: gitHubUser.imageUrl) {
            imageView.kf.setImage(with: ImageResource(downloadURL: imageURL))
            nameLabel.text = gitHubUser.name
        }

        Observable.merge(ex.viewWillAppear.map { _ in false },
                         ex.viewWillDisappear.map { _ in true })
            .subscribe(onNext: { [weak self] isNavigationBarHidden in
                self?.navigationController?.isNavigationBarHidden = isNavigationBarHidden
            })
            .disposed(by: rx.disposeBag)
    }
}
