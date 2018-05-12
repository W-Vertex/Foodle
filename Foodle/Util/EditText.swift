//
//  EditText.swift
//  Foodle
//
//  Created by 이병찬 on 2018. 2. 7..
//  Copyright © 2018년 root. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class EditText: UIView{
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        setInit()
        clearButton.layer.cornerRadius = clearButton.frame.width / 2
        clearButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        clearButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        textField.rx.text
            .subscribe(onNext: { [unowned self] text in
                guard let text = text else{ return }
                self.setClear(!text.isEmpty)
            }).disposed(by: disposeBag)
    }
    
    private func setInit(){
        // FIXME: EditText에다가 nib으로 생성한 view를 addSubview하고 있는데, 이 방법 보단 nib에 직접 클래스를 지정하고 bundle에서 loadNib 하는 방식을 고려해 보세요.
        let view = UINib.init(nibName: "EditText", bundle: Bundle.init(for: type(of: self))).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: 32)
        view.autoresizingMask = [.flexibleWidth]
        addSubview(view)
    }
    
    private func setClear(_ edit: Bool){
        clearButton.isEnabled = edit
        if edit{
            clearButton.setImage(UIImage.init(named: "exit_icon"), for: .normal)
        }else{ clearButton.setImage(nil, for: .normal) }
    }
    
    @objc func click(){
        textField.text = ""
        clearButton.setImage(nil, for: .normal)
    }
    
}
