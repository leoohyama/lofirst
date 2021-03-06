#new function idea, making a numeric into categorical factors! Binning data

num_to_cat<-function(data , num, cat_name, cat_no, labels){
  if(is.na(labels)){

    if (!requireNamespace("dplyr", quietly = TRUE)) {
      utils::install.packages("dplyr")
    }

    #if labels are NA use generic labels

    #range of numbers divided by specified number of categories
    interval<-(max(data[[num]], na.rm = T)-min(data[[num]], na.rm = T))/cat_no

    #make a list of generic labels for length of category number
    label_cat<-LETTERS[seq( from = 1, to = cat_no)]

    #empty vector to fill in for intervals
    interval_slots<-vector()

    for (i in 1:length(label_cat)){
      interval_slots[i]<-interval*i
    }

    combinations<-cbind(interval_slots, label_cat)

    #new column for categories
    data<- dplyr::mutate(data, cat_name = NA)

    #Just a for loop at this point?
    for(i in 1:nrow(combinations)){

      if(i == 1){
      #if the first level
        data$cat_name[data[[num]] < combinations[i,1]]<-combinations[i,2]
      }
      else if(i == utils::tail(1:nrow(combinations), n =1)){
        #if last number
        data$cat_name[data[[num]] > combinations[i-1,1]]<-combinations[i,2]


      }
      else{
        #inbetween values
        data$cat_name[data[[num]] > combinations[i-1,1] &
                        data[[num]] < combinations[i+1,1]]<-combinations[i,2]

      }

    }
    return(data)

  }else if(length(labels) == cat_no){

    #if labels are specified

    #range of numbers divided by specified number of categories
    interval<-(max(data[[num]], na.rm = T)-min(data[[num]], na.rm = T))/cat_no

    #make a list of generic labels for length of category number
    label_cat<-labels

    #empty vector to fill in for intervals
    interval_slots<-vector()

    for (i in 1:length(label_cat)){
      interval_slots[i]<-interval*i
    }

    combinations<-cbind(interval_slots, label_cat)

    #new column for categories
    data<- dplyr::mutate(data, cat_name = NA)

    #Just a for loop at this point?
    for(i in 1:nrow(combinations)){

      if(i == 1){
        #if the first level
        data$cat_name[data[[num]] < combinations[i,1]]<-combinations[i,2]
      }
      else if(i == utils::tail(1:nrow(combinations), n =1)){
        #if last number
        data$cat_name[data[[num]] > combinations[i-1,1]]<-combinations[i,2]


      }
      else{
        #inbetween values
        data$cat_name[data[[num]] > combinations[i-1,1] &
                        data[[num]] < combinations[i+1,1]]<-combinations[i,2]
      }
    }
    return(data)

  }else{
    print("Number of categories and number of labels are not the same!")
  }
}

