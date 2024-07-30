import UIKit
import SnapKit
import Then

class EmoticonTagCell: BaseCollectionViewCell {
    static let id = "TagCell"
    
    let tagLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .white
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(tagLabel)
        contentView.layer.cornerRadius = 15
    }
    
    override func setConstraints() {
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            let isSelectedColor: UIColor = isSelected ? .white : .mainTintColor
            let isSelectedTextColor: UIColor = isSelected ? .black : .white
            contentView.backgroundColor = isSelectedColor
            tagLabel.textColor = isSelectedTextColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
}
