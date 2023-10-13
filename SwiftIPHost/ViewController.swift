//
//  ViewController.swift
//  SwiftIPHost
//
//  Created by Angelos Staboulis on 13/10/23.
//

import Cocoa
import Network
import ThreadNetwork
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

class ViewController: NSViewController {
    func getIPAddress(host:CFString){
        let hostNew = CFHostCreateWithName(nil, host).takeRetainedValue()
        CFHostStartInfoResolution(hostNew, .addresses, nil)
        var boolVariable:DarwinBoolean = false
        let address = CFHostGetAddressing(hostNew, &boolVariable)?.takeUnretainedValue() as? NSArray
        let newAddress = address?.firstObject as? NSData
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        if getnameinfo(newAddress?.bytes.assumingMemoryBound(to: sockaddr.self), socklen_t(newAddress?.length ?? 0), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0{
            DispatchQueue.main.async{
                let address = String(cString: hostname)
                self.txtIPField.stringValue = address
            }
        }

            
    }
    @IBOutlet weak var txtIP: NSTextField!
    @IBOutlet weak var txtGetIP: NSButton!
    @IBOutlet weak var txtIPHostName: NSTextField!
    @IBOutlet weak var txtIPField: NSTextField!
    @IBAction func getIPCommand(_ sender: Any) {
        getIPAddress(host:txtIP.stringValue as CFString)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

