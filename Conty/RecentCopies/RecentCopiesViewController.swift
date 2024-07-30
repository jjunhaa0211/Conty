import UIKit
import SnapKit
import Then

class RecentCopiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var lastSelectedIndexPath: IndexPath?
    
    private var copiedMessages: [String] = []
    private let tableView = UITableView().then {
        $0.backgroundColor = .mainTintColor
        $0.allowsMultipleSelection = false
    }
    private let emptyLabel = UILabel().then {
        $0.text = "헉! 복사한 것이 하나도 없네요 o̴̶̷̥᷅⌓o̴̶̷᷄"
        $0.textAlignment = .center
        $0.textColor = .mainSubColor
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCopiedMessages()
    }
    
    private func setupUI() {
        view.backgroundColor = .mainTintColor
        title = "ʕ·ᴥ·　ʔ"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        let clearAllButton = UIBarButtonItem(title: "ʢ✘.✘ʡ", style: .plain, target: self, action: #selector(clearAllCopiedMessages))
        clearAllButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .bold)], for: .normal)
        navigationItem.rightBarButtonItem = clearAllButton
    }
    
    private func loadCopiedMessages() {
        copiedMessages = UserDefaults.standard.stringArray(forKey: "copiedMessages") ?? []
        tableView.reloadData()
        updateEmptyLabelVisibility()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(copiedMessages.count, 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if copiedMessages.isEmpty {
            cell.selectionStyle = .none
            cell.backgroundColor = .mainTintColor
            cell.textLabel?.textColor = .mainTintColor
            cell.isUserInteractionEnabled = false
            cell.layer.borderColor = UIColor.mainTintColor.cgColor
            cell.layer.borderWidth = 0
            
            cell.layer.shadowColor = UIColor.mainTintColor.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowRadius = 0
            cell.layer.shadowOpacity = 0
        } else {
            cell.textLabel?.text = copiedMessages[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .mainTintColor
            cell.selectionStyle = .default
            cell.isUserInteractionEnabled = true
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = false
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.2
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 4)
            cell.layer.shadowRadius = 6
            cell.layer.shadowOpacity = 0.1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !copiedMessages.isEmpty {
            if let lastIndexPath = lastSelectedIndexPath, let lastCell = tableView.cellForRow(at: lastIndexPath) {
                lastCell.backgroundColor = .mainTintColor
                lastCell.textLabel?.textColor = .white
            }

            let cell = tableView.cellForRow(at: indexPath)
            cell?.backgroundColor = .white
            cell?.textLabel?.textColor = .black
            
            UIPasteboard.general.string = copiedMessages[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            showToast(message: "방금 클릭한 콘티가 복사되었어요!")
            
            lastSelectedIndexPath = indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = .mainTintColor
            cell.textLabel?.textColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            copiedMessages.remove(at: indexPath.row)
            UserDefaults.standard.set(copiedMessages, forKey: "copiedMessages")
            tableView.reloadData()
            updateEmptyLabelVisibility()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return copiedMessages.count > 1
    }
    
    @objc private func clearAllCopiedMessages() {
        UserDefaults.standard.removeObject(forKey: "copiedMessages")
        copiedMessages.removeAll()
        tableView.reloadData()
        updateEmptyLabelVisibility()
    }
    
    private func updateEmptyLabelVisibility() {
        emptyLabel.isHidden = !copiedMessages.isEmpty
    }
}
