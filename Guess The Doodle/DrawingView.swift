//
//  DrawingView.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 14.06.2024.
//

import SwiftUI
import PencilKit
struct DrawingView: UIViewRepresentable{
    var canvasView = PKCanvasView()
    @ObservedObject var matchManager: MatchManager
    @Binding var eraserEnabled : Bool
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, width: 5)
        canvasView.isUserInteractionEnabled = true
        return canvasView
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //TODO: Handle various updates
    }
}

struct DrawingView_Previews: PreviewProvider {
    @State static var eraser = false
    static var previews: some View {
        DrawingView( matchManager: MatchManager(), eraserEnabled: $eraser)
    }
}
