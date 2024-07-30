import UIKit
import SnapKit
import Then

class CustomCollectionViewCell: BaseCollectionViewCell {
    static let id = "CustomCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .mainSubColor
    }
    
    private let centerLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 50)
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private let subtitleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func setupUI() {
        super.setupUI()
        [imageView, centerLabel, titleLabel, subtitleLabel].forEach(contentView.addSubview)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        centerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalTo(imageView.snp.bottom).offset(20)
            $0.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(centerLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(15)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(titleLabel)
        }
    }
    
    func configure(emoji: String?, title: String, subtitle: String) {
        centerLabel.text = emoji
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
