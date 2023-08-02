//
//  Bindable.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import Foundation

class Bindable<T> {
    var value : T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer : @escaping ((T?) -> ()))  {
        self.observer = observer
    }
}
