//
//  MVCommunicator.swift
//  homework
//
//  Created by Gregory Oberemkov on 18.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class Communicator: NSObject{
    private let serviceBrowser : MCNearbyServiceBrowser
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceType =  "tinkoff-chat"
    let discoveryInfo = [ "userName" : "g.f.oberemkov"]
    let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    var sessions: [String:MCSession] = [:]
    var names: [String:String] = [:]
    var delegate: CommunicatorDelegate?
    var online: Bool = true
    
    
    override init() {
        print( "Communicator initialized")
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo:discoveryInfo , serviceType: serviceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        
        super.init()
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
        self.serviceAdvertiser.startAdvertisingPeer()
        self.serviceAdvertiser.delegate = self
    }
    
    
    func generateMessageId()-> String{
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }
    
    
    func sendMessage(string:String,to userID:String,completionHandler: ((_ success: Bool,_ error: Error?)->())?){
        let message = ["eventType":"TextMessage","messageId": generateMessageId(),"text":string]
        do {
            let dataExample = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
            do {
                if let session = self.sessions[userID]{
                    try session.send(dataExample, toPeers: (session.connectedPeers), with: .reliable)
                }
            }
            catch let error {
                completionHandler?(false,error)
            }
        }
        catch{
            completionHandler?(false,nil)
        }
        completionHandler?(true,nil)
        
        
    }
}

extension Communicator : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        self.delegate?.failedToStartAdvertising(error: error)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if((names[peerID.displayName] != nil)){
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .none)
        invitationHandler(true, session)
        session.delegate = self
        self.sessions[peerID.displayName] = session//+1
        }
    }
    
}


extension Communicator : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        delegate?.failedToStartBrowsingForUsers(error: error)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        if let name = info?["userName"]{
            names[peerID.displayName] = name
            print ("founded")
            if self.sessions[peerID.displayName] == nil{
               
                let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .none)
                session.delegate = self
                self.sessions[peerID.displayName] = session
                
                browser.invitePeer(peerID, to: session, withContext: nil, timeout: 30)
            }
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("MCNearbyServiceBrowser")
    }
    
}
extension Communicator : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if(state == .connected){
            delegate?.didFoundUser(userID: peerID.displayName, userName: names[peerID.displayName])
        }
        if(state == .notConnected){
            self.sessions.removeValue(forKey: peerID.displayName)
            delegate?.didLostUser(userID: peerID.displayName)//-1
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        do {
            var data = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:String]
            
            if data["text"] != nil{
            delegate?.didReceiveMessage(text: data["text"]!, fromUser: peerID.displayName, toUser: self.discoveryInfo["userName"]!)
            }
        }
        catch{
            print ("error session didRecive JSON trouble")
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
       
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}

