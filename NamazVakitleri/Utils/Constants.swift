//
//  Constants.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation

enum Cities : String, CaseIterable {
    case Adana
    case Adıyaman
    case Afyonkarahisar
    case Ağrı
    case Amasya
    case Ankara
    case Antalya
    case Artvin
    case Aydın
    case Balıkesir
    case Bilecik
    case Bingöl
    case Bitlis
    case Bolu
    case Burdur
    case Bursa
    case Çanakkale
    case Çankırı
    case Çorum
    case Denizli
    case Diyarbakir
    case Edirne
    case Elazığ
    case Erzincan
    case Erzurum
    case Eskişehir
    case Gaziantep
    case Giresun
    case Gümüşhane
    case Hakkari
    case Hatay
    case Isparta
    case Mersin
    case İstanbul
    case İzmir
    case Kars
    case Kastamonu
    case Kayseri
    case Kırklareli
    case Kırşehir
    case Kocaeli
    case Konya
    case Kütahya
    case Malatya
    case Manisa
    case Kahramanmaraş
    case Mardin
    case Muğla
    case Muş
    case Nevşehir
    case Niğde
    case Ordu
    case Rize
    case Sakarya
    case Samsun
    case Siirt
    case Sinop
    case Sivas
    case Tekirdağ
    case Tokat
    case Trabzon
    case Tunceli
    case Şanlıurfa
    case Uşak
    case Van
    case Yozgat
    case Zonguldak
    case Aksaray
    case Bayburt
    case Karaman
    case Kırıkkale
    case Batman
    case Şırnak
    case Bartın
    case Ardahan
    case Iğdır
    case Yalova
    case Karabük
    case Kilis
    case Osmaniye
    case Düzce
}

enum Constants {
    static let baseURL = "https://namaz-vakti.vercel.app/api/"
    static let timeNames = ["İmsak","Sabah","Öğlen","İkindi","Akşam","Yatsı"]
    static let timezoneRegionName = "Europe/Istanbul"
    static let yyyyMMdd_Format = "yyyy-MM-dd"
    static let dateAndClockFormat = "yyyy-MM-dd HH:mm"
    static let hourAndMinuteFormat = "HH:mm"
    static let gmtTimeZone = "GMT"
    static let timerTextFormat = "%02d:%02d:%02d"
}
