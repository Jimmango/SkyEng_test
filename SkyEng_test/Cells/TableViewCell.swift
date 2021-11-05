//
//  TableViewCell.swift
//  SkyEng_test
//
//  Created by Dima Loria on 30.10.2021.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}

class TableViewCell: UITableViewCell {
    
    weak var delegate: TableViewCellDelegate?
    
    static let identifier = "WordPushCell"

    static func nib() -> UINib {
        return UINib(nibName: "WordPushCell", bundle: nil)
    }
    
    var button: UIButton!
    private var title: String = ""
    
    @objc func didTapText() {
        delegate?.didTapButton(with: title)
    }
    
    func configure(with title: String) {
        self.title = title
        button.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitleColor(.link, for: .normal)
    }
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
