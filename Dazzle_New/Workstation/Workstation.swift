//
//  ViewController.swift
//  Dazzle 3
//
//  Created by Pinaka on 14/11/24.
//

import UIKit


// MARK: - TShirtTexture Enum
enum Workstation: String, CaseIterable {
    case cotton = "Cotton"
    case linen = "Linen"
    case polyester = "Polyester"
    case nylon = "Nylon"
    case velvet = "Velvet"
    
    var imageName: String {
        switch self {
        case .cotton:
            return "CottonTexture"
        case .linen:
            return "LinenTexture"
        case .polyester:
            return "PolyesterTexture"
        case .nylon:
            return "NylonTexture"
        case .velvet:
            return "VelvetTexture"
        }
    }
}

// MARK: - ViewController
// The main view controller for the app
class ViewController: UIViewController, UIColorPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var TextureButton: UIButton!
    @IBOutlet weak var SwitchButton: UIButton!// Switch between T-shirt views
    @IBOutlet weak var tShirtImageView: UIImageView!
    @IBOutlet weak var CanvasView: UIView!
    @IBOutlet weak var scrollBottomView: UIScrollView!
    @IBOutlet weak var stackBottomView: UIStackView!
    @IBOutlet weak var UndoButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var RedoButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var UpperNavigationPanel: UIView!
    
    @IBOutlet weak var ImageButton: UIButton!
    @IBOutlet weak var TextButton: UIButton!
    @IBOutlet weak var DrawButton: UIButton!
    @IBOutlet weak var LineButton: UIButton!
    @IBOutlet weak var StickerButton: UIButton!
    @IBOutlet weak var CropButton: UIButton!
    @IBOutlet weak var ColorButton: UIButton!
    

    @IBOutlet weak var AiButton: UIButton!
    


    // MARK: - Properties
    private var currentImageIndex: Int = 0
    private var tShirtImages: [UIImage] = []
    private var canvasImage: UIImage?
    private var activeSideIndex: Int = 0 // Track the active T-shirt side
    private var canvasStates: [UIView?] = [] // Store different canvases for each side
    private var actionsStack: [[UIView]] = [[], [], [], []] // Separate stacks for each side
    private var redoStack: [[UIView]] = [[], [], [], []] // Separate redo stacks for each side

    // Store the original base image for each side to apply textures correctly
       private var baseTShirtImages: [UIImage?] = [nil, nil, nil, nil]
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTShirtImages()
        setupInitialUI()
    }
    
    // MARK: - Setup Methods
    private func setupTShirtImages() {
        tShirtImages = [
            UIImage(named: "front_Tshirt")?.withRenderingMode(.alwaysTemplate),
            UIImage(named: "back_Tshirt")?.withRenderingMode(.alwaysTemplate),
            UIImage(named: "side_Tshirt")?.withRenderingMode(.alwaysTemplate),
            UIImage(named: "side_Tshirt")?.withRenderingMode(.alwaysTemplate)
        ].compactMap { $0 }
        
        if tShirtImages.isEmpty {
            SwitchButton.isEnabled = false
            print("Error: No T-shirt images found!")
            return
        } else {
            SwitchButton.isEnabled = true
            tShirtImageView.image = tShirtImages.first
            tShirtImageView.tintColor = .green // Default color
            
            // Initialize the canvasStates for each side
            canvasStates = [UIView(frame: CanvasView.bounds), UIView(frame: CanvasView.bounds), UIView(frame: CanvasView.bounds), UIView(frame: CanvasView.bounds)]
            // Add each canvas to CanvasView
                        for canvas in canvasStates {
                            if let canvas = canvas {
                                CanvasView.addSubview(canvas)
                            }
                        }
                        
                        // Store the original base images
                        for (index, image) in tShirtImages.enumerated() {
                            baseTShirtImages[index] = image
                        }
                    }
                }

    
    private func setupInitialUI() {
        // Set up initial UI state
        canvasImage = CanvasView.snapshot()
    }
    
    // MARK: - IBActions
    @IBAction func switchButtonTapped(_ sender: UIButton) {
        // Switch between T-shirt sides
            currentImageIndex = (currentImageIndex + 1) % tShirtImages.count
            tShirtImageView.image = tShirtImages[currentImageIndex]
        // Update base image
               if let baseImage = baseTShirtImages[currentImageIndex] {
                   tShirtImageView.image = baseImage
               }
               
            // Remove the old canvas (if exists)
        if let currentCanvas = canvasStates[activeSideIndex] {
            currentCanvas.removeFromSuperview()
        }
            
            // Switch to the new active canvas side
            activeSideIndex = currentImageIndex
            
            // Check if the canvas for the active side exists, if not create it
            if canvasStates[activeSideIndex] == nil {
                canvasStates[activeSideIndex] = UIView(frame: CanvasView.bounds) // Or initialize it with the appropriate size
            }
            
            // Add the new active canvas for the current side
            if let activeCanvas = canvasStates[activeSideIndex] {
                CanvasView.addSubview(activeCanvas)
            }
        }
    
    @IBAction func undoButtonTapped(_ sender: UIButton) {
        // Undo the last change on the active side
            var actionsStackForActiveSide = actionsStack[activeSideIndex]
            guard let lastAction = actionsStackForActiveSide.popLast() else {
                showAlert(message: "Nothing to undo!")
                return
            }
            lastAction.removeFromSuperview()
            redoStack[activeSideIndex].append(lastAction)
            showAlert(message: "Undo successful!")
        }
           
            
    
    @IBAction func redoButtonTapped(_ sender: UIButton) {
        // Redo the undone change on the active side
            var redoStackForActiveSide = redoStack[activeSideIndex]
            guard let lastRedoAction = redoStackForActiveSide.popLast() else {
                showAlert(message: "Nothing to redo!")
                return
            }
        canvasStates[activeSideIndex]?.addSubview(lastRedoAction)
            actionsStack[activeSideIndex].append(lastRedoAction)
            showAlert(message: "Redo successful!")
        }
            
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Save the design of the active side
        guard let designImage = canvasStates[activeSideIndex]?.snapshot() else { return }
            UIImageWriteToSavedPhotosAlbum(designImage, nil, nil, nil)
            showAlert(message: "Design saved successfully!")
        }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        // Navigate to the first screen
            navigationController?.popViewController(animated: true)
        }
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        // Add an image to the active T-shirt side
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }

        
    
    @IBAction func textButtonTapped(_ sender: UIButton) {
        // Add text to the T-shirt
        // Add text to the active T-shirt side
           let textInputAlert = UIAlertController(title: "Add Text", message: nil, preferredStyle: .alert)
           textInputAlert.addTextField { textField in
               textField.placeholder = "Enter your text"
           }
           textInputAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
               guard let text = textInputAlert.textFields?.first?.text else { return }
               self.canvasStates[self.activeSideIndex]?.addTextOverlay(text: text)
           }))
           present(textInputAlert, animated: true, completion: nil)
       }
    
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        // Enable drawing on the active T-shirt side
        self.canvasStates[self.activeSideIndex]?.enableDrawing()
       }
    
    @IBAction func lineButtonTapped(_ sender: UIButton) {
        // Enable line drawing on the active T-shirt side
        self.canvasStates[self.activeSideIndex]?.enableLineDrawing()
       }
    
    @IBAction func stickerButtonTapped(_ sender: UIButton) {
        // Add a sticker (emoji or other) to the active T-shirt side
            let stickers = ["😀", "🎉", "❤️", "🔥"]
            let stickerPickerAlert = UIAlertController(title: "Choose Sticker", message: nil, preferredStyle: .actionSheet)
            stickers.forEach { sticker in
                stickerPickerAlert.addAction(UIAlertAction(title: sticker, style: .default, handler: { _ in
                    self.canvasStates[self.activeSideIndex]?.addStickerOverlay(sticker: sticker)
                }))
            }
            present(stickerPickerAlert, animated: true, completion: nil)
        }
    
    @IBAction func cropButtonTapped(_ sender: UIButton) {
        // Enable cropping functionality on the active T-shirt side
        self.canvasStates[self.activeSideIndex]?.enableCropping()
      }
    
    @IBAction func aiButtonTapped(_ sender: UIButton) {
        let promptAlert = UIAlertController(title: "Enter a prompt", message: "Describe the image you want", preferredStyle: .alert)
        
        promptAlert.addTextField { textField in
            textField.placeholder = "Type your prompt here"
        }
        
        promptAlert.addAction(UIAlertAction(title: "Generate", style: .default, handler: { _ in
            if let prompt = promptAlert.textFields?.first?.text, !prompt.isEmpty {
                self.generateImageFromPrompt(prompt: prompt)
            } else {
                self.showAlert(message: "Please enter a prompt!")
            }
        }))
        
        promptAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(promptAlert, animated: true, completion: nil)
    }
    
    
    // API Request function
    // Generate Image from the DALL-E API based on the prompt
    func generateImageFromPrompt(prompt: String) {
        showLoadingSpinner()
        
        let apiKey = ""
        let url = URL(string: "https://api.openai.com/v1/images/generations")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "prompt": prompt,
            "n": 1, // Number of images to generate
            "size": "1024x1024" // Image size
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            hideLoadingSpinner()
            print("Error in preparing request body: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return } // Ensure 'self' is available

            if let error = error {
                self.hideLoadingSpinner()
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                self.hideLoadingSpinner()
                print("No data returned")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let images = json["data"] as? [[String: Any]],
                   let imageUrlString = images.first?["url"] as? String,
                   let imageUrl = URL(string: imageUrlString) {
                    
                    // Download the image and update UI
                    self.downloadImage(from: imageUrl)
                }
            } catch {
                self.hideLoadingSpinner()
                print("Error in parsing response: \(error)")
            }
        }.resume()
    }

    // Download the image and add it to the T-shirt canvas
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return } // Ensure 'self' is available
            
            if let error = error {
                self.hideLoadingSpinner()
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                self.hideLoadingSpinner()
                print("Error: Invalid image data")
                return
            }
            
            DispatchQueue.main.async {
                self.addGeneratedImageToTShirt(image: image)
                self.hideLoadingSpinner()
            }
        }.resume()
    }

    func addGeneratedImageToTShirt(image: UIImage) {
        // Create an imageView for the generated image
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: self.canvasStates[self.activeSideIndex]!.bounds.midX - 50, y: self.canvasStates[self.activeSideIndex]!.bounds.midY - 50, width: 100, height: 100) // Position as per need
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        // Add the image to the canvas view
        self.canvasStates[self.activeSideIndex]?.addSubview(imageView)
    }

    func showLoadingSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = self.view.center
        self.view.addSubview(spinner)
        spinner.startAnimating()
    }

    func hideLoadingSpinner() {
        for subview in self.view.subviews {
            if let spinner = subview as? UIActivityIndicatorView {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }
    


    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        // Open color picker to change the T-shirt color for the active side
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            present(colorPicker, animated: true, completion: nil)
        }
    
    @IBAction func textureButtonTapped(_ sender: UIButton) {
        // Present the texture selection interface
               let textureAlert = UIAlertController(title: "Choose Texture", message: nil, preferredStyle: .actionSheet)
               
               for texture in Workstation.allCases {
                   textureAlert.addAction(UIAlertAction(title: texture.rawValue, style: .default, handler: { _ in
                       self.applyTexture(texture: texture)
                   }))
               }
               
               textureAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               
               // For iPad support
               if let popoverController = textureAlert.popoverPresentationController {
                   popoverController.sourceView = sender
                   popoverController.sourceRect = sender.bounds
               }
               
               present(textureAlert, animated: true, completion: nil)
           }
           
           // MARK: - Texture Selection Delegate Method
           func didSelectTexture(_ texture: Workstation) {
               applyTexture(texture: texture)
           }
           
           // MARK: - Texture Application
           func applyTexture(texture: Workstation) {
               guard let baseImage = baseTShirtImages[activeSideIndex] else {
                   showAlert(message: "Base T-shirt image not available!")
                   return
               }
               
               guard let textureImage = UIImage(named: texture.imageName) else {
                   showAlert(message: "Texture image not found!")
                   return
               }
               
               if let combinedImage = blend(baseImage: baseImage, texture: textureImage) {
                   tShirtImageView.image = combinedImage
                   baseTShirtImages[activeSideIndex] = combinedImage
               } else {
                   showAlert(message: "Failed to apply texture!")
               }
           }
           
           // MARK: - Image Blending Helper
           func blend(baseImage: UIImage, texture: UIImage) -> UIImage? {
               let size = baseImage.size
               
               UIGraphicsBeginImageContextWithOptions(size, false, baseImage.scale)
               
               // Draw the base image
               baseImage.draw(in: CGRect(origin: .zero, size: size))
               
               // Draw the texture image with blending mode and alpha
               texture.draw(in: CGRect(origin: .zero, size: size), blendMode: .multiply, alpha: 0.5)
               
               // Retrieve the blended image
               let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
               
               UIGraphicsEndImageContext()
               
               return blendedImage
           }

    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            self.canvasStates[self.activeSideIndex]?.addImageOverlay(image: selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIColorPickerViewControllerDelegate
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        
        // Change the color of the active T-shirt side's image
        self.tShirtImageView.tintColor = selectedColor
        
        // Also apply the color to the canvas (drawing overlays)
        self.canvasStates[self.activeSideIndex]?.tintColor = selectedColor
    }
    
    // MARK: - Helper Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIView Extensions for Snapshot and Updates
extension UIView {
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
    
    func updateWith(image: UIImage) {
        guard let imageView = subviews.compactMap({ $0 as? UIImageView }).first else { return }
        imageView.image = image
    }
}



// MARK: - UIView Extensions for Canvas Features
extension UIView {
    // Add text overlay to the canvas
    func addTextOverlay(text: String) {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 24) // Default font and size
        label.textColor = .black // Default color
        label.sizeToFit()
        label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY) // Center the text by default
        label.isUserInteractionEnabled = true
        
        // Add gesture recognizer for dragging
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        label.addGestureRecognizer(panGesture)
        
        self.addSubview(label)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        let translation = gesture.translation(in: self)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        gesture.setTranslation(.zero, in: self)
    }
    
    // Enable freehand drawing
    func enableDrawing() {
        let drawingView = DrawingView(frame: self.bounds)
        self.addSubview(drawingView)
    }
    
    // Enable line drawing with styles
    func enableLineDrawing() {
        let lineDrawingView = DrawingView(frame: self.bounds)
        lineDrawingView.isLineMode = true // Custom property to differentiate line mode
        self.addSubview(lineDrawingView)
    }
    
    // Add a sticker (e.g., emoji) to the canvas
    func addStickerOverlay(sticker: String) {
        let label = UILabel()
        label.text = sticker
        label.font = UIFont.systemFont(ofSize: 50) // Default sticker size
        label.sizeToFit()
        label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        label.isUserInteractionEnabled = true
        
        // Add gesture recognizer for dragging
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        label.addGestureRecognizer(panGesture)
        
        self.addSubview(label)
    }
    
    // Add an image overlay
    func addImageOverlay(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: self.bounds.midX - 50, y: self.bounds.midY - 50, width: 100, height: 100) // Default size
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        // Add gesture recognizer for dragging
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
        
        self.addSubview(imageView)
    }
    
    // Enable cropping functionality
    func enableCropping() {
        let croppingView = CroppingView(frame: self.bounds)
        self.addSubview(croppingView)
    }
}

// MARK: - Cropping View
class CroppingView: UIView {
    private var cropRect: CGRect = .zero
    private var cropLayer: CAShapeLayer?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        cropRect.origin = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        cropRect.size = CGSize(width: currentPoint.x - cropRect.origin.x, height: currentPoint.y - cropRect.origin.y)
        updateCropLayer()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cropCanvas()
        self.removeFromSuperview()
    }
    
    private func updateCropLayer() {
        cropLayer?.removeFromSuperlayer()
        cropLayer = CAShapeLayer()
        cropLayer?.path = UIBezierPath(rect: cropRect).cgPath
        cropLayer?.fillColor = UIColor.clear.cgColor
        cropLayer?.strokeColor = UIColor.red.cgColor
        cropLayer?.lineWidth = 2
        self.layer.addSublayer(cropLayer!)
    }
    
    private func cropCanvas() {
        guard let parentView = superview else { return }
        UIGraphicsBeginImageContextWithOptions(parentView.bounds.size, false, 0)
        parentView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let fullImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let cgImage = fullImage?.cgImage?.cropping(to: cropRect) {
            let croppedImage = UIImage(cgImage: cgImage)
            (parentView as? UIImageView)?.image = croppedImage
        }
    }
}

// MARK: - Drawing View
class DrawingView: UIView {
    private var path = UIBezierPath()
    private var startPoint: CGPoint = .zero
    var isLineMode: Bool = false // Determines whether to draw freehand or a straight line
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        startPoint = touch.location(in: self)
        if !isLineMode {
            path.move(to: startPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        
        if isLineMode {
            // Redraw only the current line
            setNeedsDisplay()
            path.removeAllPoints()
            path.move(to: startPoint)
            path.addLine(to: currentPoint)
        } else {
            path.addLine(to: currentPoint)
            startPoint = currentPoint
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path.lineWidth = 2
        path.stroke()
    }
}


 
