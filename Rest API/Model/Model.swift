//
//  Model.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 26/05/22.
//

import Foundation

struct WelcomeElement: Codable {
    let movies: [Movie]
}

struct Movie : Codable {
    let id : Int?
    let url : String?
    let name : String?
    let season : Int?
    let number : Int?
    let type : String?
    let airdate : String?
    let airtime : String?
    let airstamp : String?
    let runtime : Int?
    let rating : Rating?
    let image : Image?
    let summary : String?
    let outerLink : _links?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case url = "url"
        case name = "name"
        case season = "season"
        case number = "number"
        case type = "type"
        case airdate = "airdate"
        case airtime = "airtime"
        case airstamp = "airstamp"
        case runtime = "runtime"
        case rating = "rating"
        case image = "image"
        case summary = "summary"
        case outerLink = "_links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        season = try values.decodeIfPresent(Int.self, forKey: .season)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        airdate = try values.decodeIfPresent(String.self, forKey: .airdate)
        airtime = try values.decodeIfPresent(String.self, forKey: .airtime)
        airstamp = try values.decodeIfPresent(String.self, forKey: .airstamp)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        rating = try values.decodeIfPresent(Rating.self, forKey: .rating)
        image = try values.decodeIfPresent(Image.self, forKey: .image)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        outerLink = try values.decodeIfPresent(_links.self, forKey: .outerLink)
        
    }

}


struct Image : Codable {
    let medium : String?
    let original : String?

    enum CodingKeys: String, CodingKey {

        case medium = "medium"
        case original = "original"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        original = try values.decodeIfPresent(String.self, forKey: .original)
    }

}

struct _links : Codable {
    let link : InternalLink?

    enum CodingKeys: String, CodingKey {

        case link = "self"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        link = try values.decodeIfPresent(InternalLink.self, forKey: .link)
    }

}

struct Rating : Codable {
    let average : Double?

    enum CodingKeys: String, CodingKey {

        case average = "average"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        average = try values.decodeIfPresent(Double.self, forKey: .average)
    }

}

struct InternalLink  : Codable {
    let href : String?

    enum CodingKeys: String, CodingKey {

        case href = "href"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        href = try values.decodeIfPresent(String.self, forKey: .href)
    }

}


