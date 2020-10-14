/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import SwiftUI

class CalendarPickerHeaderView: UIView {
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: ContentSizeCategory.large.size)
        label.textColor = UIColor(Colors.headline)
        label.text = "Month"
        label.textAlignment = .center

        return label
    }()

    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: ContentSizeCategory.small.size)
        label.textColor = UIColor(Colors.subheadline)
        label.text = "2020"
        label.textAlignment = .center

        return label
    }()

    lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        if let chevronImage = UIImage(systemName: "chevron.left.circle.fill") {
            let imageAttachment = NSTextAttachment(image: chevronImage)
            let attributedString = NSMutableAttributedString()

            attributedString.append(
                NSAttributedString(attachment: imageAttachment)
            )

            button.setAttributedTitle(attributedString, for: .normal)
        } else {
            button.setTitle("Previous", for: .normal)
        }

        button.titleLabel?.textColor = UIColor(Colors.subheadline)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: ContentSizeCategory.large.size)

        button.addTarget(self, action: #selector(didTapPreviousMonthButton), for: .touchUpInside)
        return button
    }()

    lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.titleLabel?.textAlignment = .right

        if let chevronImage = UIImage(systemName: "chevron.right.circle.fill") {
            let imageAttachment = NSTextAttachment(image: chevronImage)
            let attributedString = NSMutableAttributedString()

            attributedString.append(
                NSAttributedString(attachment: imageAttachment)
            )

            button.setAttributedTitle(attributedString, for: .normal)
        } else {
            button.setTitle("Next", for: .normal)
        }

        button.titleLabel?.textColor = UIColor(Colors.subheadline)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: ContentSizeCategory.large.size)

        button.addTarget(self, action: #selector(didTapNextMonthButton), for: .touchUpInside)
        return button
    }()

    lazy var dayOfWeekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.label.withAlphaComponent(0.2)
        return view
    }()

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        return dateFormatter
    }()

    var baseDate = Date() {
        didSet {
            let dateString = dateFormatter.string(from: baseDate).split(separator: " ")
            monthLabel.text = String(dateString.first ?? "")
            yearLabel.text = String(dateString.last ?? "")
        }
    }

    let didTapLastMonthCompletionHandler: (() -> Void)
    let didTapNextMonthCompletionHandler: (() -> Void)

    init(
        didTapLastMonthCompletionHandler: @escaping (() -> Void),
        didTapNextMonthCompletionHandler: @escaping (() -> Void)
    ) {
        self.didTapLastMonthCompletionHandler = didTapLastMonthCompletionHandler
        self.didTapNextMonthCompletionHandler = didTapNextMonthCompletionHandler

        super.init(frame: CGRect.zero)

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(monthLabel)
        addSubview(yearLabel)
        addSubview(previousMonthButton)
        addSubview(nextMonthButton)

        addSubview(dayOfWeekStackView)
        addSubview(separatorView)

        for dayNumber in 1...7 {
            let dayLabel = UILabel()
            dayLabel.font = UIFont(name: "Avenir-Heavy", size: ContentSizeCategory.small.size)
            dayLabel.textColor = UIColor(Colors.subheadline)
            dayLabel.textAlignment = .center
            dayLabel.text = dayOfWeekLetter(for: dayNumber)

            // When a VoiceOver user highlights a day of the month, the day of the week is read to them.
            // That method provides the same amount of context as this stack view does to visual users
            dayLabel.isAccessibilityElement = false
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func dayOfWeekLetter(for dayNumber: Int) -> String {
        switch dayNumber {
        case 1:
            return "S"
        case 2:
            return "M"
        case 3:
            return "T"
        case 4:
            return "W"
        case 5:
            return "T"
        case 6:
            return "F"
        case 7:
            return "S"
        default:
            return ""
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            yearLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            yearLabel.widthAnchor.constraint(equalTo: monthLabel.widthAnchor),
            yearLabel.centerXAnchor.constraint(equalTo: monthLabel.centerXAnchor),

            previousMonthButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Default),
            previousMonthButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),

            nextMonthButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Default),
            nextMonthButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),

            dayOfWeekStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayOfWeekStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayOfWeekStackView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -5),

            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            ])
    }

    @objc func didTapPreviousMonthButton() {
        didTapLastMonthCompletionHandler()
    }

    @objc func didTapNextMonthButton() {
        didTapNextMonthCompletionHandler()
    }
}
