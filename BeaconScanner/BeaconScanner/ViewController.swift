//
//  ViewController.swift
//  BeaconScanner
//
//  Created by Pavan Kumar C on 11/04/18.
//  Copyright © 2018 pavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BeaconScannerDelegate {

  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var scanButton: UIButton!
  
  var rippleView: SMRippleView?
  var beaconScanner: BeaconScanner!

  override func viewDidLoad() {
    super.viewDidLoad()
    baseView.isHidden = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  //MARK:- IBAction Methods
  
  @IBAction func scanForBeaconsClicked(_ sender: UIButton) {
    scanButton.isHidden = true
    baseView.isHidden = false 
    let fillColor: UIColor? = UIColor(red: 255/255, green: 171/255, blue: 73/255, alpha: 1)
    rippleView = SMRippleView(frame: baseView.bounds, rippleColor: UIColor.black, rippleThickness: 0.2, rippleTimer: 0.6, fillColor: fillColor, animationDuration: 4, parentFrame: self.view.frame)
    self.baseView.addSubview(rippleView!)
    
    self.beaconScanner = BeaconScanner()
    self.beaconScanner!.delegate = self
    self.beaconScanner!.startScanning()
  }
  
  //MARK:- Beacon Scanner Delegate
  
  func didFindBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
    print("FIND: \(beaconInfo.description)")
  }
  
  func didLoseBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
    print("LOST: \(beaconInfo.description)")
  }
  
  func didUpdateBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
    print("UPDATE: \(beaconInfo.description)")
  }
  
  func didObserveURLBeacon(beaconScanner: BeaconScanner, URL: NSURL, RSSI: Int) {
    showAlert("Beacon Found", message: "URL SEEN: \(URL)")
  }
  
  //MARK:- Custom methods
  
  func showAlert(_ title:String, message: String) {
    DispatchQueue.main.async {
      self.beaconScanner.stopScanning()
      self.baseView.isHidden = true
      let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
        self.scanButton.isHidden = false
      }));
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}

