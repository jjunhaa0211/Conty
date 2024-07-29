import UIKit
import SnapKit
import Then
import Foundation

class TagCell: UICollectionViewCell {
    
    static var id: String = "TagCell"
    
    let tagLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tagLabel)
        contentView.backgroundColor = .mainTintColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOpacity = 0.1
        
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    func setConstraint() {
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func updateSelectedState() {
        if isSelected {
            contentView.backgroundColor = UIColor.white
            tagLabel.textColor = .black
        } else {
            contentView.backgroundColor = .mainTintColor
            tagLabel.textColor = .white
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false // Reset the selected state
    }
}
