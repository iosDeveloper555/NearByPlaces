//
//  AppConstant.swift
//  InterviewTesk
//
//  Created by Amarendra on 10/12/22.
//

import Foundation
import UIKit


//MARK:- For testing
 let BASE_URL = "https://placesnearbyme.a1professionals.net/api/"
let IMAGE_BASE_URL = "http://placesnearbyme.a1professionals.net/storage/"

//MARK: - New live url

//let BASE_URL = "http://3.141.165.222:3000/api/user/"


let SCREENHEIGHT =  UIScreen.main.bounds.height
let SCREENWIDTH =  UIScreen.main.bounds.width
let APPSTATE = UIApplication.shared.applicationState

var TOPSPACING =  CGFloat(22)
var NAVIHEIGHT =  CGFloat(44)
var STATUSBARHEIGHT =  CGFloat(20)
var TOPLABELSAPACING =  CGFloat(21)

var CURRENTLAT =  30.69951335
var CURRENTLONG =  76.69104083

var COUNTRYCODE =  Locale.current.regionCode

var TYPE_ALL =  "all"
var TYPE_BS =  "Bader & Saunen"
var TYPE_SS =  "Strande & Seen"
var TYPE_HC =  "Hotels  & Camping"




var CURRENTUNIT =  "Centimeters"

let GoogleMapKey = "AIzaSyDFPQu9rxw0T1FEkxpeTZMjOawBaqVcJzc"//"AIzaSyCIP5XpjREmM2JXWNg4CiKnK2-56xekAd4"


let APPCOLOR = UIColor.init(hexString: "007FFF")//.init(red: 29/255, green: 121/255, blue: 255/255, alpha: 1) //

let APPCOLOR2 = UIColor.init(red: 5/255, green: 112/255, blue: 178/255, alpha: 1)
let APPCOLOR3 = UIColor.init(red: 0/255, green: 105/255, blue: 162/255, alpha: 1)
let PLACEHOLDERCOLOR = UIColor.init(red: 171/255, green: 185/255, blue: 197/255, alpha: 1)
let OTPCOLOR = UIColor.init(red: 240/255, green: 243/255, blue: 245/255, alpha: 1)
let TEXTFILEDPLACEHOLDERCOLOR = UIColor.init(red: 176/255, green: 185/255, blue: 200/255, alpha: 1)

let SEEKERCOLOR = UIColor.init(red: 243/255, green: 244/255, blue: 245/255, alpha: 1)

let LINECOLOR = UIColor.init(red: 0/255, green: 104/255, blue: 255/255, alpha: 1) //

let NOTPLAYCOLOR = UIColor.init(red: 250/255, green: 251/255, blue: 252/255, alpha: 1) //

let CHATINACTIVECOLOR = UIColor.init(red: 100/255, green: 122/255, blue: 155/255, alpha: 1)

let TIMEACTIVECOLOR = UIColor.init(red: 176/255, green: 185/255, blue: 200/255, alpha: 1)

let HOMESADOWCOLOR = UIColor.init(red: 17/255, green: 83/255, blue: 97/255, alpha: 0.16)

let SADOWCOLOR = UIColor.init(red: 55/255, green: 91/255, blue: 132/255, alpha: 0.15)

let LIKECOLOR = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.5) //

//999999

let TEXTCOLOR = UIColor.init(red: 0/255, green: 104/255, blue: 255/255, alpha: 1)
//6b6b6b

let DETAILSCOLOR = UIColor.init(red: 188/255, green: 187/255, blue: 187/255, alpha: 1)
//999999

let TAB_UNSELECTED_COLOR = UIColor.init(red: 78/255, green: 153/255, blue: 198/255, alpha: 1)


let DIDNOT = UIColor.init(red: 175/255, green: 175/255, blue: 175/255, alpha: 1) //979797
let RESENDNOW = UIColor.init(red: 0/255, green: 73/255, blue: 119/255, alpha: 1) //004977

let PLAYDISABLECOLOR = UIColor.init(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
let PLAYCOLOR = UIColor.init(red: 3/255, green: 3/255, blue: 3/255, alpha: 1)
let DELETECOLOR = UIColor.init(red: 242/255, green: 74/255, blue: 74/255, alpha: 1)

//HANGOUT TYPE
let SOCAILBACK = UIColor.init(red: 245/255, green: 249/255, blue: 252/255, alpha: 1)
let SOCAILTEXRT = UIColor.init(red: 166/255, green: 199/255, blue: 234/255, alpha: 1)

let TRAVELBACK = UIColor.init(red: 254/255, green: 244/255, blue: 245/255, alpha: 1)
let TRAVELTEXRT = UIColor.init(red: 245/255, green: 149/255, blue: 152/255, alpha: 1)

let SPORTBACK = UIColor.init(red: 255/255, green: 248/255, blue: 242/255, alpha: 1)
let SPORTTEXRT = UIColor.init(red: 254/255, green: 189/255, blue: 125/255, alpha: 1)

let BUSSINESSBACK = UIColor.init(red: 248/255, green: 252/255, blue: 247/255, alpha: 1)
let BUSSINESSTEXRT = UIColor.init(red: 187/255, green: 220/255, blue: 173/255, alpha: 1)

let WAVECOLOR = UIColor.init(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)



let APPDEL = UIApplication.shared.delegate as! AppDelegate

@available(iOS 13.0, *)
let SCENEDEL =  UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate

let TIMEZONE = TimeZone.current.identifier

var checkIsOnGoing = false
//headers
let kApplicationJson = "application/json"
let kContentType = "Content-Type"
let kAccept = "Accept"
let kAuthorization = "Authorization"

let kError = "Error"
let kEmptyString = ""
let kNotAvailable = "N/A"
let kSomethingWentWrong = "Something went wrong."


let kAccount = "Account Details"
let kGenderArray:[String] = ["Female","Male","Other"]

let kEditAccount = "Edit Account"
let kProfile = "Profile"

let kLocation = "Please enable location."

let kEmptyImageAlert = "Please upload profile image."
let kEmptyFirstNameAlert = "Please enter first name."
let kEmptyLastNameAlert = "Please enter last name."
let kMinNameAlert = "Name must be at least 2 characters long."

let kEmptyEmailAlert = "Please enter email."
let kValidEmailAlert = "Please enter valid email."

let kEmptyPhoneAlert = "Please enter phone number."
let kValidPhoneAlert = "Please enter valid phone number."


let kEmptyDOBAlert = "Please select date of birth."
let kEmptyGenderAlert = "Please select gender."



//Cell
let kIntrollCCell  = "IntrollCCell"
let kSettingTCell  = "SettingTCell"
let kLegalTCell  = "LegalTCell"
let kProfileHeadetTCell  = "ProfileHeadetTCell"




