//
//  Cellid1.swift
//  Ertegi
//
//  Created by Kuanysh on 14.08.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit

class Cellid1: UITableViewCell {
    @IBOutlet weak var imageViewOfCellid1: UIImageView!

    @IBOutlet weak var nameOfBook: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
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
