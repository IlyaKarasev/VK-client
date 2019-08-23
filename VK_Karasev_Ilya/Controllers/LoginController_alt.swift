//
//  LoginController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 02/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if usernameInput.text == "",
            passwordInput.text == "" {
            performSegue(withIdentifier: "Show Main Screen", sender: sender)
        } else {
            showLoginError()
        }
    }
    
    @IBAction func remindPasswordButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func loginWithFacebookButtonPressed(_ sender: Any) {
    }
    
    
    //MARK: - Private API
    @objc private func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentsInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        scrollView.contentInset = contentsInsets
        scrollView.scrollIndicatorInsets = contentsInsets
    }
    
    @objc private func keyboardWasHidden(notification: Notification) {
        let contentsInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentsInsets
        scrollView.scrollIndicatorInsets = contentsInsets
    }
    
    @objc private func hideKeyboard () {
        self.scrollView?.endEditing(true)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "Show Main Screen" else { return true }
        
        if usernameInput.text == "",
            passwordInput.text == "" {
            return true
        } else {
            showLoginError()
            return false
        }
    }
    
    private func showLoginError() {
        let loginAlert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.passwordInput.text = ""
        }
        loginAlert.addAction(action)
        
        present(loginAlert, animated: true)
    }

}












