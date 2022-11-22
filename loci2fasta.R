iPyrad.alleles.loci2fasta <- function(alleles.loci, output.dir){
  
  x <- readLines(alleles.loci)
  setwd("~/Documents/Master/M2/Génomique/Exo 5/Bons fichiers")
  breaks <- grep("//",x)
  z <- 1
  for(i in 1:length(breaks)){
    fas <- x[z:(breaks[i]-1)]
    fas <-sapply(fas,strsplit," ")
    fas2 <- NULL
    for(j in 1:length(fas)){
      y <- paste(">",i-1,fas[[j]][1],sep="")
      y <- c(y, fas[[j]][length(fas[[j]])])
      fas2 <- c(fas2,y)
    }
    nam <- strsplit(x[breaks[i]],"|")[[1]]
    nam <- nam[grep("|",nam, fixed=T)[1]:grep("|",nam, fixed=T)[2]]
    nam <- gsub("|","",nam, fixed=T)
    nam <- paste(nam, collapse="")
    write(paste(fas2, sep="\n"), paste("locus_",nam,".fasta",sep=""))
    z <- 1+breaks[i]
    print(paste("locus_",nam,".fasta",sep=""))
  }
  
}

iPyrad.alleles.loci2fasta(alleles.loci = "pedicularis.loci", output.dir = "~/Documents/Master/M2/Génomique/Exo 5/Bons fichiers")
