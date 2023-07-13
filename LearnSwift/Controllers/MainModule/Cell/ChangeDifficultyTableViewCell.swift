import UIKit

class ChangeDifficultyTableViewCell: UITableViewCell {

    var viewModel: MainViewModel!
    
    func configure(rowColor: UIColor, viewModel: MainViewModel) {
        collectionView.backgroundColor = rowColor
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    public static var identifier: String {
        get {
            return "ChangeDifficultyTableViewCell"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var collectionView: UICollectionView!
}

private extension ChangeDifficultyTableViewCell {
    func initialize() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DifficultyItemCell.self, forCellWithReuseIdentifier: DifficultyItemCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ChangeDifficultyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DifficultyItemCell.identifier, for: indexPath) as? DifficultyItemCell else {
            return UICollectionViewCell()
        }
        let t = ["All", "Easy", "Medium", "Hard"]
        let color: [UIColor] = [UIConstants.textColor ,UIConstants.greenColor, UIConstants.yellowColor, UIConstants.redColor]
        cell.configure(with: t[indexPath.row], textColor: color[indexPath.row], viewModel: self.viewModel)
        return cell
    }
}

extension ChangeDifficultyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 50)
    }
}

private enum UIConstants {
    static let textColor: UIColor = .white
    static let greenColor: UIColor = #colorLiteral(red: 0.3954334855, green: 0.6769045591, blue: 0.3914109468, alpha: 1)
    static let redColor: UIColor = #colorLiteral(red: 0.7817292809, green: 0.3032317162, blue: 0.2282724679, alpha: 1)
    static let yellowColor: UIColor = #colorLiteral(red: 1, green: 0.852222681, blue: 0.6064352393, alpha: 1)
}
