import UIKit
import SnapKit
import Then

struct CellData {
    var title: String
    var subtitle: String
    var emoji: String
    var image: UIImage
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var cellData: [CellData] = []
    
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
            CellData(title: "신나요", subtitle: "՞ ̳o̴̶̷̤ ̫ o̴̶̷̤ ̳՞", emoji: "😆", image: UIImage(systemName: "tram")!),
            CellData(title: "공부해요", subtitle: "ʕo•ᴥ•ʔ✎", emoji: "🤓", image: UIImage(systemName: "ferry")!),
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
        let emoticons = [
            "᪗꒰ྀི ̥_ ̫ _ ̥꒱ྀིଓ",
            "- ̗̀( ˘˙‎ࠔ˙˘) ̖́-",
            "(⁎ᴗ͈ ⩊ ᴗ͈⁎)",
            "(´-ᴗ-⸝⸝ก)",
            "꒰ᐢ๑⸝⸝˙‎‎‎‎ࠔ˙⸝⸝๑ᐢ꒱",
            "(⸝⸝¯ᵕ¯⸝⸝)",
            "꒰ ՞ •͈ 𐃬 ꔷ͈ ՞꒱",
            ".｡Oᐡ(⁎°ᴗ°⁎ᐡ )",
            "(°͈̅​ ᢐ °͈̅)",
            "໒꒰ྀི•ू⁼̴̶̤̀༥⁼̴̶̤́•ू ꒱ྀི১",
            "૮₍ྀི ੑ𐬎 ݂. ٜ .݂ୄྀིა ̥ﾟ☘.⋆",
            "₍ ⺣̤̬ ₎ ʰ ⁱ",
            "(՞ ܸ.ˬ.ܸ՞)”",
            "꒰՞⸝⸝⊃ ·̫ <՞꒱",
            "(⸝⸝ᵕᴗᵕ⸝⸝)",
            "ฅ(՞៸៸> ᗜ < ៸៸՞)ฅ",
            "( 'ч' )",
            "( ܸ ⩌⩊⩌ ܸ )",
            "(⸝⸝◜~◝⸝⸝)",
            "ʕ ⸝⸝⸝⁰⃚⃙̴ ༝ ⁰⃚⃙̴ ʔ",
            "꒰ᐡ⸝ɞ̴̶̷ 𞥙 ɞ̴̶̷⸝ᐡ꒱ ׁ ₊",
            "ミ⁰̷̴͈ 。⁰̷̴͈ ミ",
            "ദ്ദി ( ᵔ ᗜ ᵔ )",
            "(´｡• ◡ •｡`) ♡",
            "૮ ․ ․ ྀིა",
            "₍^ >ヮ<^₎ .ᐟ.ᐟ",
            "(๑’ᗢ’๑)ฅ",
            "(* ॑ᵕ ॑* )♡",
            "(っ* ॑꒳ ॑*)╮",
            "(∗'ര ᎑ ര`∗)",
            " ̗  ̗꤮︠  ̫꤮︡ ̗  ̗",
            "('. • ᵕ •. `)",
            "˶ᵔ'ヮ'ᵔ˶",
            "(*•؎ •*)",
            "( ˶ˆᗜˆ˵ )",
            "(,,>ヮ<,,)!",
            "৻(≧ᗜ≦৻)",
            "˶•⩊•˶",
            "( ͈ര ̫ര ͈)",
            "(ᐢᗜᐢ)",
            "(๑'ᵕ'๑)⸝*",
            "( • ᴗ - ) ✧",
            "໒꒰ྀིᵔ ᵕ ᵔ ꒱ྀི১",
            "໒꒰ྀི ˶ᵔ  ³ ᵔ˶ ꒱ྀིა",
            "໒꒰ྀི∩ ᵒ̴̶̷̤‧̫ ᵒ̴̶̷̤ ∩꒱ྀི১",
            "՞ ̥_  ̫ _ ̥՞♡",
            "(̨̡ᐢ ⸝⸝o̴̶̷̤ ̫̭ o̴̶̷̤⸝⸝ ᐢ)̧̢",
            "꒰ ᐡᴗ͈ ·̫ ᴗ͈ ꒱♡",
            "- ̗̀ෆ⎛˶'ᵕ'˶ ⎞ෆ ̖́-",
            "꜆₍ᐢ˶•ᴗ•˶ᐢ₎꜆",
            "ʜɪ⚞ ᕬᕬ ෆ",
            "₍ᐢ• ᴗ⁠ •ᐢ₎",
            "ˁˆˑˆˀ",
            "(˶• ﻌ •˶)",
            "ʕ・ᵌ・ʔ",
            "(˶• ֊ •˶)",
            "ᐢ ̳ᴗ ̫ ᴗ ̳ᐢ",
            "(ᐢ⑅•ᴗ•⑅ᐢ)",
            "ʕ˶´• ᴥ •`˶ʔ",
            "(՞˶･֊･˶՞)",
            "٩(˙ᵕ˙⑅๑)",
            "( · ❛ ֊ ❛)"
        ]
        
        let detailVC = DetailViewController(tagList: emoticons)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalInsets = collectionView.contentInset.left + collectionView.contentInset.right + 25 * (2 - 1)
        
        let totalWidthAvailable = collectionView.bounds.width - totalInsets
        
        let sideLength = (totalWidthAvailable / 2).rounded(.down)
        
        return CGSize(width: sideLength, height: sideLength)
    }
}
