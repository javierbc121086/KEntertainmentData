//
//  RPEHttpRequestType.swift
//  RPEntertainmentDomain
//
//  Created by Javier Bolaños on 9/16/19.
//  Copyright © 2019 gipsyhub. All rights reserved.
//


/**
 Enumeracion encargada de proveer valores por tipo de peticiones a webservice.
 
 ## Nota ##
 Se puede presindir de esta enumeracion al usar un cero en el tipo de flujo,
 aunque no se recomienda usar directamente los tipo entero
 */
public enum RPEHttpRequestType: Int {
    case MOVIE_POPULAR  = 0
    case MOVIE_RATE     = 1
    case MOVIE_UPCOMING = 2
    case TV_POPULARITY  = 3
    case TV_RATE        = 4
    case TV_UPCOMING    = 5
    case NONE           = 666
}
