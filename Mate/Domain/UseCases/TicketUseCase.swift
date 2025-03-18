//
//  TicketUseCase.swift
//  Mate
//
//  Created by 성제 on 2022/12/13.
//

import Foundation
import RxSwift
import Alamofire

class TicketUseCase {
    func createTicket(ticketCreateRequestDTO: TicketCreateRequestDTO) -> Observable<BaseResponse> {
        return Observable.create { observer in
            TicketRepository.createTicket(ticketCreateRequestDTO: ticketCreateRequestDTO) { response in
                observer.onNext(response)
            } failure: { error in
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    func getTicketData() -> Observable<[TicketList]> {
        return Observable.create { observer in
            TicketRepository.getTicketList { ticketList in
                observer.onNext(ticketList)
            } failure: { error in
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    func getTicketData(id: Int) -> Observable<TicketDetail> {
        return Observable.create { observer in
            TicketRepository.getReadTicket(id: id) { ticketList in
                observer.onNext(ticketList)
            } failure: { error in
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    func getMyTicketData() -> Observable<[TicketDetail]> {
        return Observable.create { observer in
            TicketRepository.getMyTicketData { ticketList in
                observer.onNext(ticketList)
            } failure: { error in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    
    func updateTicketStatus(id: Int, status: String) -> Observable<BaseResponse> {
        return Observable.create { observer in
            TicketRepository.updateTicket(id: id, status: status) { response in
                observer.onNext(response)
            } failure: { error in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
