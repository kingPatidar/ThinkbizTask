//
//  Constant.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import UIKit

struct APIErrorMessage {
    static let SomethingWentWrong = "Something went wrong. Please try again later!"
    static let NoInternet = "No Internet"
}

let isIpad = UIDevice.current.userInterfaceIdiom == .pad

let appName = "Thinkbiz Task"

var BASEURL = "http://demo8839722.mockable.io/"

struct APIName {
    static let OrderList = "getOrderlist"
}
