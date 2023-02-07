//
//  HomeTableViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/17/23.
//

import UIKit

class ShadowTableViewCell: UITableViewCell {

    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let shadowView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear

        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(containerView)
        self.containerView.backgroundColor = .white
        self.containerView.layer.cornerRadius = 8
        self.containerView.layer.masksToBounds = true
        
       // containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
   //     containerView.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        //shadowView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 10).isActive = true
        shadowView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        shadowView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        shadowView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
     //   shadowView.heightAnchor.constraint(equalToConstant:100).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
   }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dropShadow(cornerRadius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dropShadow(cornerRadius: CGFloat) {
        self.shadowView.layer.cornerRadius = cornerRadius
        self.shadowView.layer.masksToBounds = false
        
        //How Blurred shadow is
        self.shadowView.layer.shadowRadius = 8
        
        //How transparent the drop shadow is
        self.shadowView.layer.shadowOpacity = 0.23
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        
        
        //How far the shadow is offset from the UITableViewCell's Frame
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height:3)
        
        let shadowBounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width-20, height: self.bounds.height-20)
        self.shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowBounds, cornerRadius: 8).cgPath

        self.shadowView.layer.shouldRasterize = true
        self.shadowView.layer.rasterizationScale = UIScreen.main.scale
    }

}
