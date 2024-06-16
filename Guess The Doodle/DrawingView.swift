//
//  DrawingView.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 14.06.2024.
//

import SwiftUI
import PencilKit
struct DrawingView: UIViewRepresentable{
    class Coordinator: NSObject, PKCanvasViewDelegate{
        var matchmanager: MatchManager
        init(matchmanager: MatchManager) {
            self.matchmanager = matchmanager
        }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            // TODO: Send The new Drawing Data
        }
    }
    var canvasView = PKCanvasView()
    @ObservedObject var matchManager: MatchManager
    @Binding var eraserEnabled : Bool
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput//herhangi bir aracı ile de çizim yapmayı sağlar
        canvasView.tool = PKInkingTool(.pen,color: .black, width: 5)
        canvasView.isUserInteractionEnabled = matchManager.currentlyDrawing
        canvasView.delegate = context.coordinator
        return canvasView
    }
   
    
    func makeCoordinator() -> Coordinator {
        Coordinator(matchmanager: matchManager)
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //TODO: Handle various updates
        canvasView.tool = eraserEnabled ? PKEraserTool(.vector):PKInkingTool(.pen,color: .black, width: 5)
    }
}

struct DrawingView_Previews: PreviewProvider {
    @State static var eraser = false
    static var previews: some View {
        DrawingView( matchManager: MatchManager(), eraserEnabled: $eraser)
    }
}
