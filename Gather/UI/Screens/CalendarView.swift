//
//  CalendarView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/10/20.
//

import SwiftUI
import UIKit
import JTAppleCalendar

struct CalendarView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CalendarPickerViewController
    
    @Binding var selectedDate: Date
    
    func makeCoordinator() -> CalendarView.Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> CalendarPickerViewController {
        let picker = CalendarPickerViewController(baseDate: selectedDate) { (date) in
            selectedDate = date
        }
        picker.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - Sizes.Small * 2).isActive = true
        picker.view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        picker.view.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: CalendarPickerViewController, context: Context) {
        //
    }
    
    class Coordinator: NSObject, JTACMonthViewDataSource, JTACMonthViewDelegate {
        var parent: CalendarView

        init(_ view: CalendarView) {
            self.parent = view
        }

        func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM dd"
            let startDate = formatter.date(from: "2018 01 01")!
            let endDate = Date()
            return ConfigurationParameters(startDate: startDate, endDate: endDate)
        }
        
//        func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
//            MonthSize(defaultSize: Sizes.Large)
//        }
//
//        func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
//            let header = calendar.dequeueReusableSupplementaryView(ofKind: "JTACMonthReusableView", withReuseIdentifier: "header", for: indexPath) as! JTACMonthReusableView
//
//            return header
//        }

        func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
            let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
            cell.dateLabel.text = cellState.text
            
            return cell
        }

        func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
            let cell = cell as! DateCell
            cell.dateLabel.text = cellState.text
        }
    }

}

class DateCell: JTACDayCell {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    private func setupViews() {
        addSubview(dateLabel)
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
