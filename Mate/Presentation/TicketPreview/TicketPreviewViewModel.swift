//
//  TicketPreviewViewModel.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/16.
//

import Foundation

import RxRelay
import RxSwift

final class TicketPreviewViewModel {
    private let ticketUseCase: TicketUseCase
    private let disposeBag: DisposeBag
    let message: PublishRelay<String>

    var startArea: String?
    var boardingPlace: String?
    var date: String?
    var dayStatus: String?
    var time: String?
    var chattingLink: String?
    var numberOfpeople: String?
    var carpoolCost: String?

    init() {
        ticketUseCase = TicketUseCase()
        disposeBag = DisposeBag()
        message = PublishRelay()
    }

    func createCarpool() {
        changeDayStatusForm()
        changeCarpoolCostForm()

        guard let startArea = startArea,
              let boardingPlace = boardingPlace,
              let date = date,
              let dayStatus = dayStatus,
              let time = time,
              let chattingLink = chattingLink,
              let numberOfpeople = Int(numberOfpeople ?? "0"),
              let carpoolCost = carpoolCost else { return }

        ticketUseCase.createTicket(
            ticketCreateRequestDTO: TicketCreateRequestDTO(memberId: 0,
                                                           startArea: startArea,
                                                           endArea: "경운대학교",
                                                           boardingPlace: boardingPlace,
                                                           startDayMonth: date,
                                                           dayStatus: dayStatus,
                                                           startTime: time,
                                                           openChatUrl: chattingLink,
                                                           recruitPerson: numberOfpeople,
                                                           ticketType: carpoolCost,
                                                           ticketPrice: 0)
        ).subscribe { [weak self] response in
            if let result = response.element {
                self?.message.accept(result.message)
            }
        }
        .disposed(by: disposeBag)
    }

    func changeDayStatusForm() {
        if dayStatus == "오전" {
            dayStatus = "MORNING"
        } else {
            dayStatus = "AFTERNOON"
        }
    }

    func changeCarpoolCostForm() {
        if carpoolCost == "무료" {
            carpoolCost = "FREE"
        } else {
            carpoolCost = "COST"
        }
    }
}
