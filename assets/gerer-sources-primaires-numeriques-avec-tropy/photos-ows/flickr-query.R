#-----------------------------------------------------------
# Script Name: Requête API flikr
# Purpose: Script montrant comment rechercher et télécharger des photos en utilisant l'API flikr
# Author: Thomas Soubiran
# Date: 2024-10-10
# Version: 0.1
#-----------------------------------------------------------
#
library(curl)
#
library(jsonlite)
#
# @brief Retourne le code de la licence
#
# @licence licence
#
licenseToNum <- function(
    licence
){
  if(!is.character(licence)){
    stop(dQuote("licence"), " n'est pas un vecteur de type caractère")      
  }
  paste(
    sapply(
      licence
      , function(v){
        switch(
          v
          #
          , "c" = 0
          , "by-bc-sa" = 1
          , "by-nc" = 2
          , "by-nc-nd" = 3
          , "by" = 4
          , "by-sa" = 5
          , "by-nd" = 6
          , "nkc" = 7
          , "pd-us" = 8
          , "cc0" = 9
          , "pd" = 10
          #
          , stop("Nom de licence non répertorié: ", dQuote(v))
        )
        
      }
    )
    , collapse = ","
  )
}
#
# @brief assemble et soumet une requête à l'API flikr
# 
# @method  méthode
# @api_key la clef d'API flikr
# @...     paramètres de la requête
# @format  format des données. Seul json est pris en charge
# @h       cur_handle
# @verbose volubilité
#
apiQuery.flikr <- function(
    method
    , api_key
    , ...
    , format = "json"
    , h = curl::new_handle()
    , verbose = 0
){
  #
  if( format != "json" ) stop("Seul le format format json est pris en charge")
  #
  p <- list(...)
  #
  # assert names
  if( length(p) && is.null(names(p)) ) stop( "names in ...")
  # assert char && len==1
  #
  p <- c(p, format = format )
  #
  qUrl <-  sprintf(
    "https://www.flickr.com/services/rest/?method=%s&api_key=%s%s"
    , method
    , api_key
    , if( length(p) ) paste0(
      "&"
      , paste(
        paste(
          names(p)
          , sapply( p, URLencode, reserved=T )
          , sep = "="
        )
        , collapse ="&"
      )
    ) else ""
  )
  #
  if( verbose ){
    message("Query URL:", qUrl, fill=T)
  }
  #
  curl::curl_fetch_memory(
    qUrl
    , h
  )
}
#
# @brief Conversion json ⇒ R
#
# @r résultat de la requête http
#
getJsonContent.flikr <- function(r){
  #
  # assert: r$type r$content (curl returns a generic list)
  # assert: startsWith(r$type, "text/javascript")
  #
  rcontent <- rawToChar(r$content)
  #
  if( !startsWith(rcontent, "jsonFlickrApi") ) return( jsonlite::fromJSON(rcontent) )
  #
  jsonlite::fromJSON(
    substr(
      rcontent
      , nchar("jsonFlickrApi(")+1
      , nchar(rcontent)-1
    )
  )
}
#
# @brief Recherche de photos sur flikr
#
# @api_key  clef de l'API flikr
# @...      paramètres (tags) de la requête
# @page     no de la 1ière page
# @maxPages nombre maximal de page 
# @verbose  volubilité
#
#
photosSearch.flikr <- function(
    api_key
  , ...
  , page = 1
  , maxPages
  , verbose = 1
){
  # assert ... %!in% "api_key", "page", "format"
  # 
  r <-  tryCatch(
    { 
      r <- apiQuery.flikr(
          api_key = api_key
        , method  = "flickr.photos.search"
        , ...
        , page    = as.character(page)
        , format  = "json"
        , h = h <- curl::new_handle()
        , verbose = verbose
      )
      #
      rcontent <- getJsonContent.flikr(r)
    }
    , error = function(e) e
  )
  #
  if( inherits(r, "error") ){
    warning( conditionMessage(r) )
    return( list() )
  }
  # "stat": "fail"
  if( rcontent$stat!="ok" ){
    warning(rcontent$message)
    return( list(rcontent) )
  }
  #
  rv <- list(rcontent)
  #
  page   <- as.integer(rcontent$photos$page) + 1
  npages <- as.integer(rcontent$photos$pages)
  #
  if(verbose){
    message("npages:", npages)
  }
  #
  npages <- if( !missing(maxPages) ) maxPages else npages
  #
  while( page<=npages){
    #
    if(verbose) message("page:", page, "/", npages)
    # 
    r <-  tryCatch(
      { 
        r <- apiQuery.flikr(
          api_key = api_key
          , method  = "flickr.photos.search"
          , ...
          , page    = as.character(page)
          , format  = "json"
          , h = h
          , verbose = verbose
        )
        #
        rcontent <- getJsonContent.flikr(r)
      }
      , error = function(e) e
    )
    #
    if( inherits(r, "error") ){
      warning( conditionMessage(r) )
      return( rv )
    }
    #
    rv <- c(rv, list(rcontent))
    #
    if( rcontent$stat!="ok" ){
      warning(rcontent$message)
      return(rv)
    }
    #
    page   <- as.integer(rcontent$photos$page) + 1
    npages <- as.integer(rcontent$photos$pages)
  }
  #
  rv
}
#
# @brief Transforme le résultat d'une requête en data.frame
#
# @x data.frame
#
as.data.frame.fikrPhotoSearchResult <- function(x){
  do.call(
    rbind
    , lapply(x, function(x) x$photos$photo)
  )
}
#
# @brief Télécharge les photos dans un répertoire
#
# @x       data.frame
# @path    chemin vers le répertoire de destination
# @start   position de la 1ière photo à télécharger. Defaut: 1
# @n       nombre de photos. Defaut: le nombre total de photos
# @force   télécharge le fichier même s'il existe déjà
# @verbose Volubilité
#
downloadPhotos.fikrPhotoSearchResult <- function(
    x, dpath
    , start=1L, n=nrow(x)
    , force = F, verbose=1
){
  #
  if( missing(dpath)) stop("dpath manquant")
  if( !dir.exists(dpath)) stop("Le répertoire ", dpath, " n'existe pas")
  #
  if( ( ( start  <- start-1L ) + n ) > nrow(x) ){
    stop("Plage hors limite: ", start+1, "..", start+n)
  }
  if( verbose ) message("plage: ", start+1, "..", start+n )
  #
  sapply(
    x$url_c[ start + (1:n) ]
    , function(u){
      fnm <- strsplit(u, "/")[[1]]
      fnm <- fnm[length(fnm)]
      if(verbose) message("fichier: ", fnm)
      #
      fp <- file.path(dpath, fnm)
      #
      if( !file.exists(fp) | force ){
        download.file(
          u
          , fp
        )
        T |> `names<-`(fp)
      }else F |> `names<-`(fp)
      #
      
    }
    , USE.NAMES = F
  )
}
#
#
#
flikrAPIkey <- "your-flikr-api-key-here"
#
# Requête 
#
owsQ0 <- photosSearch.flikr(
  api_key = flikrAPIkey
  , tags="occupy+wall+street"
  , license="7,9,10" # 
  , extras="url_c"
)
# Conversion en data.frame
ows0 <- as.data.frame.fikrPhotoSearchResult(owsQ0)
# Téléchargement des photos
fp <- downloadPhotos.fikrPhotoSearchResult(
  ows0
  , "/chemin/vers/le/répertoire/des/photos"
)
