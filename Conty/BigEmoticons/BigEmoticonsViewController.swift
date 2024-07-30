import UIKit
import SnapKit
import Then

public class BigEmoticonsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var tagList: [String] = []
    var selectedIndexPath: IndexPath?

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
         let layout = LeftAlignedCollectionViewFlowLayout()
         layout.minimumLineSpacing = 10
         layout.minimumInteritemSpacing = 10
         layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
         
         $0.collectionViewLayout = layout
         $0.backgroundColor = .mainTintColor
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
        view.backgroundColor = .mainTintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BigTagCell.self, forCellWithReuseIdentifier: "tagCellId")
        layoutCollectionView()
        
        title = "ʕ　·ᴥ·ʔ"
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance().then {
                $0.configureWithOpaqueBackground()
                $0.backgroundColor = UIColor.mainTintColor
                $0.titleTextAttributes = textAttributes
                
            }
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.mainTintColor
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }
    
    func layoutCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func registerCells() {
        collectionView.register(BigTagCell.self, forCellWithReuseIdentifier: "tagCellId")
    }
}

extension BigEmoticonsViewController {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCellId", for: indexPath) as? BigTagCell else {
            fatalError("Unable to dequeue TagCell")
        }
        cell.textView.text = tagList[indexPath.row]
        cell.textView.tag = indexPath.item
        if indexPath == selectedIndexPath {
            cell.flipColors()
        } else {
            cell.resetColors()
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            return
        }
        
        if let selectedIndexPath = selectedIndexPath, let oldCell = collectionView.cellForItem(at: selectedIndexPath) as? BigTagCell {
            oldCell.resetColors()
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BigTagCell {
            cell.flipColors()
            UIPasteboard.general.string = cell.textView.text
            showToast(message: "방금 클릭한 콘티가 복사되었어요!")
        }
        
        selectedIndexPath = indexPath
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tagList[indexPath.item]
        let width = collectionView.frame.width - 20
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        
        let targetSize = CGSize(width: width, height: UIView.layoutFittingExpandedSize.height)
        let estimatedSize = label.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return CGSize(width: width, height: estimatedSize.height)
    }
}
