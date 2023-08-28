//
//  ContentView.swift
//  Drag&DropImagePicker
//
//  Created by Nitin Bhatia on 24/08/23.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var originalImage: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                ImagePicker(title: "Drag & Drop", subTitle: "Tap to add an Image", systemImage: "square.and.arrow.up", tint: .blue) {image in
                    print(image)
                    originalImage = image
                }
                .frame(maxWidth: 300, maxHeight: 250)
                .padding(.top, 20)
                
                //Spacer()
//                if let originalImage {
//
//                    Image(uiImage: originalImage)
//                        .resizable()
//                        .frame(maxWidth: 100, maxHeight: 100)
//                }
            }
            .padding()
            .navigationTitle("Image Picker")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.preferredColorScheme(.dark)
    }
}

///custom image picker
///including drag & drop
///
struct ImagePicker: View {
    var title: String
    var subTitle: String
    var systemImage: String
    var tint: Color
    var onImageChange: (UIImage) -> ()
    
    ///view properties
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    
    ///previewImage
    @State private var imagePreview: UIImage?
    ///LoadingStatus
    @State private var isLoading: Bool = false
    
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.largeTitle)
                    .imageScale(.large)
                    .foregroundColor(tint)
                
                Text(title)
                    .font(.callout)
                    .padding(.top, 15)
                
                Text(subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .opacity(imagePreview == nil ? 1.0 : 0)
            ///displaying preview if has image
            .frame(width: size.width, height: size.height)
            .overlay {
                if let imagePreview {
                    Image(uiImage: imagePreview)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(15)
                }
            }
            //dispaly loading UI
            .overlay {
                if isLoading {
                    ProgressView()
                        .padding(20)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                }
            }
            
            //will be available in iOS 17
//            .animation(.snappy, value: isLoading)
//            .animation(.snappy, value: previewImage)
            .contentShape(Rectangle())
            //Imaplementing drag drop
            .dropDestination(for: Data.self, action: {items, location in
                if let firstItem = items.first, let droppedImage = UIImage(data: firstItem) {
                    //sending the image using callback
                   // imagePreview = droppedImage
                    generateImageThumbnail(droppedImage, size)
                    onImageChange(droppedImage)
                    return true
                }
                return false
            }, isTargeted: {_ in
                
            })
            
            .onTapGesture {
                showImagePicker.toggle()
            }
            
            .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
            ///processing the selected image
            .optionalViewModifier {contentView in
                
                contentView
                    .onChange(of: photoItem) { newValue in
                        if let _ = newValue, let photoI = photoItem {
                            extractImage(photoI, size)
                        }
                    }
                
                //for ios 17
//                if #available(iOS 17, *) {
//                    contentView
//                        .onChange(of: photoItem) {oldValue, newValue in
//                            if let newValue {
//extractImage(photoItem, size)
//                            }
//                        }
//                } else {
//                    contentView
//                        .onChange(of: photoItem) {newValue in
//                            if let newValue {
//extractImage(photoItem, size)
//                            }
//                        }
//                }
            }
            
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(tint.opacity(0.08).gradient)
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(tint, style: .init(lineWidth: 1, dash: [12]))
                        .padding(1)
                }
            }
        }
    }
    
    ///extract image  from image picker
    func extractImage(_ photoItem: PhotosPickerItem, _ viewSize: CGSize) {
        Task.detached {
            guard let imageData = try? await photoItem.loadTransferable(type: Data.self) else {
                return
            }
           
            await MainActor.run {
                if let selectedImage = UIImage(data: imageData) {
                    generateImageThumbnail(selectedImage, viewSize)
                    
                    //send original image to call back
                    onImageChange(selectedImage)
                }
                
                self.photoItem = nil
            }
        }
    }
    
    //we are doing this if we drag drop original image then it increases the memory all of sudden of whole app, you can it under debug navigator.  in left side menu
    func generateImageThumbnail(_ image: UIImage, _ size: CGSize) {
        Task.detached {
            let thumbnailImage = await image.byPreparingThumbnail(ofSize: size)
            
            ///UI must be updated on main thread
            await MainActor.run {
                imagePreview = thumbnailImage
            }
        }
    }
    
}

///custom optional view modifier
///
extension View {
    @ViewBuilder
    func optionalViewModifier<Content: View>(@ViewBuilder content: @escaping(Self)->Content) -> some View {
        content(self)
    }
}

