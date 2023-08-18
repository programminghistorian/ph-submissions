#######################################################
# The Programming Historian en español
#Lección: Uso_de_colecciones_de_HathiTrust_en_R
#Autor: José Eduardo González
#######################################################
#install.packages(plyr)
#este código va a usar plyr pero no va a cargar el paquete por conflicto con dplyr
obtener_tokens <- function (list_htids) {
  counter=0
  tokens_list<-list()
  not_found<-list()
  for(i in 1:length(list_htids)){
    dos<-check_htid(list_htids[i])
    if (length(dos)>1){
      tokens_list[[i]]<-dos
    }else{
      not_found=dos
      counter=counter+1
    }
  }
  #plyr es necesario porque algunos tienen más columnas que otros así que no puedo user el base rbind o el de dplyr
  tokens_list<-plyr::rbind.fill(tokens_list)
  print(paste("Número de archivos que no se pudieron descargar: ",counter))
  output<-list(tokens_list,not_found)
  return(output)
}


check_htid = function(x){
  tryCatch(get_hathi_counts(x), error = function(e) {return(x)}) 
}