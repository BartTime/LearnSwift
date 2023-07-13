import Foundation
import SnapKit
import UIKit

class CodeTaskCell: UITableViewCell {
    
    var reqFunc: String = ""
    
    //MARK: - Public
    func configure(rowColor: UIColor, text: String, viewModel: DetailViewModel, taskId: Int, taskTest: [String], ask: String?) {
        self.contentView.backgroundColor = rowColor
        self.textView.text = text
        self.viewModel = viewModel
        self.taskId = taskId
        self.reqiredFunc = text
        self.taskTests = taskTest
        self.reqFunc = text
        if let ask = ask {
            self.textView.text = ask
        }
    }
    
    public static var identifier: String {
        get {
            return "CodeTaskCell"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private var viewModel: DetailViewModel!
    private var taskId: Int = 0
    private var reqiredFunc: String = ""
    private var taskTests = [String]()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Code"
        label.font = .systemFont(ofSize: UIConstants.exampleSizeText, weight: .bold)
        label.textColor = UIConstants.textColor
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIConstants.textColor
        textView.font = .systemFont(ofSize: UIConstants.textFontSize)
        textView.backgroundColor = UIConstants.backgroundColor
        textView.layer.cornerRadius = UIConstants.viewCornerRadius
        textView.clipsToBounds = false
        textView.layer.shadowOpacity = UIConstants.shadowOpacity
        textView.layer.shadowColor = UIConstants.shadowColor
        return textView
    }()
    
    private let sendCode: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIConstants.backgroundButton
        button.setTitle("Send Code", for: .normal)
        button.layer.cornerRadius = UIConstants.viewCornerRadius
        button.setTitleColor(UIConstants.textColor, for: .normal)
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIConstants.refreshButtonColor
        button.setTitle("RefreshCode", for: .normal)
        button.layer.cornerRadius = UIConstants.viewCornerRadius
        button.setTitleColor(UIConstants.refreshButtonTextColor, for: .normal)
        return button
    }()
}

private extension CodeTaskCell {
    func initialize() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.defaultInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
        }
        
        contentView.addSubview(sendCode)
        sendCode.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.height.equalTo(UIConstants.buttonHeight)
        }
        
        contentView.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.bottom.equalTo(sendCode.snp.top).inset(-UIConstants.topAndBottomInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.height.equalTo(UIConstants.buttonHeight)
        }
        
        contentView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.top.equalTo(titleLabel.snp.bottom).inset(-UIConstants.topAndBottomInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.bottom.equalTo(refreshButton.snp.top).inset(-UIConstants.topAndBottomInset)
        }
        
        sendCode.addTarget(self, action: #selector(sendTask), for: .touchUpInside)
        
        refreshButton.addTarget(self, action: #selector(refreshCode), for: .touchUpInside)
    }
    
    @objc func refreshCode() {
        self.textView.text = self.reqFunc
    }
    
    @objc func sendTask() {
        let task = textView.text ?? ""
        self.viewModel.checkRequredFunc(text: task, requredFunc: reqiredFunc, taskId: taskId, taskTests: taskTests)
    }
}

private enum UIConstants {
    static let backgroundColor: UIColor = #colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2282280028, alpha: 1)
    static let defaultInset: CGFloat = 16
    static let textColor: UIColor = .white
    static let topAndBottomInset: CGFloat = 10
    static let viewCornerRadius: CGFloat = 10
    static let exampleSizeText: CGFloat = 25
    static let textFontSize: CGFloat = 15
    static let backgroundButton: UIColor = #colorLiteral(red: 0.5456466675, green: 0.9215924144, blue: 0.4836524725, alpha: 1)
    static let buttonHeight: CGFloat = 50
    static let shadowOpacity: Float = 1.0
    static let shadowColor: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let refreshButtonColor: UIColor = #colorLiteral(red: 0.2163890354, green: 0.2163890354, blue: 0.2163890354, alpha: 1)
    static let refreshButtonTextColor: UIColor = #colorLiteral(red: 0.7610284686, green: 0.7657273412, blue: 0.7825757861, alpha: 1)
}
