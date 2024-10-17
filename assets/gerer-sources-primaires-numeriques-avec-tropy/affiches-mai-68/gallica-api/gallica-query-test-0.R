##
##
##
library(curl)
##
library(XML)
##
library(stringi)

##
## Décalaration des fonctions utilisées
## 

## 
#' Formattage de l'url
#'
#' @param query requête CQL
#'
#' @return url de la requête GET SRU encodée
##
##
gallicaQueryUrl <- function(query){
  paste(
    "https://gallica.bnf.fr/SRU?operation=searchRetrieve&version=1.2"
    , sprintf(
      "query=%s", URLencode(
        query
        , reserved = T
      )
    )
    , "lang=fr" 
    , "suggest=0" 
    ##
    , sep="&"
  )
}
##
## Nombre total d'enregistrements
##
numberOfRecords <- function(xdoc){
  as.integer(xpathApply(
    xdoc
    , "//srw:numberOfRecords" 
    , xmlValue
    , namespaces = "srw"
  ))
}
##
## Nombre d'enregistrements retournés par la requête
##
nrecords <- function(xdoc){
  as.integer(xpathApply(
    xdoc
    ##
    , "count(//srw:record)" 
    , namespaces = "srw"
  ))
}
## 
#' Envoi de la requête et écupération des résultats
#'
#' @param urlQuery url
#' @param ... paramètres pour cURL
#'
#' @return Liste de `srw:records`
##
##
getGallicaQuery <- function(urlQuery, ..., verbose=1L){
  ##
  h <- new_handle()
  ##
  # handle_setheaders(
  #   h
  #   , .list = list(
  #     "User-Agent" = "Test API Gallica avec R"
  #   )
  # )
  ##
  startRecord <- 1
  ##
  url <- urlQuery
  ##
  rv <- list()
  ##
  repeat{
    ##
    cat("startRecord:", startRecord, fill=T)
    ##
    r <- curl_fetch_memory(
      url
      , h
    )
    ## assertStatusCode
    ##
    ## 500: requête mal formulée ?
    ##
    if( r$status_code!=200L){
      warning(r$status_code)
      break
    }
    ## "application/xml;charset=UTF-8"
    if( ! grepl("application/xml", r$type ) ){
      warning(r$type)
      break
    }
    ##
    rcontent <- rawToChar(r$content)
    ## ¿ try-it ?
    xdoc <- xmlTreeParse(rcontent, useInternalNodes=T)
    ##
    rv <- c(rv, xdoc)
    ## 
    n <- numberOfRecords(xdoc)
    ##
    nrec <- nrecords(xdoc)
    ##
    if( startRecord> n) break
    ##
    n <- n - nrec
    ##
    startRecord <- startRecord + nrec
    ##
    url <- sprintf("%s&startRecord=%d", urlQuery, startRecord)
  }
  ## 
  rv
}
## 
#' Extraction des informations sur les fichiers
#'
#' @param records Liste de `srw:records`
#'
#' @return  Liste de `extraRecordData` extraites
##
##
extraRecordData <- function(records){
  ##
  xRecData <- lapply(
    records 
    , function(xdoc){
      ##
      v <- xpathApply(
        xdoc
        ##
        , "//srw:extraRecordData" ## 
        , namespaces = "srw"
      )
      ##
      lapply(
        v ## WUT:  |> `names<-`(id)
        , function(n){
          xmlApply(n, xmlValue)
        }
      ) 
    }
  )
  ##
  xRecData <- do.call('c', xRecData)
  ##
  names(xRecData1) <- sapply(xRecData, function(v) v$link)
  ##
  xRecData
}
## 
#' Téléchargement des fichiers
#'
#' @param xRecData Liste de `extraRecordData` extraites
#' @param dst Répertoire de destination 
#' @param start Indice du premier fichier à télécharger. Par défaut, 1L
#' @param n Nombre d'images. Par défaut, le nombre d'élément dans xRecData 
#'
#' @return Un vecteur avec le chemin vers le fichier téléchargé ou `NA_character_` en cas d'arreur avec `start` et `n` en attributs
##
getGallicaImages <- function(
    xRecData
    , dst
    , start=1L, n=length(xRecData)
){
  ##
  if( missing(dst) ){
    stop("argument `dst` manquant")
  }
  ##
  if( !dir.exists(dst) ){
    stop("le répertoire de destination `", dst, "` n'existe pas")
  }
  ##
  if( ( ( start <- start-1L ) + n ) > length(xRecData) ){
    stop("indices hors limite")
  }
  ##
  # print((start-1L) + (1:n))
  ##
  structure(
    sapply(
      xRecData[ start + (1:n) ]
      , function(v){ 
        ##
        url <- v$highres
        ##
        cat(url, fill=T)
        ##
        # return(url)
        ##
        r <<- curl_fetch_memory(
          url
          , h
        )
        ## 429
        if( r$status_code!=200L ){
          stop('status', r$status_code, url)
          return(NA_character_)
        }
        ##
        p <- unlist(gregexpr(pattern ='/', url))
        ##
        id <- chartr(
          "/.", "--"
          , substr(url, p[length(p)-1]+1, nchar(url))
        )
        ##  "image/jpeg;charset=UTF-8"
        m <- stringi::stri_match(r$type, regex="(image)/(\\w+)")
        ##
        if( is.na(m[,2]) ){
          warning('type:', r$type, url)
          return(NA_character_)
        }
        ##
        fext <- m[,3]
        ##
        writeBin(
          r$content
          , fp <- file.path(
            dst
            , paste(id, fext, sep=".")
          ) 
        )
        ##
        Sys.sleep(1/2)
        ##
        fp
      }
    )
    , start = start, n= n
  )
}

##
## ***C'est la que ça commence***
##

##
## url de la requête
##
qUrl <- gallicaQueryUrl(
  '(gallica all "France -- 1968 (Journées de mai)") and dc.type all "image"'
)
##
## Envoi de la requête et écupération des résultats
##
records0 <- getGallicaQuery(qUrl)

##
## Nombre réel d'enregistrement
##
sum(sapply(
  records0 
  , nrecords
))

##
## Extraction des informations sur les fichiers
##
xRecData0 <- extraRecordData(records0)

##
## Répertoire de destination
# imgDir <- "/tmp/gallica"

##
## Téléchargement des fichiers
##
## 10 premières
rv0 <- getGallicaImages(
  xRecData0
  , imgDir
  , n = 10L
)
## 10 suivantes
rv1 <- getGallicaImages(
  xRecData0
  , imgDir
  , start= attr(rv0, "start") + 11L
  , n = 10L
)
##
rv1[is.na(rv1)]

