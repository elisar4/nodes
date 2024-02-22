//
//  File.swift
//  
//
//  Created by Aiur Arkhipov on 22.02.2024.
//

import Combine

enum NodeParam {
    case input(AnyPublisher<String?, Never>)
    case output(PassthroughSubject<String, Never>)
    
//    var isDifferent
}
