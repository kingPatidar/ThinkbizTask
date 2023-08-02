//
//  CategoryViewModel.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import Foundation

final class CategoryViewModel {

   var categoryDetail = Bindable<[CategoryBaseModel]>()
   var errorMessage = Bindable<Error>()
    
    func getCategoryDetails() {
        ApiHandlerClass.shared().getApiCall(modelClass: [CategoryBaseModel].self, apiName: APIName.OrderList, body: NSMutableDictionary.init(), contentType: APIConstant.content_value_Json, url: BASEURL) { response in
                self.categoryDetail.value = response
        } failureBlock: { error in
            self.errorMessage.value = error
        }

    }
}
