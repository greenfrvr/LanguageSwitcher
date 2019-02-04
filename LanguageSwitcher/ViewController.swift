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
        var currentLang = Locale.current.languageCode
        let alert = UIAlertController(title: "Language", message: currentLang, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
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
        language(language:"Base")
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
        language(language:"ar")
        arabicButton.isEnabled = false
        englishButton.isEnabled = true
    }
    
    @IBAction func printString(_ sender: UIButton) {
        let string = NSLocalizedString("Welcome", comment: "")
        
        let alert = UIAlertController(title: "String", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setNativeLanguage(languages: NSArray){
        UserDefaults.standard.set(languages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func language(language : String) {
        var languageCode = UserDefaults.standard
        languageCode.set(language, forKey: "language")
        languageCode.synchronize()
        
        let language = languageCode.string(forKey: "language")!
        var path = Bundle.main.path(forResource: language, ofType: "lproj")!
        if path .isEmpty {
        path = Bundle.main.path(forResource: language, ofType: "lproj")!
        }
        let currentLanguage = Bundle(path: path)
        print(currentLanguage)
    }
}

//extension NSLocale {
//    @objc class func changeLanguageToEn() -> NSLocale {
//        return NSLocale(localeIdentifier: "en")
//    }
//
//    @objc class func changeLanguageToAr() -> NSLocale {
//        return NSLocale(localeIdentifier: "ar")
//    }
//}

