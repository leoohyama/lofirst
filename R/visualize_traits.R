#' @importFrom rlang .data

visualize_traits<-function(data, trait1, trait2, taxacol){
  if(is.na(trait1)){
    print("Need an input for at least one trait!")
  }else{
    if(is.na(trait2)){
      if(trait1 %in% colnames(data) &
         taxacol %in% colnames(data)){
        #passed test plot single trait by species
        ggplot2::ggplot(data = data) +
          ggplot2::geom_boxplot(ggplot2::aes(x = .data[[taxacol]],
                                             y = .data[[trait1]]))
      }else{
        print("trait1 or taxa does not match the column names of the data")
      }
    }else{
      #check  both trait 1 and trait 2 for valid names
      if(trait1 %in% colnames(data) &
         trait2 %in% colnames(data) &
         taxacol %in% colnames(data)){
        #passed test plot two traits by species

        ggplot2::ggplot(data = data) +
          ggplot2::geom_point(ggplot2::aes(x = .data[[trait1]],
                                             y = .data[[trait2]],
                                           color = .data[[taxacol]])
                                )

      }else{
        print("trait1 or trait 2 or taxa does not match the column names of the data")
      }
    }
  }
}



