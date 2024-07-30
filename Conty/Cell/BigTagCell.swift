import UIKit
import SnapKit
import Then

class BigTagCell: BaseCollectionViewCell {
    let textView = UITextView().then {
        $0.textColor = .white
        $0.backgroundColor = .mainTintColor
        $0.isEditable = false
        $0.isSelectable = false
        $0.isUserInteractionEnabled = false
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        super.setupUI()
        contentView.addSubview(textView)
        setConstraints() 
    }

    override func setConstraints() {
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
    }

    func flipColors() {
        let newBackgroundColor: UIColor = textView.backgroundColor == UIColor.mainTintColor ? .white : .mainTintColor
        let newTextColor: UIColor = textView.textColor == UIColor.white ? .black : .white
        UIView.animate(withDuration: 0.3) {
            self.textView.backgroundColor = newBackgroundColor
            self.textView.textColor = newTextColor
        }
    }
    
    func resetColors() {
        textView.backgroundColor = .mainTintColor
        textView.textColor = .white
    }
}
