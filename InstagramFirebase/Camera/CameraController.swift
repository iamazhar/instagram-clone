//
//  CameraController.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 22/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate, UIViewControllerTransitioningDelegate {
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "right_arrow_shadow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        
        setupCaptureSession()
        setupHUD()
    }
    
    let customAnimationPresenter = CustomAnimationPresenter()
    let customAnimationDismisser = CustomAnimationDismisser()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimationPresenter
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimationDismisser
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupHUD() {
        view.addSubview(capturePhotoButton)
        view.addSubview(dismissButton)
        
        capturePhotoButton.anchor(top: nil,
                                  left: nil,
                                  bottom: view.bottomAnchor,
                                  right: nil,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 24,
                                  paddingRight: 0,
                                  width: 80,
                                  height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        dismissButton.anchor(top: view.topAnchor,
                             left: nil,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 12,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 12,
                             width: 50,
                             height: 50)
    }
    
    @objc func handleCapturePhoto() {
        print("Capturing photo")
        
        let settings = AVCapturePhotoSettings()
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String : previewFormatType]
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let imageData = photo.fileDataRepresentation()
        let previewImage = UIImage(data: imageData!)
        
        let previewImageView = UIImageView(image: previewImage)
        previewImageView.contentMode = .scaleAspectFill
        
        let containerView = PreviewPhotoContainerView()
        containerView.previewImageView.image = previewImage
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
//        view.addSubview(previewImageView)
//        previewImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        print("Finished processing photo sample buffer...")
    }
    
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
//
//        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer!)
//
//        let previewImage = UIImage(data: imageData!)
//
//        let previewImageView = UIImageView(image: previewImage)
//        view.addSubview(previewImageView)
//        previewImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//
//        print("Finished processing photo sample buffer...")
//    }
    
    let output = AVCapturePhotoOutput()
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        //1. setup inputs
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
        } catch let err {
            print("Could not setup camera input:", err.localizedDescription)
        }
        
        //2. setup outputs
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        //3. setup output preview
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
}
