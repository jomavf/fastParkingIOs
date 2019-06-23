//
//  reservationViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/23/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class reservationViewController: UIViewController {

    @IBOutlet weak var startDateTimeInput: UITextField!
    @IBOutlet weak var endDateTimeInput: UITextField!
    
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDatePicker = UIDatePicker()
        endDatePicker = UIDatePicker()
        
        startDatePicker?.datePickerMode = .dateAndTime
        startDatePicker?.addTarget(self, action: #selector(reservationViewController.startDateChanged(startDatePicker:)), for: .valueChanged)
        
        endDatePicker?.datePickerMode = .dateAndTime
        endDatePicker?.addTarget(self, action: #selector(reservationViewController.endDateChanged(endDatePicker:)), for: .valueChanged)
        
        
        startDateTimeInput.inputView = startDatePicker
        endDateTimeInput.inputView = endDatePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reservationViewController.viewTapped(gestureRecognised:)))

        view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped(gestureRecognised:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func startDateChanged(startDatePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        startDateTimeInput.text = dateFormatter.string(from: startDatePicker.date)
        view.endEditing(true)
    }
    
    @objc func endDateChanged(endDatePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        endDateTimeInput.text = dateFormatter.string(from: endDatePicker.date)
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
