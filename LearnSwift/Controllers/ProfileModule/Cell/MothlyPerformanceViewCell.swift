import SnapKit
import UIKit

class MothlyPerformanceViewCell: UITableViewCell{
    
    //MARK: - Public
    var data: [PerformanceModel]?
    func configure(data: [PerformanceModel]) {
        if data.count == 12 {
            contentView.backgroundColor = UIConstants.viewBackgroundColor
            self.data = data
            initialize()
        }
    }
    
    public static var identifier: String {
        get {
            return "MothlyPerformanceViewCell"
        }
    }
    
    //MARK: - Private properties
    
    private let backgorundView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        
        view.layer.shadowOpacity = UIConstants.shadowOpacity
        view.layer.shadowColor = UIConstants.shadowColor
        
        view.backgroundColor = UIConstants.backgroundColorView
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        return view
    }()
    
    private let monthlyView: MothlyPerformanceView = {
        let view = MothlyPerformanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: - Private methods
private extension MothlyPerformanceViewCell {
    func initialize() {
        contentView.addSubview(backgorundView)
        backgorundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.deafaultInset)
            make.top.bottom.equalToSuperview().inset(UIConstants.topBottomDefaultInset)
            make.height.equalTo(UIConstants.backgroundViewHeight)
        }
        
        backgorundView.addSubview(monthlyView)
        monthlyView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(10)
        }
        
        monthlyView.setupView()
        monthlyView.configure(with: self.data ?? [PerformanceModel(value: 0, title: "")])
    }
}

private enum UIConstants {
    static let topBottomDefaultInset: CGFloat = 16
    static let viewBackgroundColor: UIColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
    static let viewCornerRadius: CGFloat = 15
    static let backgroundViewHeight: CGFloat = 370
    static let deafaultInset: CGFloat = 16
    static let backgroundColorView: UIColor = #colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2282280028, alpha: 1)
    static let shadowOpacity: Float = 0.7
    static let shadowColor: CGColor = #colorLiteral(red: 0.7602825761, green: 0.3373456895, blue: 0.904338479, alpha: 1)
}
