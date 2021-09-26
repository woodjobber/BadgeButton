//
//  BadgeButton.swift
//  xiangzhe
//
//  Created by chengbin on 2021/9/9.
//

import UIKit

public enum Anchor {
    case TopLeft(topOffset: CGFloat, leftOffset: CGFloat)
    case TopRight(topOffset: CGFloat, rightOffset: CGFloat)
    case BottomLeft(bottomOffset: CGFloat, leftOffset: CGFloat)
    case BottomRight(bottomOffset: CGFloat, rightOffset: CGFloat)
    case center
}

/// 在 UIButton 上显示角标
open class BadgeButton: UIButton {
    fileprivate var badgeLabel: UILabel
    
    open var badgeValue: String? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    open var cornerRadiusFactor: CGFloat = 2 {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    fileprivate var innerVerticalMargin: CGFloat = 0.0 {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    fileprivate var innerHorizontalMargin: CGFloat = 0.0 {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    open var verticalMargin: CGFloat {
        set {
            innerVerticalMargin = max(0, newValue)
        }
        
        get {
            return innerVerticalMargin
        }
    }
    
    open var horizontalMargin: CGFloat {
        set {
            self.innerHorizontalMargin = max(0, newValue)
        }
        
        get {
            return innerHorizontalMargin
        }
    }
    
    open var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    open var badgeBackgroundColor: UIColor = .red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    open var badgeTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    open var badgeTextFont: UIFont = .systemFont(ofSize: 10) {
        didSet {
            badgeLabel.font = badgeTextFont
        }
    }
    
    open var edgeInsetLeft: CGFloat {
        set {
            if let edgeInset = badgeEdgeInsets {
                badgeEdgeInsets = UIEdgeInsets(top: edgeInset.top, left: newValue, bottom: edgeInset.bottom, right: edgeInset.right)
            }
            else {
                badgeEdgeInsets = UIEdgeInsets(top: 0.0, left: newValue, bottom: 0.0, right: 0.0)
            }
        }
        get {
            if let edgeInset = badgeEdgeInsets {
                return edgeInset.left
            }
            
            return 0.0
        }
    }
    
    open var edgeInsetRight: CGFloat {
        set {
            if let edgeInset = badgeEdgeInsets {
                badgeEdgeInsets = UIEdgeInsets(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: newValue)
            }
            else {
                badgeEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: newValue)
            }
        }
        get {
            if let edgeInset = badgeEdgeInsets {
                return edgeInset.right
            }
            
            return 0.0
        }
    }
    
    open var edgeInsetTop: CGFloat {
        set {
            if let edgeInset = badgeEdgeInsets {
                badgeEdgeInsets = UIEdgeInsets(top: newValue, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
            }
            else {
                badgeEdgeInsets = UIEdgeInsets(top: newValue, left: 0.0, bottom: 0.0, right: 0.0)
            }
        }
        get {
            if let edgeInset = badgeEdgeInsets {
                return edgeInset.top
            }
            
            return 0.0
        }
    }
    
    open var edgeInsetBottom: CGFloat {
        set {
            if let edgeInset = badgeEdgeInsets {
                self.badgeEdgeInsets = UIEdgeInsets(top: edgeInset.top, left: edgeInset.left, bottom: newValue, right: edgeInset.right)
            }
            else {
                self.badgeEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: newValue, right: 0.0)
            }
        }
        get {
            if let edgeInset = badgeEdgeInsets {
                return edgeInset.bottom
            }
            
            return 0.0
        }
    }
    
    /// 角标锚点
    open var badgeAnchor: Anchor = .TopRight(topOffset: 0.0, rightOffset: 0.0) {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    fileprivate var anchorIndex: Int = 0 {
        didSet {
            switch anchorIndex {
            case 0:
                badgeAnchor = .TopLeft(topOffset: topOffset, leftOffset: leftOffset)
            case 1:
                badgeAnchor = .TopRight(topOffset: topOffset, rightOffset: rightOffset)
            case 2:
                badgeAnchor = .BottomLeft(bottomOffset: buttomOffset, leftOffset: leftOffset)
            case 3:
                badgeAnchor = .BottomRight(bottomOffset: buttomOffset, rightOffset: rightOffset)
            case 4:
                badgeAnchor = .center
            default:
                anchorIndex = 1
            }
        }
    }

    open var anchor: Int {
        set {
            anchorIndex = min(max(0, newValue), 4)
        }
        
        get {
            return anchorIndex
        }
    }
    
    open var leftOffset: CGFloat = 0 {
        didSet {
            // get anchor of index and assign to anchorIndex
            // to trigger view to update
            let ach = anchor
            anchorIndex = ach
        }
    }
    
    open var rightOffset: CGFloat = 0 {
        didSet {
            let ach = anchor
            anchorIndex = ach
        }
    }
    
    open var topOffset: CGFloat = 0 {
        didSet {
            let ach = anchor
            anchorIndex = ach
        }
    }

    open var buttomOffset: CGFloat = 0 {
        didSet {
            let ach = anchor
            self.anchorIndex = ach
        }
    }

    /// 适用于 TopRight
    open var autoAnchor: Bool = true {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    override public init(frame: CGRect) {
        badgeLabel = UILabel()
        super.init(frame: frame)
        setupBadgeViewWithString(badgeText: "")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        badgeLabel = UILabel()
        super.init(coder: aDecoder)
        setupBadgeViewWithString(badgeText: "")
    }
    
    open func initWithFrame(frame: CGRect, withBadgeString badgeString: String, withBadgeInsets badgeInsets: UIEdgeInsets, badgeAnchor: Anchor = .TopRight(topOffset: 0.0, rightOffset: 0.0)) -> AnyObject {
        badgeLabel = UILabel()
        badgeEdgeInsets = badgeInsets
        self.badgeAnchor = badgeAnchor
        setupBadgeViewWithString(badgeText: badgeString)
        return self
    }
    
    fileprivate func setupBadgeViewWithString(badgeText: String?) {
        badgeLabel.clipsToBounds = true
        badgeLabel.text = badgeText
        badgeLabel.font = badgeTextFont
        badgeLabel.textAlignment = .center
        badgeLabel.sizeToFit()
        let badgeSize = badgeLabel.bounds.size
        
        let height = max(10, CGFloat(badgeSize.height) + innerVerticalMargin)
        let width = autoAnchor ? max(height, CGFloat(badgeSize.width) + innerHorizontalMargin) : max(0, CGFloat(badgeSize.width) + innerHorizontalMargin)
        
        var vertical: CGFloat, horizontal: CGFloat
        var x: CGFloat = 0, y: CGFloat = 0
        
        if let badgeInset = badgeEdgeInsets {
            vertical = CGFloat(badgeInset.top) - CGFloat(badgeInset.bottom)
            horizontal = CGFloat(badgeInset.left) - CGFloat(badgeInset.right)
        }
        else {
            vertical = 0.0
            horizontal = 0.0
        }
        
        // calculate badge X Y position
        calculateXYForBadge(x: &x, y: &y, badgeSize: CGSize(width: width, height: height))
        
        // add badgeEdgeInset
        x = x + horizontal
        y = y + vertical
        
        badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        
        setupBadgeStyle()
        addSubview(badgeLabel)
        
        if let text = badgeText {
            badgeLabel.isHidden = !text.isEmpty ? false : true
        }
        else {
            badgeLabel.isHidden = true
        }
    }
    
    fileprivate func calculateXYForBadge(x: inout CGFloat, y: inout CGFloat, badgeSize: CGSize) {
        switch badgeAnchor {
        case .TopLeft(let topOffset, let leftOffset):
            x = -badgeSize.width / 2 + leftOffset
            y = -badgeSize.height / 2 + topOffset
            
        case .TopRight(let topOffset, let rightOffset):
            if autoAnchor {
                x = bounds.size.width + rightOffset - badgeSize.width / 2
            }
            else {
                x = bounds.size.width + rightOffset
            }
            
            y = -badgeSize.height / 2 + topOffset
            
        case .BottomLeft(let bottomOffset, let leftOffset):
            x = -badgeSize.width / 2 + leftOffset
            y = bounds.size.height - badgeSize.height / 2 + bottomOffset
        case .BottomRight(let bottomOffset, let rightOffset):
            x = bounds.size.width - badgeSize.width / 2 + rightOffset
            y = bounds.size.height - badgeSize.height / 2 + bottomOffset
        case .center:
            x = bounds.size.width / 2 - badgeSize.width / 2
            y = bounds.size.height / 2 - badgeSize.height / 2
        }
    }
    
    fileprivate func setupBadgeStyle() {
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.textColor = badgeTextColor
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / cornerRadiusFactor
    }
}
