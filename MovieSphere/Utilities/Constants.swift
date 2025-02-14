//
//  Constants.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

enum ConstantStrings {
    static let homePageTitle = "What do you want to watch?"
    static let searchPlaceHolder = "Search"
    static let emptySearchViewTitle = "We are sorry, we can not find the movie :("
    static let emptySearchViewSubTitle = "Find your movie by Type title, categories, years, etc "
    static let selectedLanguage = "SelectedLanguage"
    static let reviews = "Reviews"
    static let aboutMovie = "About Movie"
    static let cast = "Cast"
    static let emptyFavoriteViewTitle = "There is no movie yet!"
    static let emptyFavoriteViewSubTitle = "Find your movie by Type title, categories, years, etc "
    static let loginPageText = "Log in and start exploring your next favorite movie!"
    static let signInWithGoogle = "Sign In with Google"
    static let signInWithApple = "Sign In with Apple"
}

enum Colors {
    static let backGround = UIColor(named: "BackGround")
    static let searchTextFieldBackGround = UIColor(named: "SearchTextFieldBackGround")
    static let seacrhIcon = UIColor(named: "SearchIcon")
    static let starColor = UIColor(named: "StarColor")
    static let voteAverageBackground = UIColor(named: "VoteAverageBackground")
    static let reviewerRating = UIColor(named: "ReviewerRating")
    
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
}

enum Category:String, CaseIterable {
    case nowPlaying = "Now Playing"
    case upComing = "Upcoming"
    case topRated = "Top Rated"
    case popular = "Popular"
}
