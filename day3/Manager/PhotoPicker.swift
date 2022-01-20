//
//  PhotoPicker.swift
//  day3
//
//  Created by AMPA on 18/01/22.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable{
    
    @Binding var avatarImage: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    final class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker)
        {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage{
                photoPicker.avatarImage = image
            }
            else{
                debugPrint("Something went wrong in Photo Picker")
            }
            picker.dismiss(animated: true)
        }
        
    }
}
