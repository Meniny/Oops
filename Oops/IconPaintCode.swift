//
//  IconPainting.swift
//  Oops
//
//  Created by Meniny on 2016-07-17.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation
import UIKit

public extension Oops {
    
    public class IconPainting: NSObject {
        
        // Oops.IconPainting.Cache
        public struct Cache {
            static var imageOfCheckmark: UIImage?
            static var checkmarkTargets: [AnyObject]?
            static var imageOfCross: UIImage?
            static var crossTargets: [AnyObject]?
            static var imageOfNotice: UIImage?
            static var noticeTargets: [AnyObject]?
            static var imageOfWarning: UIImage?
            static var warningTargets: [AnyObject]?
            static var imageOfInfo: UIImage?
            static var infoTargets: [AnyObject]?
            static var imageOfEditor: UIImage?
            static var editTargets: [AnyObject]?
            static var imageOfQuestion: UIImage?
            static var questionTargets: [AnyObject]?
        }
        
        // Drawing Methods
        public class func drawCheckmark() {
            // Checkmark Shape Drawing
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 73.25, y: 14.05))
            checkmarkShapePath.addCurve(to: CGPoint(x: 64.51, y: 13.86), controlPoint1: CGPoint(x: 70.98, y: 11.44), controlPoint2: CGPoint(x: 66.78, y: 11.26))
            checkmarkShapePath.addLine(to: CGPoint(x: 27.46, y: 52))
            checkmarkShapePath.addLine(to: CGPoint(x: 15.75, y: 39.54))
            checkmarkShapePath.addCurve(to: CGPoint(x: 6.84, y: 39.54), controlPoint1: CGPoint(x: 13.48, y: 36.93), controlPoint2: CGPoint(x: 9.28, y: 36.93))
            checkmarkShapePath.addCurve(to: CGPoint(x: 6.84, y: 49.02), controlPoint1: CGPoint(x: 4.39, y: 42.14), controlPoint2: CGPoint(x: 4.39, y: 46.42))
            checkmarkShapePath.addLine(to: CGPoint(x: 22.91, y: 66.14))
            checkmarkShapePath.addCurve(to: CGPoint(x: 27.28, y: 68), controlPoint1: CGPoint(x: 24.14, y: 67.44), controlPoint2: CGPoint(x: 25.71, y: 68))
            checkmarkShapePath.addCurve(to: CGPoint(x: 31.65, y: 66.14), controlPoint1: CGPoint(x: 28.86, y: 68), controlPoint2: CGPoint(x: 30.43, y: 67.26))
            checkmarkShapePath.addLine(to: CGPoint(x: 73.08, y: 23.35))
            checkmarkShapePath.addCurve(to: CGPoint(x: 73.25, y: 14.05), controlPoint1: CGPoint(x: 75.52, y: 20.75), controlPoint2: CGPoint(x: 75.7, y: 16.65))
            checkmarkShapePath.close()
            checkmarkShapePath.miterLimit = 4;
            
            UIColor.white.setFill()
            checkmarkShapePath.fill()
        }
        
        public class func drawCross() {
            // Cross Shape Drawing
            let crossShapePath = UIBezierPath()
            crossShapePath.move(to: CGPoint(x: 10, y: 70))
            crossShapePath.addLine(to: CGPoint(x: 70, y: 10))
            crossShapePath.move(to: CGPoint(x: 10, y: 10))
            crossShapePath.addLine(to: CGPoint(x: 70, y: 70))
            crossShapePath.lineCapStyle = CGLineCap.round;
            crossShapePath.lineJoinStyle = CGLineJoin.round;
            UIColor.white.setStroke()
            crossShapePath.lineWidth = 14
            crossShapePath.stroke()
        }
        
        public class func drawNotice() {
            // Notice Shape Drawing
            let noticeShapePath = UIBezierPath()
            noticeShapePath.move(to: CGPoint(x: 72, y: 48.54))
            noticeShapePath.addLine(to: CGPoint(x: 72, y: 39.9))
            noticeShapePath.addCurve(to: CGPoint(x: 66.38, y: 34.01), controlPoint1: CGPoint(x: 72, y: 36.76), controlPoint2: CGPoint(x: 69.48, y: 34.01))
            noticeShapePath.addCurve(to: CGPoint(x: 61.53, y: 35.97), controlPoint1: CGPoint(x: 64.82, y: 34.01), controlPoint2: CGPoint(x: 62.69, y: 34.8))
            noticeShapePath.addCurve(to: CGPoint(x: 60.36, y: 35.78), controlPoint1: CGPoint(x: 61.33, y: 35.97), controlPoint2: CGPoint(x: 62.3, y: 35.78))
            noticeShapePath.addLine(to: CGPoint(x: 60.36, y: 33.22))
            noticeShapePath.addCurve(to: CGPoint(x: 54.16, y: 26.16), controlPoint1: CGPoint(x: 60.36, y: 29.3), controlPoint2: CGPoint(x: 57.65, y: 26.16))
            noticeShapePath.addCurve(to: CGPoint(x: 48.73, y: 29.89), controlPoint1: CGPoint(x: 51.64, y: 26.16), controlPoint2: CGPoint(x: 50.67, y: 27.73))
            noticeShapePath.addLine(to: CGPoint(x: 48.73, y: 28.71))
            noticeShapePath.addCurve(to: CGPoint(x: 43.49, y: 21.64), controlPoint1: CGPoint(x: 48.73, y: 24.78), controlPoint2: CGPoint(x: 46.98, y: 21.64))
            noticeShapePath.addCurve(to: CGPoint(x: 39.03, y: 25.37), controlPoint1: CGPoint(x: 40.97, y: 21.64), controlPoint2: CGPoint(x: 39.03, y: 23.01))
            noticeShapePath.addLine(to: CGPoint(x: 39.03, y: 9.07))
            noticeShapePath.addCurve(to: CGPoint(x: 32.24, y: 2), controlPoint1: CGPoint(x: 39.03, y: 5.14), controlPoint2: CGPoint(x: 35.73, y: 2))
            noticeShapePath.addCurve(to: CGPoint(x: 25.45, y: 9.07), controlPoint1: CGPoint(x: 28.56, y: 2), controlPoint2: CGPoint(x: 25.45, y: 5.14))
            noticeShapePath.addLine(to: CGPoint(x: 25.45, y: 41.47))
            noticeShapePath.addCurve(to: CGPoint(x: 24.29, y: 43.44), controlPoint1: CGPoint(x: 25.45, y: 42.45), controlPoint2: CGPoint(x: 24.68, y: 43.04))
            noticeShapePath.addCurve(to: CGPoint(x: 9.55, y: 43.04), controlPoint1: CGPoint(x: 16.73, y: 40.88), controlPoint2: CGPoint(x: 11.88, y: 40.69))
            noticeShapePath.addCurve(to: CGPoint(x: 8, y: 46.58), controlPoint1: CGPoint(x: 8.58, y: 43.83), controlPoint2: CGPoint(x: 8, y: 45.2))
            noticeShapePath.addCurve(to: CGPoint(x: 14.4, y: 55.81), controlPoint1: CGPoint(x: 8.19, y: 50.31), controlPoint2: CGPoint(x: 12.07, y: 53.84))
            noticeShapePath.addLine(to: CGPoint(x: 27.2, y: 69.56))
            noticeShapePath.addCurve(to: CGPoint(x: 42.91, y: 77.8), controlPoint1: CGPoint(x: 30.5, y: 74.47), controlPoint2: CGPoint(x: 35.73, y: 77.21))
            noticeShapePath.addCurve(to: CGPoint(x: 43.88, y: 77.8), controlPoint1: CGPoint(x: 43.3, y: 77.8), controlPoint2: CGPoint(x: 43.68, y: 77.8))
            noticeShapePath.addCurve(to: CGPoint(x: 47.18, y: 78), controlPoint1: CGPoint(x: 45.04, y: 77.8), controlPoint2: CGPoint(x: 46.01, y: 78))
            noticeShapePath.addLine(to: CGPoint(x: 48.34, y: 78))
            noticeShapePath.addLine(to: CGPoint(x: 48.34, y: 78))
            noticeShapePath.addCurve(to: CGPoint(x: 71.61, y: 52.08), controlPoint1: CGPoint(x: 56.48, y: 78), controlPoint2: CGPoint(x: 69.87, y: 75.05))
            noticeShapePath.addCurve(to: CGPoint(x: 72, y: 48.54), controlPoint1: CGPoint(x: 71.81, y: 51.29), controlPoint2: CGPoint(x: 72, y: 49.72))
            noticeShapePath.close()
            noticeShapePath.miterLimit = 4;
            
            UIColor.white.setFill()
            noticeShapePath.fill()
        }
        
        public class func drawWarning() {
            // Color Declarations
            let greyColor = UIColor(red: 0.236, green: 0.236, blue: 0.236, alpha: 1.000)
            
            // Warning Group
            // Warning Circle Drawing
            let warningCirclePath = UIBezierPath()
            warningCirclePath.move(to: CGPoint(x: 40.94, y: 63.39))
            warningCirclePath.addCurve(to: CGPoint(x: 36.03, y: 65.55), controlPoint1: CGPoint(x: 39.06, y: 63.39), controlPoint2: CGPoint(x: 37.36, y: 64.18))
            warningCirclePath.addCurve(to: CGPoint(x: 34.14, y: 70.45), controlPoint1: CGPoint(x: 34.9, y: 66.92), controlPoint2: CGPoint(x: 34.14, y: 68.49))
            warningCirclePath.addCurve(to: CGPoint(x: 36.22, y: 75.54), controlPoint1: CGPoint(x: 34.14, y: 72.41), controlPoint2: CGPoint(x: 34.9, y: 74.17))
            warningCirclePath.addCurve(to: CGPoint(x: 40.94, y: 77.5), controlPoint1: CGPoint(x: 37.54, y: 76.91), controlPoint2: CGPoint(x: 39.06, y: 77.5))
            warningCirclePath.addCurve(to: CGPoint(x: 45.86, y: 75.35), controlPoint1: CGPoint(x: 42.83, y: 77.5), controlPoint2: CGPoint(x: 44.53, y: 76.72))
            warningCirclePath.addCurve(to: CGPoint(x: 47.93, y: 70.45), controlPoint1: CGPoint(x: 47.18, y: 74.17), controlPoint2: CGPoint(x: 47.93, y: 72.41))
            warningCirclePath.addCurve(to: CGPoint(x: 45.86, y: 65.35), controlPoint1: CGPoint(x: 47.93, y: 68.49), controlPoint2: CGPoint(x: 47.18, y: 66.72))
            warningCirclePath.addCurve(to: CGPoint(x: 40.94, y: 63.39), controlPoint1: CGPoint(x: 44.53, y: 64.18), controlPoint2: CGPoint(x: 42.83, y: 63.39))
            warningCirclePath.close()
            warningCirclePath.miterLimit = 4;
            
            greyColor.setFill()
            warningCirclePath.fill()
            
            
            // Warning Shape Drawing
            let warningShapePath = UIBezierPath()
            warningShapePath.move(to: CGPoint(x: 46.23, y: 4.26))
            warningShapePath.addCurve(to: CGPoint(x: 40.94, y: 2.5), controlPoint1: CGPoint(x: 44.91, y: 3.09), controlPoint2: CGPoint(x: 43.02, y: 2.5))
            warningShapePath.addCurve(to: CGPoint(x: 34.71, y: 4.26), controlPoint1: CGPoint(x: 38.68, y: 2.5), controlPoint2: CGPoint(x: 36.03, y: 3.09))
            warningShapePath.addCurve(to: CGPoint(x: 31.5, y: 8.77), controlPoint1: CGPoint(x: 33.01, y: 5.44), controlPoint2: CGPoint(x: 31.5, y: 7.01))
            warningShapePath.addLine(to: CGPoint(x: 31.5, y: 19.36))
            warningShapePath.addLine(to: CGPoint(x: 34.71, y: 54.44))
            warningShapePath.addCurve(to: CGPoint(x: 40.38, y: 58.16), controlPoint1: CGPoint(x: 34.9, y: 56.2), controlPoint2: CGPoint(x: 36.41, y: 58.16))
            warningShapePath.addCurve(to: CGPoint(x: 45.67, y: 54.44), controlPoint1: CGPoint(x: 44.34, y: 58.16), controlPoint2: CGPoint(x: 45.67, y: 56.01))
            warningShapePath.addLine(to: CGPoint(x: 48.5, y: 19.36))
            warningShapePath.addLine(to: CGPoint(x: 48.5, y: 8.77))
            warningShapePath.addCurve(to: CGPoint(x: 46.23, y: 4.26), controlPoint1: CGPoint(x: 48.5, y: 7.01), controlPoint2: CGPoint(x: 47.74, y: 5.44))
            warningShapePath.close()
            warningShapePath.miterLimit = 4;
            
            greyColor.setFill()
            warningShapePath.fill()
        }
        
        public class func drawInfo() {
            // Color Declarations
            let color0 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
            
            // Info Shape Drawing
            let infoShapePath = UIBezierPath()
            infoShapePath.move(to: CGPoint(x: 45.66, y: 15.96))
            infoShapePath.addCurve(to: CGPoint(x: 45.66, y: 5.22), controlPoint1: CGPoint(x: 48.78, y: 12.99), controlPoint2: CGPoint(x: 48.78, y: 8.19))
            infoShapePath.addCurve(to: CGPoint(x: 34.34, y: 5.22), controlPoint1: CGPoint(x: 42.53, y: 2.26), controlPoint2: CGPoint(x: 37.47, y: 2.26))
            infoShapePath.addCurve(to: CGPoint(x: 34.34, y: 15.96), controlPoint1: CGPoint(x: 31.22, y: 8.19), controlPoint2: CGPoint(x: 31.22, y: 12.99))
            infoShapePath.addCurve(to: CGPoint(x: 45.66, y: 15.96), controlPoint1: CGPoint(x: 37.47, y: 18.92), controlPoint2: CGPoint(x: 42.53, y: 18.92))
            infoShapePath.close()
            infoShapePath.move(to: CGPoint(x: 48, y: 69.41))
            infoShapePath.addCurve(to: CGPoint(x: 40, y: 77), controlPoint1: CGPoint(x: 48, y: 73.58), controlPoint2: CGPoint(x: 44.4, y: 77))
            infoShapePath.addLine(to: CGPoint(x: 40, y: 77))
            infoShapePath.addCurve(to: CGPoint(x: 32, y: 69.41), controlPoint1: CGPoint(x: 35.6, y: 77), controlPoint2: CGPoint(x: 32, y: 73.58))
            infoShapePath.addLine(to: CGPoint(x: 32, y: 35.26))
            infoShapePath.addCurve(to: CGPoint(x: 40, y: 27.67), controlPoint1: CGPoint(x: 32, y: 31.08), controlPoint2: CGPoint(x: 35.6, y: 27.67))
            infoShapePath.addLine(to: CGPoint(x: 40, y: 27.67))
            infoShapePath.addCurve(to: CGPoint(x: 48, y: 35.26), controlPoint1: CGPoint(x: 44.4, y: 27.67), controlPoint2: CGPoint(x: 48, y: 31.08))
            infoShapePath.addLine(to: CGPoint(x: 48, y: 69.41))
            infoShapePath.close()
            color0.setFill()
            infoShapePath.fill()
        }
        
        public class func drawEdit() {
            // Color Declarations
            let color = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
            
            // Edit shape Drawing
            let editPathPath = UIBezierPath()
            editPathPath.move(to: CGPoint(x: 71, y: 2.7))
            editPathPath.addCurve(to: CGPoint(x: 71.9, y: 15.2), controlPoint1: CGPoint(x: 74.7, y: 5.9), controlPoint2: CGPoint(x: 75.1, y: 11.6))
            editPathPath.addLine(to: CGPoint(x: 64.5, y: 23.7))
            editPathPath.addLine(to: CGPoint(x: 49.9, y: 11.1))
            editPathPath.addLine(to: CGPoint(x: 57.3, y: 2.6))
            editPathPath.addCurve(to: CGPoint(x: 69.7, y: 1.7), controlPoint1: CGPoint(x: 60.4, y: -1.1), controlPoint2: CGPoint(x: 66.1, y: -1.5))
            editPathPath.addLine(to: CGPoint(x: 71, y: 2.7))
            editPathPath.addLine(to: CGPoint(x: 71, y: 2.7))
            editPathPath.close()
            editPathPath.move(to: CGPoint(x: 47.8, y: 13.5))
            editPathPath.addLine(to: CGPoint(x: 13.4, y: 53.1))
            editPathPath.addLine(to: CGPoint(x: 15.7, y: 55.1))
            editPathPath.addLine(to: CGPoint(x: 50.1, y: 15.5))
            editPathPath.addLine(to: CGPoint(x: 47.8, y: 13.5))
            editPathPath.addLine(to: CGPoint(x: 47.8, y: 13.5))
            editPathPath.close()
            editPathPath.move(to: CGPoint(x: 17.7, y: 56.7))
            editPathPath.addLine(to: CGPoint(x: 23.8, y: 62.2))
            editPathPath.addLine(to: CGPoint(x: 58.2, y: 22.6))
            editPathPath.addLine(to: CGPoint(x: 52, y: 17.1))
            editPathPath.addLine(to: CGPoint(x: 17.7, y: 56.7))
            editPathPath.addLine(to: CGPoint(x: 17.7, y: 56.7))
            editPathPath.close()
            editPathPath.move(to: CGPoint(x: 25.8, y: 63.8))
            editPathPath.addLine(to: CGPoint(x: 60.1, y: 24.2))
            editPathPath.addLine(to: CGPoint(x: 62.3, y: 26.1))
            editPathPath.addLine(to: CGPoint(x: 28.1, y: 65.7))
            editPathPath.addLine(to: CGPoint(x: 25.8, y: 63.8))
            editPathPath.addLine(to: CGPoint(x: 25.8, y: 63.8))
            editPathPath.close()
            editPathPath.move(to: CGPoint(x: 25.9, y: 68.1))
            editPathPath.addLine(to: CGPoint(x: 4.2, y: 79.5))
            editPathPath.addLine(to: CGPoint(x: 11.3, y: 55.5))
            editPathPath.addLine(to: CGPoint(x: 25.9, y: 68.1))
            editPathPath.close()
            editPathPath.miterLimit = 4;
            editPathPath.usesEvenOddFillRule = true;
            color.setFill()
            editPathPath.fill()
        }
        
        public class func drawQuestion() {
            // Color Declarations
            let color = UIColor(red: CGFloat(1.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0))
            // Questionmark Shape Drawing
            let questionShapePath = UIBezierPath()
            questionShapePath.move(to: CGPoint(x: CGFloat(33.75), y: CGFloat(54.1)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(44.15), y: CGFloat(54.1)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(44.15), y: CGFloat(47.5)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(51.85), y: CGFloat(37.2)), controlPoint1: CGPoint(x: CGFloat(44.15), y: CGFloat(42.9)), controlPoint2: CGPoint(x: CGFloat(46.75), y: CGFloat(41.2)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(61.95), y: CGFloat(19.9)), controlPoint1: CGPoint(x: CGFloat(59.05), y: CGFloat(31.6)), controlPoint2: CGPoint(x: CGFloat(61.95), y: CGFloat(28.5)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(41.45), y: CGFloat(2.8)), controlPoint1: CGPoint(x: CGFloat(61.95), y: CGFloat(7.6)), controlPoint2: CGPoint(x: CGFloat(52.85), y: CGFloat(2.8)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(25.05), y: CGFloat(5.8)), controlPoint1: CGPoint(x: CGFloat(34.75), y: CGFloat(2.8)), controlPoint2: CGPoint(x: CGFloat(29.65), y: CGFloat(3.8)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(25.05), y: CGFloat(14.4)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(38.15), y: CGFloat(12.3)), controlPoint1: CGPoint(x: CGFloat(29.15), y: CGFloat(13.2)), controlPoint2: CGPoint(x: CGFloat(32.35), y: CGFloat(12.3)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(49.65), y: CGFloat(20.8)), controlPoint1: CGPoint(x: CGFloat(45.65), y: CGFloat(12.3)), controlPoint2: CGPoint(x: CGFloat(49.65), y: CGFloat(14.4)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(43.65), y: CGFloat(31.7)), controlPoint1: CGPoint(x: CGFloat(49.65), y: CGFloat(26)), controlPoint2: CGPoint(x: CGFloat(47.95), y: CGFloat(28.4)))
            questionShapePath.addCurve(to: CGPoint(x: CGFloat(33.75), y: CGFloat(46.6)), controlPoint1: CGPoint(x: CGFloat(37.15), y: CGFloat(36.9)), controlPoint2: CGPoint(x: CGFloat(33.75), y: CGFloat(39.7)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(33.75), y: CGFloat(54.1)))
            questionShapePath.close()
            questionShapePath.move(to: CGPoint(x: CGFloat(33.15), y: CGFloat(75.4)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(45.35), y: CGFloat(75.4)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(45.35), y: CGFloat(63.7)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(33.15), y: CGFloat(63.7)))
            questionShapePath.addLine(to: CGPoint(x: CGFloat(33.15), y: CGFloat(75.4)))
            questionShapePath.close()
            color.setFill()
            questionShapePath.fill()
        }
        
        // Generated Images
        public class var imageOfCheckmark: UIImage {
            if (Oops.IconPainting.Cache.imageOfCheckmark != nil) {
                return Oops.IconPainting.Cache.imageOfCheckmark!
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            Oops.IconPainting.drawCheckmark()
            Oops.IconPainting.Cache.imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Oops.IconPainting.Cache.imageOfCheckmark!
        }
        
        public class var imageOfCross: UIImage {
            if (Oops.IconPainting.Cache.imageOfCross != nil) {
                return Oops.IconPainting.Cache.imageOfCross!
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            Oops.IconPainting.drawCross()
            Oops.IconPainting.Cache.imageOfCross = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Oops.IconPainting.Cache.imageOfCross!
        }
        
        public class var imageOfNotice: UIImage {
            if (Oops.IconPainting.Cache.imageOfNotice != nil) {
                return Oops.IconPainting.Cache.imageOfNotice!
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            Oops.IconPainting.drawNotice()
            Oops.IconPainting.Cache.imageOfNotice = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Oops.IconPainting.Cache.imageOfNotice!
        }
        
        public class var imageOfWarning: UIImage {
            if (Oops.IconPainting.Cache.imageOfWarning != nil) {
                return Oops.IconPainting.Cache.imageOfWarning!
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            Oops.IconPainting.drawWarning()
            Oops.IconPainting.Cache.imageOfWarning = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Oops.IconPainting.Cache.imageOfWarning!
        }
        
        public class var imageOfInfo: UIImage {
            if (Oops.IconPainting.Cache.imageOfInfo != nil) {
                return Oops.IconPainting.Cache.imageOfInfo!
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            Oops.IconPainting.drawInfo()
            Oops.IconPainting.Cache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Oops.IconPainting.Cache.imageOfInfo!
        }
        
        public class var imageOfEditor: UIImage {
            if (Oops.IconPainting.Cache.imageOfEditor != nil) {
                return Oops.IconPainting.Cache.imageOfEditor!
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            Oops.IconPainting.drawEdit()
            Oops.IconPainting.Cache.imageOfEditor = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Oops.IconPainting.Cache.imageOfEditor!
        }
        
        public class var imageOfQuestion: UIImage {
            if (Oops.IconPainting.Cache.imageOfQuestion != nil) {
                return Oops.IconPainting.Cache.imageOfQuestion!
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            Oops.IconPainting.drawQuestion()
            Oops.IconPainting.Cache.imageOfQuestion = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return Oops.IconPainting.Cache.imageOfQuestion!
        }
    }
}

