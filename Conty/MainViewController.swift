import UIKit
import SnapKit
import Then
import GoogleMobileAds

struct CellData {
    var title: String
    var subtitle: String
    var emoji: String
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GADBannerViewDelegate {
    
    var collectionView: UICollectionView!
    var cellData: [CellData] = []
    
    lazy var bannerView = GADBannerView().then {
        //ca-app-pub-3940256099942544/2934735716 테스트키
        $0.adUnitID = "ca-app-pub-9038207137251650/1163778242"
        $0.rootViewController = self
        $0.load(GADRequest())
        $0.delegate = self
    }
        
    var dataSource: [[String]] = [
        happyEmoticons,
        specialEmoticons,
        surpriseEmoticons,
        worryEmojis,
        embarrassedEmojis,
        catEmojis,
        dogEmojis,
        requestEmojis,
        greetingEmojis,
        bearEmojis,
        rabbits,
        ducks,
        smartEmoticons,
        pigEmoticons,
        magicEmoticons,
        loveEmoticons,
        sickEmoticons,
        thumbsUpEmoticons,
        sadEmoticons,
        winkEmoticons,
        unmotivatedEmoticons,
        sleepyEmoticons,
        fistEmoticons,
        gunEmoticons,
        christmasEmoticons,
        flowerEmoticons,
        kissEmoticons,
        excitedEmoticons
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainTintColor
        title = "ʕ◍·̀Ⱉ·́◍ʔ"
        
        setupNavigationBar()
        setupCollectionView()
        loadData()
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-5)
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(45)
        }
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

        let leftButton = UIBarButtonItem(title: "ʕ　·ᴥ·ʔ", style: .plain, target: self, action: #selector(leftButtonTapped))
        let rightButton = UIBarButtonItem(title: "ʕ·ᴥ·　ʔ", style: .plain, target: self, action: #selector(rightButtonTapped))
        
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12.0, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        leftButton.setTitleTextAttributes(buttonAttributes, for: .normal)
        rightButton.setTitleTextAttributes(buttonAttributes, for: .normal)
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }

    
    
    func loadData() {
        guard dataSource.count >= 27 else {
            print("Data source does not have enough categories.")
            return
        }

        cellData = [
            CellData(title: "#행복해요", subtitle: dataSource[0].randomElement() ?? "No subtitle available", emoji: "🥴"),
            CellData(title: "#특별해요", subtitle: dataSource[1].randomElement() ?? "No subtitle available", emoji: "😄"),
            CellData(title: "#놀랐어요", subtitle: dataSource[2].randomElement() ?? "No subtitle available", emoji: "🫢"),
            CellData(title: "#걱정돼요", subtitle: dataSource[3].randomElement() ?? "No subtitle available", emoji: "🥺"),
            CellData(title: "#곤란해요", subtitle: dataSource[4].randomElement() ?? "No subtitle available", emoji: "😖"),
            CellData(title: "#냥냥이", subtitle: dataSource[5].randomElement() ?? "No subtitle available", emoji: "🐱"),
            CellData(title: "#댕댕이", subtitle: dataSource[6].randomElement() ?? "No subtitle available", emoji: "🐶"),
            CellData(title: "#부탁해요", subtitle: dataSource[7].randomElement() ?? "No subtitle available", emoji: "🙏"),
            CellData(title: "#인사해요", subtitle: dataSource[8].randomElement() ?? "No subtitle available", emoji: "👋"),
            CellData(title: "#곰탱이", subtitle: dataSource[9].randomElement() ?? "No subtitle available", emoji: "🐻"),
            CellData(title: "#토순이", subtitle: dataSource[10].randomElement() ?? "No subtitle available", emoji: "🐰"),
            CellData(title: "#꽥꽥이", subtitle: dataSource[11].randomElement() ?? "No subtitle available", emoji: "🐥"),
            CellData(title: "#똑똑해요", subtitle: dataSource[12].randomElement() ?? "No subtitle available", emoji: "🤓"),
            CellData(title: "#돼지", subtitle: dataSource[13].randomElement() ?? "No subtitle available", emoji: "🐷"),
            CellData(title: "#마법", subtitle: dataSource[14].randomElement() ?? "No subtitle available", emoji: "🔮"),
            CellData(title: "#사랑해요", subtitle: dataSource[15].randomElement() ?? "No subtitle available", emoji: "🫶"),
            CellData(title: "#아파요", subtitle: dataSource[16].randomElement() ?? "No subtitle available", emoji: "🤒"),
            CellData(title: "#따봉", subtitle: dataSource[17].randomElement() ?? "No subtitle available", emoji: "👍"),
            CellData(title: "#우울해요", subtitle: dataSource[18].randomElement() ?? "No subtitle available", emoji: "😔"),
            CellData(title: "#윙크", subtitle: dataSource[19].randomElement() ?? "No subtitle available", emoji: "😉"),
            CellData(title: "#의욕없어요", subtitle: dataSource[20].randomElement() ?? "No subtitle available", emoji: "😞"),
            CellData(title: "#졸려요", subtitle: dataSource[21].randomElement() ?? "No subtitle available", emoji: "😴"),
            CellData(title: "#주먹", subtitle: dataSource[22].randomElement() ?? "No subtitle available", emoji: "✊"),
            CellData(title: "#총", subtitle: dataSource[23].randomElement() ?? "No subtitle available", emoji: "🔫"),
            CellData(title: "#크리스마스", subtitle: dataSource[24].randomElement() ?? "No subtitle available", emoji: "🎄"),
            CellData(title: "#꽃", subtitle: dataSource[25].randomElement() ?? "No subtitle available", emoji: "🌸"),
            CellData(title: "#키스", subtitle: dataSource[26].randomElement() ?? "No subtitle available", emoji: "💋"),
            CellData(title: "#흥분해요", subtitle: dataSource[27].randomElement() ?? "No subtitle available", emoji: "😆")
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
        cell.configure(emoji: data.emoji, title: data.title, subtitle: data.subtitle)
        
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
    
    @objc func leftButtonTapped() {
        print("왼쪽 버튼이 눌렸습니다.")
        self.navigationController?.pushViewController(BigEmoticonsViewController(tagList: tagList), animated: true)
    }

    @objc func rightButtonTapped() {
        print("오른쪽 버튼이 눌렸습니다.")
        let recentCopiesVC = RecentCopiesViewController()
        navigationController?.pushViewController(recentCopiesVC, animated: true)
    }
}
