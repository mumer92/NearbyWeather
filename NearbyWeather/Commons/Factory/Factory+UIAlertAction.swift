//
//  Factory+UIAlertAction.swift
//  NearbyWeather
//
//  Created by Erik Maximilian Martens on 03.01.21.
//  Copyright © 2021 Erik Maximilian Martens. All rights reserved.
//

import UIKit

extension Factory {
  
  struct AlertAction: FactoryFunction {
    
    enum AlertActionType {
      case standard(title: String, handler: ((UIAlertAction) -> Void)?)
      case image(title: String, image: UIImage?, handler: ((UIAlertAction) -> Void)?)
      case cancel
    }
    
    typealias InputType = AlertActionType
    typealias ResultType = UIAlertAction
    
    static func make(fromType type: InputType) -> ResultType {
      switch type {
      case let .standard(title, handler):
        return UIAlertAction(title: title, style: .default, handler: handler)
      case let .image(title, image, handler):
        let action = UIAlertAction(title: title, style: .default, handler: handler)
        action.setValue(image, forKey: Constants.Keys.KeyValueBindings.kImage)
        return action
      case .cancel:
        return UIAlertAction(title: R.string.localizable.cancel(), style: .cancel)
      }
    }
  }
}
