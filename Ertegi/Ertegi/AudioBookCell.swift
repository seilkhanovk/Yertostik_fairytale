//
//  AudioBookCell.swift
//  Ertegi
//
//  Created by Kuanysh on 16.08.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit

class AudioBookCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleOfBook: UILabel!
    @IBOutlet weak var artistOfBook: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.frame = CGRect(x: 16, y: 0, width: UIScreen.main.bounds.width - 30, height: 127)
        contentView.layer.cornerRadius = 8
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
