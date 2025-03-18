//
//  HomeViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import SwiftUI

protocol HomeViewControllerDelegate {
    func pushToCreateCarpool()
    func pushToProfile()
}

final class HomeViewController: UIViewController {

    var ticketData: [TicketList] = []
    private let disposeBag = DisposeBag()
    private var isPassenger = true
    private var hasTicket = false
    private var profileButtonEdge: CGFloat = 42
    var delegate: HomeViewControllerDelegate?
    weak var viewModel: HomeViewModel?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MATE"
        label.font = UIFont.instance(name: .archivoBlack, size: 35)
        label.textColor = UIColor(colorSet: .primary50)
        return label
    }()
    private lazy var profileButton = UIButton()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(imageSet: .gear)
        button.configuration = config
        return button
    }()
    private lazy var noticeButton: BoxButton = {
        let boxButton = BoxButton()
        boxButton.iconImage = UIImage(imageSet: .folder) ?? UIImage()
        boxButton.title = "공지사항"
        boxButton.accessoryImage = UIImage(systemName: "chevron.right") ?? UIImage()
        return boxButton
    }()
    private lazy var locationButton: BoxButton = {
        let boxButton = BoxButton()
        boxButton.iconImage = UIImage(imageSet: .location) ?? UIImage()
        boxButton.title = "지역 설정"
        boxButton.accessoryImage = UIImage(systemName: "chevron.right") ?? UIImage()
        return boxButton
    }()
    private lazy var createCarpoolButton: BoxButton = {
        let boxButton = BoxButton()
        boxButton.iconImage = UIImage(imageSet: .location) ?? UIImage()
        boxButton.title = "카풀 모집하기"
        boxButton.accessoryImage = UIImage(imageSet: .plus) ?? UIImage()
        return boxButton
    }()
    private lazy var carpoolListImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "list")
        return imageView
    }()
    private lazy var carpoolListLabel: UILabel = {
        let label = UILabel()
        label.text = "카풀 목록"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var carpoolListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 76
        tableView.register(HomeTableViewCell.self,
                           forCellReuseIdentifier: "TicketListTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private lazy var bookStateButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "예약된 카풀이 없습니다."
        button.baseForegroundColor = .white
        button.baseBackgroundColor = UIColor(colorSet: .shadeBlack)
        return button
    }()
    private lazy var createStateButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "생성한 카풀이 없습니다."
        button.baseForegroundColor = .white
        button.baseBackgroundColor = UIColor(colorSet: .shadeBlack)
        return button
    }()
    private lazy var myTicketButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var title = AttributedString(title ?? "내 카풀 보기")
        title.font = UIFont.instance(name: .notoSansKRBold, size: 18)
        configuration.attributedTitle = title
        configuration = configuration
        configuration.image = UIImage(imageSet: .arrowinfo)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 12
        configuration.baseBackgroundColor = UIColor(colorSet: .primary50)
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        bindViewModel(TicketViewModel.shared)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        TicketViewModel.shared.getMyTicketData()
        if ProfileViewModel.shared.profileDataSubject.value.memberRole == "PASSENGER" {
            isPassenger = true
        } else {
            isPassenger = false
        }

        
        TicketViewModel.shared.myTicketDataSubject.subscribe { data in
            if ((data.element?.isEmpty) != nil) {
                self.hasTicket = false
            } else {
                self.hasTicket = true
            }
        }.disposed(by: disposeBag)
        
        print("has Ticket = \(hasTicket)")
        
        if isPassenger {
            configureAuthIsPassenger()
        } else {
            configureAuthIsDriver()
        }
        
        

        viewModel?.requestMemberMe()
    }

    private func bind() {

        createCarpoolButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.delegate?.pushToCreateCarpool()
            })
            .disposed(by: disposeBag)

        profileButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.delegate?.pushToProfile()
            })
            .disposed(by: disposeBag)

        myTicketButton.rx.tap
            .bind(onNext: { [weak self] in
                let viewController = ReservationViewController()
                self?.presentPanModal(viewController)
            })
            .disposed(by: disposeBag)

        viewModel?.profileImage
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] image in
                self?.updateProfileButton(image: image)
            })
            .disposed(by: disposeBag)
    }

    private func updateProfileButton(image: Data) {
        profileButton.setImage(UIImage(data: image), for: .normal)
        profileButton.layer.cornerRadius = profileButtonEdge / 2
        profileButton.clipsToBounds = true
    }
}

private extension HomeViewController {

    func bindViewModel(_ viewModel: TicketViewModel?) {
        
        ProfileViewModel.shared.getProfileData()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            TicketViewModel.shared.ticketListSubject.bind(to: self.rx.ticketData).disposed(by: self.disposeBag)
            self.carpoolListTableView.reloadData()
        }
    }

    func configureAuthIsPassenger() {
        configureViewsAuthIsPassenger()
        configureConstraintsAuthIsPassenger()
        if hasTicket {
            configureHasTicket()
        } else {
            configurePassengerHasNoTicket()
        }
    }

    // 티켓 보유 여부
    func configureHasTicket() {
        view.addSubview(myTicketButton)

        myTicketButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }

    // 승객 티켓없을때
    func configurePassengerHasNoTicket() {
        view.addSubview(bookStateButton)

        bookStateButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }

    func configureViewsAuthIsPassenger() {
        view.backgroundColor = UIColor(colorSet: .background)
        [titleLabel,
         settingsButton,
         profileButton,
         noticeButton,
         locationButton,
         carpoolListImage,
         carpoolListLabel,
         carpoolListTableView].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraintsAuthIsPassenger() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(17)
            make.leading.equalTo(16)
        }

        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(36)
        }

        profileButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(settingsButton.snp.leading).offset(-8)
            make.width.height.equalTo(profileButtonEdge)
        }

        noticeButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }

        locationButton.snp.makeConstraints { make in
            make.top.equalTo(noticeButton.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }

        carpoolListImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.top.equalTo(locationButton.snp.bottom).offset(26)
            make.width.height.equalTo(24)
        }

        carpoolListLabel.snp.makeConstraints { make in
            make.leading.equalTo(carpoolListImage.snp.trailing).offset(8)
            make.top.equalTo(locationButton.snp.bottom).offset(26)
            make.trailing.equalToSuperview().inset(32)
        }

        carpoolListTableView.snp.makeConstraints { make in
            make.top.equalTo(carpoolListLabel.snp.bottom).offset(11)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

private extension HomeViewController {
    func configureAuthIsDriver() {
        configureViewsAuthIsDriver()
        configureConstraintsAuthIsDriver()
        
        print("has Ticket = \(hasTicket)")
        if hasTicket {
            configureHasTicket()
        } else {
            configureDriverHasNoTicket()
        }
    }

    // 드라이버 티켓 없을 경우
    func configureDriverHasNoTicket() {
        view.addSubview(createStateButton)

        createStateButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }

    func configureViewsAuthIsDriver() {
        view.backgroundColor = UIColor(colorSet: .background)
        [titleLabel,
         settingsButton,
         profileButton,
         noticeButton,
         createCarpoolButton,
         carpoolListImage,
         carpoolListLabel,
         carpoolListTableView,
         createStateButton].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraintsAuthIsDriver() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(17)
            make.leading.equalTo(16)
        }

        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(36)
        }

        profileButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(settingsButton.snp.leading).offset(-8)
            make.width.height.equalTo(42)
        }

        noticeButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }

        createCarpoolButton.snp.makeConstraints { make in
            make.top.equalTo(noticeButton.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }

        carpoolListImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.top.equalTo(createCarpoolButton.snp.bottom).offset(26)
            make.width.height.equalTo(24)
        }

        carpoolListLabel.snp.makeConstraints { make in
            make.leading.equalTo(carpoolListImage.snp.trailing).offset(8)
            make.top.equalTo(createCarpoolButton.snp.bottom).offset(26)
            make.trailing.equalToSuperview().inset(32)
        }

        carpoolListTableView.snp.makeConstraints { make in
            make.top.equalTo(carpoolListLabel.snp.bottom).offset(11)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        createStateButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if ticketData.count != 0 {
            count = ticketData.count
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TicketListTableViewCell"
        ) as? HomeTableViewCell else {
            return UITableViewCell()
        }

        if ticketData.count != 0 {
//            cell.profileImageView.image = ""
            let ticket = ticketData[indexPath.row]
            cell.recruitAreaLabel.text = ticket.startArea
            cell.recruitTimeLabel.text = "\(ticket.startTime.stringToMonth()):\(ticket.startTime.stringToDay())"
            if ticket.dayStatus == "MORNING" {
                cell.recruitInformationDefaultLabel.text = "출발,오전"
            } else {
                cell.recruitInformationDefaultLabel.text = "출발,오후"
            }

            cell.recruitPersonLabel.text = "\(ticket.recruitPerson)/4"
            if ticket.recruitPerson == ticket.currentPersonCount {
                cell.recruitPersonLabel.backgroundColor = UIColor(colorSet: .shadeGray)
            } else {
                cell.recruitPersonLabel.backgroundColor = UIColor(colorSet: .primary60)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = ticketData[indexPath.row].id
        let detailVC = TicketDetailViewController()
        detailVC.id = id
        presentPanModal(detailVC)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

struct HomeVC_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
            .getRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
