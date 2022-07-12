//
//  CameraModel.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 27/06/22.
//

import AVFoundation
import Foundation
import SwiftUI

class CameraAlphabet: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    private let context = PersistenceController.shared.container.viewContext
    var userAlphabetRepository = UserAlphabetRepository()

    @Published var isTaken = false

    @Published var session = AVCaptureSession()

    @Published var alert = false

    // Since were going to read pic data...
    @Published var output = AVCapturePhotoOutput()

    // preview...
    @Published var preview: AVCaptureVideoPreviewLayer!

    // Pic data...
    @Published var isSaved = false

    @Published var picData = Data(count: 0)

    func check() {
        // First checking camera has got permission...
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        // Setting Up Session
        case .notDetermined:
            // Retusting for permission
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            alert.toggle()
            return
        default:
            return
        }
    }

    func setUp() {
        // setting up camera...
        do {
            // setting configs...
            session.beginConfiguration()

            // change for your own
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)

            let input = try AVCaptureDeviceInput(device: device!)

            // checking and adding to session...

            if session.canAddInput(input) {
                session.addInput(input)
            }

            // same for output...

            if session.canAddOutput(output) {
                session.addOutput(output)
            }

            session.commitConfiguration()

        } catch {
            print(error.localizedDescription)
        }
    }

    // take and retake functions

    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()

            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }

    func reTake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()

            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()

                    // clearing...
                    self.isSaved = false
                }
            }
        }
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            print(error)
            return
        }

        print("pic taken...")

        guard let imageData = photo.fileDataRepresentation() else { return }

        picData = imageData
    }

    func savePic() {
        if picData.count > 0 {
            let userAlphabet = UserAlphabetEntity(context: context)
            userAlphabetRepository.addPictureAlphabet(userAlphabet: userAlphabet, imageData: picData, hasDifficulity: false)
            print("data nya \(userAlphabetRepository.getAllUserAlphabet())")
            print("Saved successfully")
            print("Berhasil")
        } else {
            print("Gagal mengcapture gambar")
        }
    }

    //  func savePic() {
    //    let image = UIImage(data: self.picData)!
    //
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    //
    //    self.isSaved = true
    //
    //    print("Saved successfully")
    //  }
}
