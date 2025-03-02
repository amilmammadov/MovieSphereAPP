//
//  Constants.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

enum ConstantStrings {
    static let homePageTitle = "home_page_title"
    static let searchPlaceHolder = "search_placeholder"
    static let emptySpaceViewTitle = "empty_space_view_title"
    static let emptySpaceViewSubTitle = "empty_space_view_subtitle"
    static let reviews = "reviews"
    static let aboutMovie = "about_movie"
    static let cast = "cast"
    static let emptyFavoriteViewTitle = "empty_favorite_view_title"
    static let emptyFavoriteViewSubTitle = "empty_favorite_view_subtitle"
    static let searchInformation = "search_information"
    static let homeTitle = "home_title"
    static let searchTitle = "search_title"
    static let watchListTitle = "watchlist_title"
    static let profileTitle = "profile_title"
    static let logout = "logout"
    static let minutes = "minutes"
    static let detail = "detail"
    static let close = "close"
    
    //MARK - These strings below won't be localized
    
    static let selectedLanguage = "SelectedLanguage"
    static let loginPageText = "Login and start exploring your next favorite movie!"
    static let continueWithGoogle = "Continue with Google"
    static let continueWithApple = "Continue with Apple"
    static let continueWithFacebook = "Continue with Facebook"
}

enum Colors {
    static let backGround = UIColor(named: "BackGround")
    static let searchTextFieldBackGround = UIColor(named: "SearchTextFieldBackGround")
    static let seacrhIcon = UIColor(named: "SearchIcon")
    static let starColor = UIColor(named: "StarColor")
    static let voteAverageBackground = UIColor(named: "VoteAverageBackground")
    static let reviewerRating = UIColor(named: "ReviewerRating")
    static let facebookLoginBackground = UIColor(named: "FacebookLogin")
}

enum SFSymbols{
    static let searchTextFieldIcon = UIImage(named: "Magnifyingglass")
    static let informationButton = UIImage(named: "Information")
    static let star = UIImage(named: "Star")
    static let calendar = UIImage(named: "Calendar")
    static let ticket = UIImage(named: "Ticket")
    static let emptySearchView = UIImage(named: "EmptySearchView")
    static let markImage = UIImage(named: "MarkImage")
    static let clock = UIImage(named: "Clock")
    static let defaultProfile = UIImage(named: "DefaultProfile")
    static let unselectedMark = UIImage(systemName: "bookmark")
    static let selectedMark = UIImage(systemName: "bookmark.fill")
    static let trash = UIImage(systemName: "trash")
    static let emptyFavoriteView = UIImage(named: "EmptyFavoriteView")
    static let popcorn = UIImage(named: "Popcorn")
    static let googleLogo = UIImage(named: "GoogleLogo")
    static let appleLogo = UIImage(named: "AppleLogo")
    static let facebookLogo = UIImage(named: "FacebookLogo")
    static let logout = UIImage(systemName: "iphone.and.arrow.right.outward")
}

enum Category:String, CaseIterable {
    case nowPlaying = "now_playing"
    case upComing = "upcoming"
    case topRated = "top_rated"
    case popular = "popular"
}

enum Language: String {
    case eng = "en"
    case rus = "ru"
    case key = "language"
}
