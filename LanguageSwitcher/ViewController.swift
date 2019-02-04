//
//  ViewController.swift
//  LanguageSwitcher
//
//  Created by Katerina Chubarova on 2/1/19.
//  Copyright © 2019 Katerina Chubarova. All rights reserved.
//

import UIKit
//*************
//все закоментированное это другой способ изменения языка
//*************
class ViewController: UIViewController {
    
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentLang = Locale.preferredLanguages[0]
        if (currentLang == "ar") {
            arabicButton.isEnabled = false
        } else if (currentLang == "en") {
            englishButton.isEnabled = false
        }
    }
    
    @IBAction func showLanguage(_ sender: UIButton) {
        let currentLang = Locale.current.languageCode
        let alert = UIAlertController(title: "Language", message: currentLang, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeToEnglish(_ sender: UIButton) {
        //        let original = class_getClassMethod(NSLocale.self, #selector(getter: NSLocale.current))!
        //        var currentLang = Locale.current.languageCode
        //        print("current lang was", currentLang)
        //        let swizzled = class_getClassMethod(NSLocale.self, #selector(NSLocale.changeLanguageToEn))!
        //        method_exchangeImplementations(original, swizzled)
        //        currentLang = Locale.current.languageCode
        //        print("current lang switched to ", currentLang)
        changeLanguage(language:"Base")
        arabicButton.isEnabled = true
        englishButton.isEnabled = false
    }
    
    @IBAction func changeToArabic(_ sender: UIButton) {
        //        var currentLang = Locale.current.languageCode
        //        let original = class_getClassMethod(NSLocale.self, #selector(getter: NSLocale.current))!
        //        print("current lang was", currentLang)
        //        let swizzled = class_getClassMethod(NSLocale.self, #selector(NSLocale.changeLanguageToAr))!
        //        method_exchangeImplementations(original, swizzled)
        //        currentLang = Locale.current.languageCode
        //        print("current lang switched to ", currentLang)
        changeLanguage(language:"ar")
        arabicButton.isEnabled = false
        englishButton.isEnabled = true
    }
    
    @IBAction func printString(_ sender: UIButton) {
        let alert = UIAlertController(title: NSLocalizedString("Hello", comment: ""), message: "Welcome".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //This sets native language for app, no need to handle bundles manualy (requires app restart).
    private func setNativeLanguage(_ lang: String){
        var languages = ["en", "ar"]
        if lang == "ar" { languages.reverse() }
        
        UserDefaults.standard.set(languages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    //Alternative way, we just save language config and using appropriate bundle instead.
    func changeLanguage(language: String) {
        setNativeLanguage(language)
        
        UserDefaults.standard.set(language, forKey: "language")
        UserDefaults.standard.synchronize()
    }
}

// MARK: Localizable
public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localized, value: "", comment: "")
    }
}

extension Bundle {
    static var localized: Bundle {
        let language = UserDefaults.standard.string(forKey: "language") ?? "Base"
        guard let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj"), !bundlePath.isEmpty else {
            return Bundle.main
        }
        return Bundle(path: bundlePath) ?? Bundle.main
    }
}
