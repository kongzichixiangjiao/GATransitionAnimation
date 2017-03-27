//
//  EAGLViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/26.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import OpenGLES
import GLKit

class EAGLViewController: UIViewController {

    var glContext: EAGLContext!
    var glLayer: CAEAGLLayer!
    var frameBuffer: GLuint = 0
    var colorRenderBuffer: GLuint = 0
    var frameBufferWidth: GLint = 0
    var frameBufferHeight: GLint = 0
    var effect: GLKBaseEffect!
    
    lazy var glView: UIView = {
        let v = UIView(frame: CGRect(x: 140, y: 300, width: 200, height: 200))
        v.backgroundColor = UIColor.orange
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(glView)
        
        inits()
        setUpBuffers()
        drawFrame()
    }
    
    func inits() {
        glContext = EAGLContext(api: .openGLES2)
        EAGLContext.setCurrent(glContext)
        
        glLayer = CAEAGLLayer()
        glLayer.frame = glView.bounds
        glLayer.drawableProperties = [kEAGLDrawablePropertyRetainedBacking : false, kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8]
        self.glView.layer.addSublayer(glLayer)
        
        effect = GLKBaseEffect()
    }
    
    func setUpBuffers() {
        glGenFramebuffers(1, &frameBuffer)
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), frameBuffer)
        
        glGenRenderbuffers(1, &colorRenderBuffer)
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), colorRenderBuffer)
        glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_RENDERBUFFER), colorRenderBuffer)
        
        glContext.renderbufferStorage(Int(GL_RENDERBUFFER), from: glLayer)
        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_WIDTH), &frameBufferWidth)
        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_HEIGHT), &frameBufferHeight)
        
        if glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER)) != UInt32(GL_FRAMEBUFFER_COMPLETE) {
            glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER))
        }
    }
    
    func drawFrame() {
        //bind framebuffer & set viewport
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), frameBuffer);
        glViewport(0, 0, frameBufferWidth, frameBufferHeight);
        //bind shader program
        effect.prepareToDraw()
        //clear the screen
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        glClearColor(0.0, 0.0, 0.0, 1.0)
        //set up vertices
        let vertices = [-0.5, -0.5, -1.0, 0.0, 0.5, -1.0, 0.5, -0.5, -1.0];
        //set up colors
        let colors = [ 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0]
        //draw triangle
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue))
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.color.rawValue))
        glVertexAttribPointer(GLuint(GLKVertexAttrib.position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, vertices)
        glVertexAttribPointer(GLuint(GLKVertexAttrib.color.rawValue),4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, colors)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        //present render buffer
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), colorRenderBuffer)
        glContext.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }
    
    func tearDownBuffers() {
        if frameBuffer != 0 {
            glDeleteFramebuffers(1, &frameBuffer)
            frameBuffer = 0
        }
        if colorRenderBuffer != 0 {
            glDeleteFramebuffers(1, &colorRenderBuffer)
            colorRenderBuffer = 0
        }
    }
    
    deinit {
        tearDownBuffers()
        EAGLContext.setCurrent(nil)
    }
}
