//
//  WeatherStationCurrentInformationSunCycleCell.swift
//  NearbyWeather
//
//  Created by Erik Maximilian Martens on 14.01.21.
//  Copyright © 2021 Erik Maximilian Martens. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Definitions

private extension WeatherStationCurrentInformationSunCycleCell {
  struct Definitions {
    static var trailingLeadingContentInsets: CGFloat {
      if #available(iOS 13, *) {
        return CellContentInsets.leading(from: .small)
      }
      return CellContentInsets.leading(from: .medium)
    }
    static let symbolWidth: CGFloat = 20
  }
}

// MARK: - Class Definition

final class WeatherStationCurrentInformationSunCycleCell: UITableViewCell, BaseCell {
  
  typealias CellViewModel = WeatherStationCurrentInformationSunCycleCellViewModel
  private typealias CellContentInsets = Constants.Dimensions.Spacing.ContentInsets
  private typealias CellInterelementSpacing = Constants.Dimensions.Spacing.InterElementSpacing
  
  // MARK: - UIComponents
  
  private lazy var sunriseSymbolImageView = Factory.ImageView.make(fromType: .symbol(image: R.image.sunrise()))
  private lazy var sunriseDescriptionLabel = Factory.Label.make(fromType: .body(text: R.string.localizable.sunrise(), numberOfLines: 1))
  private lazy var sunriseTimeLabel = Factory.Label.make(fromType: .body(alignment: .right, numberOfLines: 1))
  
  private lazy var sunsetSymbolImageView = Factory.ImageView.make(fromType: .symbol(image: R.image.sunset()))
  private lazy var sunsetDescriptionLabel = Factory.Label.make(fromType: .body(text: R.string.localizable.sunset(), numberOfLines: 1))
  private lazy var sunsetTimeLabel = Factory.Label.make(fromType: .body(alignment: .right, numberOfLines: 1))
  
  // MARK: - Assets
  
  private var disposeBag = DisposeBag()
  
  // MARK: - Properties
  
  var cellViewModel: CellViewModel?
  
  // MARK: - Initialization
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layoutUserInterface()
    setupAppearance()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Cell Life Cycle
  
  func configure(with cellViewModel: BaseCellViewModelProtocol?) {
    guard let cellViewModel = cellViewModel as? WeatherStationCurrentInformationSunCycleCellViewModel else {
      return
    }
    self.cellViewModel = cellViewModel
    cellViewModel.observeEvents()
    bindContentFromViewModel(cellViewModel)
    bindUserInputToViewModel(cellViewModel)
  }
}

// MARK: - ViewModel Bindings

extension WeatherStationCurrentInformationSunCycleCell {
  
  func bindContentFromViewModel(_ cellViewModel: CellViewModel) {
    cellViewModel.cellModelDriver
      .drive(onNext: { [setContent] in setContent($0) })
      .disposed(by: disposeBag)
  }
}

// MARK: - Cell Composition

private extension WeatherStationCurrentInformationSunCycleCell {
  
  func setContent(for cellModel: WeatherStationCurrentInformationSunCycleCellModel) {
    sunriseTimeLabel.text = cellModel.sunriseTimeString
    sunsetTimeLabel.text = cellModel.sunsetTimeString
  }
  
  func layoutUserInterface() {
    // line 1
    contentView.addSubview(sunriseSymbolImageView, constraints: [
      sunriseSymbolImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CellContentInsets.top(from: .medium)),
      sunriseSymbolImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Definitions.trailingLeadingContentInsets),
      sunriseSymbolImageView.widthAnchor.constraint(equalToConstant: Definitions.symbolWidth),
      sunriseSymbolImageView.heightAnchor.constraint(equalTo: sunriseSymbolImageView.widthAnchor)
    ])
    
    contentView.addSubview(sunriseDescriptionLabel, constraints: [
      sunriseDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CellContentInsets.top(from: .medium)),
      sunriseDescriptionLabel.leadingAnchor.constraint(equalTo: sunriseSymbolImageView.trailingAnchor, constant: CellInterelementSpacing.xDistance(from: .small)),
      sunriseDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.Dimensions.Size.ContentElementSize.height),
      sunriseDescriptionLabel.centerYAnchor.constraint(equalTo: sunriseSymbolImageView.centerYAnchor)
    ])
    
    contentView.addSubview(sunriseTimeLabel, constraints: [
      sunriseTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CellContentInsets.top(from: .medium)),
      sunriseTimeLabel.leadingAnchor.constraint(equalTo: sunriseDescriptionLabel.trailingAnchor, constant: CellInterelementSpacing.xDistance(from: .small)),
      sunriseTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Definitions.trailingLeadingContentInsets),
      sunriseTimeLabel.widthAnchor.constraint(equalTo: sunriseDescriptionLabel.widthAnchor),
      sunriseTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.Dimensions.Size.ContentElementSize.height),
      sunriseTimeLabel.heightAnchor.constraint(equalTo: sunriseDescriptionLabel.heightAnchor),
      sunriseTimeLabel.centerYAnchor.constraint(equalTo: sunriseDescriptionLabel.centerYAnchor),
      sunriseTimeLabel.centerYAnchor.constraint(equalTo: sunriseSymbolImageView.centerYAnchor)
    ])
    
    // line 2
    contentView.addSubview(sunsetSymbolImageView, constraints: [
      sunsetSymbolImageView.topAnchor.constraint(equalTo: sunriseSymbolImageView.bottomAnchor, constant: CellInterelementSpacing.yDistance(from: .medium)),
      sunsetSymbolImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Definitions.trailingLeadingContentInsets),
      sunsetSymbolImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CellContentInsets.bottom(from: .medium)),
      sunsetSymbolImageView.widthAnchor.constraint(equalToConstant: Definitions.symbolWidth),
      sunsetSymbolImageView.heightAnchor.constraint(equalTo: sunsetSymbolImageView.widthAnchor)
    ])
    
    contentView.addSubview(sunsetDescriptionLabel, constraints: [
      sunsetDescriptionLabel.topAnchor.constraint(equalTo: sunriseDescriptionLabel.bottomAnchor, constant: CellInterelementSpacing.yDistance(from: .medium)),
      sunsetDescriptionLabel.leadingAnchor.constraint(equalTo: sunsetSymbolImageView.trailingAnchor, constant: CellInterelementSpacing.xDistance(from: .small)),
      sunsetDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CellContentInsets.bottom(from: .medium)),
      sunsetDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.Dimensions.Size.ContentElementSize.height),
      sunsetDescriptionLabel.centerYAnchor.constraint(equalTo: sunsetSymbolImageView.centerYAnchor)
    ])
    
    contentView.addSubview(sunsetTimeLabel, constraints: [
      sunsetTimeLabel.topAnchor.constraint(equalTo: sunriseTimeLabel.bottomAnchor, constant: CellInterelementSpacing.yDistance(from: .medium)),
      sunsetTimeLabel.leadingAnchor.constraint(equalTo: sunsetDescriptionLabel.trailingAnchor, constant: CellInterelementSpacing.xDistance(from: .small)),
      sunsetTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Definitions.trailingLeadingContentInsets),
      sunsetTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CellContentInsets.bottom(from: .medium)),
      sunsetTimeLabel.widthAnchor.constraint(equalTo: sunsetDescriptionLabel.widthAnchor),
      sunsetTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.Dimensions.Size.ContentElementSize.height),
      sunsetTimeLabel.heightAnchor.constraint(equalTo: sunsetDescriptionLabel.heightAnchor),
      sunsetTimeLabel.centerYAnchor.constraint(equalTo: sunsetDescriptionLabel.centerYAnchor),
      sunsetTimeLabel.centerYAnchor.constraint(equalTo: sunsetSymbolImageView.centerYAnchor)
    ])
  }
  
  func setupAppearance() {
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = Constants.Theme.Color.ViewElement.secondaryBackground
  }
}