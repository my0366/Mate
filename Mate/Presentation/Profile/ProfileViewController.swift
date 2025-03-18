//
//  ProfileViewController.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import SwiftUI
import SnapKit
import RxSwift

protocol ProfileViewControllerDelegate {
    func pushToEditProfile()
}

class ProfileViewController: UIViewController {

    var viewModel: ProfileViewModel = ProfileViewModel.shared {
        didSet {
            print(#fileID, #function, #line, "- viewModel: \(viewModel)")
        }
    }

    var profileData = ProfileViewModel.shared.profileDataSubject.value

    private var profileUserDataView = ProfileUserDataView()
    private var profileUserTypeView = ProfileUserTypeView()
    private var recentlyBoardedView = RecentlyBoardedView()

    var delegate: ProfileViewControllerDelegate?

    private lazy var carpoolListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 76
        tableView.register(HomeTableViewCell.self,
                           forCellReuseIdentifier: "TicketListTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.dragInteractionEnabled = false
        return tableView
    }()

    override func viewDidLoad() {
        configure()
    }

    @objc func didBackBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func didEditButtonTapped() {
        let viewController = ProfileEditViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension ProfileViewController {

    func configure() {
        configureViews()
        configureConstraints()
        configureNavigationBar()
        bindData()
    }

    func bindData() {
        
        profileUserDataView.studentNumber = profileData.studentNumber
        profileUserDataView.phoneNumber = profileData.phoneNumber
        profileUserDataView.department = profileData.department
        profileUserDataView.memberName = profileData.memberName
        
        if profileData.memberRole == "PASSENGER" {
            profileUserTypeView.type = "패신저"
        } else {
            profileUserTypeView.type = "드라이버"
        }
        
        profileUserTypeView.date = ""
        if profileData.memberTimeTable.count > 0 {
            profileData.memberTimeTable.forEach { value in
                switch value.dayCode {
                case "1":
                    profileUserTypeView.date?.append("월")
                case "2":
                    if profileUserTypeView.date?.count != 0 {
                        profileUserTypeView.date?.append(",화")
                    } else {
                        profileUserTypeView.date?.append("화")
                    }
                case "3":
                    if profileUserTypeView.date?.count ?? 0 > 1 {
                        profileUserTypeView.date?.append(",수")
                    } else {
                        profileUserTypeView.date?.append("수")
                    }
                case "4":
                    if profileUserTypeView.date?.count != 0 {
                        profileUserTypeView.date?.append(",목")
                    } else {
                        profileUserTypeView.date?.append("목")
                    }
                case "5":
                    if profileUserTypeView.date?.count != 0 {
                        profileUserTypeView.date?.append(",금")
                    } else {
                        profileUserTypeView.date?.append("금")
                    }
                default:
                    break
                }
            }
        }
    }

    func configureNavigationBar() {
        let backBarButton = UIBarButtonItem(image: UIImage(imageSet: .arrowLeft),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didBackBarButtonTapped))
        let rightBarButton = UIBarButtonItem(title: "수정",
                                             style: .plain,
                                             target: self,
                                             action: #selector(didEditButtonTapped))

        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        self.title = "\(profileData.memberName)님의 정보"
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)
        [
         profileUserDataView,
         profileUserTypeView,
         recentlyBoardedView].forEach {
            view.addSubview($0)
        }
        print(profileData)
        profileUserDataView.backgroundColor = .white
        profileUserTypeView.backgroundColor = .white
        recentlyBoardedView.backgroundColor = .white
    }

    func configureConstraints() {
        profileUserDataView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }

        profileUserTypeView.snp.makeConstraints { make in
            make.top.equalTo(profileUserDataView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(88)
        }

        recentlyBoardedView.snp.makeConstraints { make in
            make.top.equalTo(profileUserTypeView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

struct ProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewController()
            .getRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
