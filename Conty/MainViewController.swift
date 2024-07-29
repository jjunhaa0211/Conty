import UIKit
import SnapKit
import Then

struct CellData {
    var title: String
    var subtitle: String
    var emoji: String
    var image: UIImage
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var cellData: [CellData] = []
    
    var dataSource: [[String]] = [
        happyEmoticons,
        specialEmoticons,
        worryEmojis,
        embarrassedEmojis,
        catEmojis,
        dogEmojis,
        requestEmojis,
        greetingEmojis
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainTintColor
        title = "ʕ◍·̀Ⱉ·́◍ʔ"
        
        setupNavigationBar()
        setupCollectionView()
        loadData()
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
    
    
    func loadData() {
        cellData = [
            CellData(title: "행복해요", subtitle: "໒꒰ྀི•ू⁼̴̶̤̀༥⁼̴̶̤́•ू ꒱ྀི১", emoji: "🥴", image: UIImage(systemName: "house")!),
            CellData(title: "화났어요", subtitle: "ʕ•̀⤙•́ ʔ", emoji: "😡", image: UIImage(systemName: "car")!),
            CellData(title: "걱정돼요", subtitle: "( ⸝⸝･̆⤚･̆⸝⸝)", emoji: "🥺", image: UIImage(systemName: "bicycle")!),
            CellData(title: "곤란해요", subtitle: "(〃•︵•〃)", emoji: "😖", image: UIImage(systemName: "airplane")!),
            CellData(title: "고양이", subtitle: "₍˄·͈༝·͈˄₎", emoji: "🐱", image: UIImage(systemName: "tram")!),
            CellData(title: "강아지", subtitle: "૮(˳❛ ⌔̫ ❛˳)ა", emoji: "🐶", image: UIImage(systemName: "ferry")!),
            CellData(title: "부탁해요", subtitle: "(っ ॑꒳ ॑c )", emoji: "🙏", image: UIImage(systemName: "tram")!),
            CellData(title: "인사해요", subtitle: "꒰⸝⸝•ᴗ•⸝⸝꒱੭⁾⁾", emoji: "👋", image: UIImage(systemName: "ferry")!)
        ]
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout().then {
            $0.minimumInteritemSpacing = 25
            $0.minimumLineSpacing = 25
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.dataSource = self
            $0.delegate = self
            $0.contentInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
            $0.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        let data = cellData[indexPath.item]
        cell.configure(with: data.image, emoji: data.emoji, title: data.title, subtitle: data.subtitle)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoticonsForItem = dataSource[indexPath.row]

        let detailVC = DetailViewController(tagList: emoticonsForItem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalInsets = collectionView.contentInset.left + collectionView.contentInset.right + 25 * (2 - 1)
        
        let totalWidthAvailable = collectionView.bounds.width - totalInsets
        
        let sideLength = (totalWidthAvailable / 2).rounded(.down)
        
        return CGSize(width: sideLength, height: sideLength)
    }
}
