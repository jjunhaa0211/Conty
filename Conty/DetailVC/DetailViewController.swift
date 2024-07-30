import UIKit
import SnapKit
import Then
import Foundation

public class DetailViewController: UIViewController {
    var tagList: [String] = []
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        $0.collectionViewLayout = layout
        $0.backgroundColor = .mainTintColor
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.id)
    }
    
    public init(tagList: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        self.tagList = tagList
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .mainTintColor
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        layout()
    }
    
    func layout() {
        [
            collectionView
        ].forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func showToasts(message: String) {
        
        let copiedLabel = UILabel().then {
            $0.text = "copied"
            $0.textColor = UIColor.white
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 26.0, weight: .bold)
        }
        let toastLabel = UILabel().then {
            $0.text = message
            $0.backgroundColor = UIColor.mainSubColor.withAlphaComponent(0.6)
            $0.textColor = UIColor.white
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.alpha = 0.0
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }

        self.view.addSubview(copiedLabel)
        self.view.addSubview(toastLabel)
        
        copiedLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.equalTo(28)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            copiedLabel.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseInOut, animations: {
                copiedLabel.alpha = 0.0
            }, completion: { _ in
                copiedLabel.removeFromSuperview()
            })
        })

        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 3, options: .curveEaseInOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        })
    }
    
    private func saveCopiedText(_ text: String) {
        var copiedItems = UserDefaults.standard.stringArray(forKey: "copiedMessages") ?? []
        if let index = copiedItems.firstIndex(of: text) {
            copiedItems.remove(at: index)
        }
        copiedItems.insert(text, at: 0)
        UserDefaults.standard.set(copiedItems, forKey: "copiedMessages")
    }
}

@available(iOS 16.0, *)
extension DetailViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.id, for: indexPath) as! TagCell
        
        cell.tagLabel.text = tagList[indexPath.item]
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TagCell

        if let text = cell?.tagLabel.text {
            UIPasteboard.general.string = text
            saveCopiedText(text)
            showToasts(message: "방금 클릭한 콘티가 복사되었어요!")
        }
        cell?.isSelected = true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TagCell
        cell?.isSelected = false
    }
}

@available(iOS 16.0, *)
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 24)
            $0.text = tagList[indexPath.item]
            $0.numberOfLines = 0
            let maxWidth = collectionView.frame.width - 88
            $0.preferredMaxLayoutWidth = maxWidth
            $0.sizeToFit()
        }
        let size = label.intrinsicContentSize
        return CGSize(width: size.width + 44, height: size.height + 25)
    }
}


