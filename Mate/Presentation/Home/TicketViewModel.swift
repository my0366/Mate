//
//  CarpoolListViewModel.swift
//  Mate
//
//  Created by 성제 on 2022/12/10.
//

import Foundation
import RxSwift
import RxCocoa

class TicketViewModel {

    static let deleteMessage = """
        패신저에게 고지하셨나요? 이미 입금을 받으셨다면 환불처리를 진행해주세요.
        패신저가 있는 상태에서 2회이상 취소시, 추후 서비스를 더 이상 이용하실 수 없습니다.
        그래도 삭제하시겠습니까?
    """
    static let endMessage = "유료 운행의 경우 오전 7~9시, 오후 6~8시까지 운행을 종료해야 합니다."
    static let cancelMessage = "반복적이고 고의적인 카풀 예약 취소는 추후 서비스 이용에 제한됩니다."
    static let shared = TicketViewModel()
    let disposeBag = DisposeBag()

    var ticketListSubject: BehaviorSubject<[TicketList]>
    var ticketDetailSubject: PublishSubject<TicketDetail>
    var myTicketDataSubject: BehaviorRelay<[TicketDetail]>

    var updateTikcetResponseSubject: PublishRelay<String> = PublishRelay<String>()
    private let ticketUseCase: TicketUseCase
    var isLoading: Bool = false

    // ViewModel init : 티켓 리스트와 내 티켓 정보 API 호출
    init() {
        ticketUseCase = TicketUseCase()
        ticketListSubject = BehaviorSubject(value: [])
        ticketDetailSubject = PublishSubject()
        myTicketDataSubject = BehaviorRelay(value: [])
        getTicketListData()
        getMyTicketData()
    }

    // 티켓 전체 조회
    func getTicketListData() {

        DispatchQueue.main.async {
            self.isLoading = true
            print(self.isLoading)
        }

        ticketUseCase.getTicketData().subscribe(onNext: { [weak self] result in
                guard let self = self else {
                    return
                }
                self.isLoading = false
                self.ticketListSubject.onNext(result)
            }, onError: { err in
                print(err)
            })
            .disposed(by: disposeBag)
    }

    // 티켓 상세 조회 - 테이블 뷰
    func getTicketDetailData(id: Int) {

        DispatchQueue.main.async {
            self.isLoading = true
            print(self.isLoading)
        }

        ticketUseCase.getTicketData(id: id).subscribe(onNext: { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading = false
            self.ticketDetailSubject.onNext(result)
        }, onError: { err in
            print(err)
        })
        .disposed(by: disposeBag)
    }

    // 내 티켓 보유 여부 조회
    func getMyTicketData() {
        DispatchQueue.main.async {
            self.isLoading = true
            print(self.isLoading)
        }

        ticketUseCase.getMyTicketData().subscribe(onNext: { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading = false

            self.myTicketDataSubject.accept(result)
        }, onError: { err in
            print(err)
        })
        .disposed(by: disposeBag)
    }

    // 티켓 상태값 변경 : status [CANCEL,BEFORE,ING,AFTER]
    func updateTicket(id: Int, status: String) {

        DispatchQueue.main.async {
            self.isLoading = true
            print(self.isLoading)
        }

        ticketUseCase.updateTicketStatus(id: id, status: status).subscribe(onNext: { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading = false
            self.updateTikcetResponseSubject.accept(result.message)
        }, onError: { err in
            print(err)
        })
        .disposed(by: disposeBag)
    }
}
