import UIKit
import SnapKit
import Then

class CustomCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .mainSubColor
    }
    
    let centerLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 50)
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let subtitleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        contentView.addSubview(centerLabel)
        centerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalTo(imageView.snp.bottom).offset(20)
            $0.width.height.equalTo(50)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(centerLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(15)
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(titleLabel)
        }
        
        contentView.backgroundColor = .mainTintColor
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.2
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOpacity = 0.1
    }
    
    func configure(emoji: String?, title: String, subtitle: String) {
        centerLabel.text = emoji
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
