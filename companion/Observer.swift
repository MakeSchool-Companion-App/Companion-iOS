//
//  Observer.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation


class Observer<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
