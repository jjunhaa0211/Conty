import UIKit
import SnapKit
import Then
import Foundation

public class DetailViewController: UIViewController {
    var tagList: [String] = []
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout().then {
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 18
            $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        $0.collectionViewLayout = layout
        $0.backgroundColor = .mainTintColor
        $0.register(EmoticonTagCell.self, forCellWithReuseIdentifier: EmoticonTagCell.id)
    }
    
    public init(tagList: [String]) {
        self.tagList = tagList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension DetailViewController {
    private func setupCollectionView() {
        view.backgroundColor = .mainTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .mainTintColor
        collectionView.register(EmoticonTagCell.self, forCellWithReuseIdentifier: EmoticonTagCell.id)
        
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }

    private func setupCollectionViewConstraints() {
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonTagCell.id, for: indexPath) as! EmoticonTagCell
        
        cell.tagLabel.text = tagList[indexPath.item]
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? EmoticonTagCell, let text = cell.tagLabel.text {
            UIPasteboard.general.string = text
            saveCopiedText(text)
            showToast(message: "방금 클릭한 콘티가 복사되었어요!")
            cell.isSelected = true
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? EmoticonTagCell {
            cell.isSelected = false
        }
    }
}

@available(iOS 16.0, *)
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 24)
            $0.text = tagList[indexPath.item]
            $0.numberOfLines = 0
            $0.preferredMaxLayoutWidth = collectionView.frame.width - Constants.collectionViewHorizontalPadding
            $0.sizeToFit()
        }
        let size = label.intrinsicContentSize
        return CGSize(width: size.width + Constants.cellHorizontalExtraSpace, height: size.height + Constants.cellVerticalExtraSpace)
    }
}
