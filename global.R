library(shiny)
library(shinycssloaders)
library(tm)
library(wordcloud)
library(memoise)
library(htm2txt)
library(RColorBrewer)
library(ggplot2)
# library(tidyverse)  # not really needed
pal <- colorRampPalette(brewer.pal(8, "Accent"))
words <- readLines("data/moon_real_matrix_data.txt")  # has too many words and gibberish words
words_test <- readLines("data/test3_matrix_data.txt")
words <- words[c(1, sort(sample(2:length(words), size = 30, replace = FALSE)))]  # get only 30 datasets
words <- sapply(words, strsplit, ",")
words <- lapply(words, "[", sample(1:length(words[[1]]), size =100))  #sample 100 words


# fake <- lapply(sample(1:100, 30, replace = FALSE), function(x) {
#   rnorm(mean = x, n = length(words[[1]]))
#   })
# words <- c(words_test, fake)

maxX <- max(unlist(sapply(words[-1], function(x) max(as.numeric(x)))))

cols <- pal(length(words[[1]]))

for (i in 2:31){ #length(words)
  # Create dataset
  data=data.frame(
    id=seq(1,length(words[[1]])),
    individual= words[[1]],
    value= (as.numeric(words[[i]]) * 100)/maxX
  )
  # data=data.frame(
  #   id= 1:length(words[[1]]),
  #   individual= words[[1]],
  #   value= (as.numeric(words[[i]]) * 100)/maxX
  # )
  # ----- This section prepare a dataframe for labels ---- #
  # Get the name and the y position of each label
  label_data=data

  # calculate the ANGLE of the labels
  number_of_bar=nrow(label_data)
  angle= 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)

  # calculate the alignment of labels: right or left
  # If I am on the left part of the plot, my labels have currently an angle < -90
  label_data$hjust<-ifelse( angle < -90, 1, 0)

  # flip angle BY to make them readable
  label_data$angle<-ifelse(angle < -90, angle+180, angle)

  png(filename = paste0("www/freq_", 32-i, ".png"), width = 500, height = 500)  #length(words)+2

  # ----- ------------------------------------------- ---- #
  # Make the plot
  p = ggplot(data, aes(x=as.factor(id), y=value)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar

    # This add the bars with a blue color
    geom_bar(stat="identity", fill=alpha(cols, 0.3)) +

    # Limits of the plot = very important. The negative value controls the size of the inner circle, the positive one is useful to add size over each bar
    ylim(-100,200) +

    # Custom the theme: no axis title and no cartesian grid
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-2,4), "cm")     # This remove unnecessary margin around plot
    ) +

    # This makes the coordinate polar instead of cartesian.
    coord_polar(start = 0) +
    # Add the labels, using the label_data dataframe that we have created before
    geom_text(data=label_data, aes(x=id, y=150, label=individual, hjust=hjust), color="black", fontface="bold",alpha=0.6, size=3, angle= label_data$angle, inherit.aes = FALSE )
  print(p)
  dev.off()
}


# wordcloud_rep <- repeatable(wordcloud)

# output$plot <- renderPlot({
#   v <- terms()
#   wordcloud_rep(names(v), v, scale=c(4,0.5),
#                 min.freq = input$freq, max.words=input$max,
#                 colors=brewer.pal(8, "Dark2"))
# })


# original version with test and fake data:
# words <- readLines("data/test3_matrix_data.txt")
# words <- sapply(words, strsplit, ",")
# fake <- lapply(1:30, function(x) sample(0:10, size = length(words[[1]]), replace = TRUE))
# words <- c(words, fake)
# words <- lapply(words, "[", sample(1:197, size =20))  # sample 20 words
# maxX <- max(unlist(sapply(words[-1], function(x) max(as.numeric(x)))))
# cols <- pal(length(words[[1]]))
# for (i in 2:31){ #length(words)
#   png(filename = paste0("www/freq_", 32-i, ".png"), width = 800, height = 500)  #length(words)+2
#   par(mai = c(0,1.5,0.5,0.1))
#   barplot(height = as.numeric(words[[i]]), names.arg = words[[1]],
#            cex.names = 1, horiz = T, xaxt = "n", las = 2, xlim = c(0, maxX), col = cols)
#   text(x = par("usr")[2]/2, y = par("usr")[4], labels = paste0(32-i, " minutes ago"), cex = 2, xpd = NA)
#   # box("plot", col = "red")
#   # box("figure", col = "blue")
#   # box("inner", col = "purple")
#   # box("outer", col = "orange")
#   dev.off()
# }



# The list of valid graphs
# graphs <<- list("word cloud" = "wc",
#                 "t-sne" = "tsne")

# text_wikihuman <- gettxt("https://en.wikipedia.org/wiki/Human")
# save(text_wikihuman, file = "~/GoogleDrive/personal_knowledge/data/text_wikihuman.RData")
# load(file = "~/GoogleDrive/personal_knowledge/data/text_wikihuman.RData")
# books <<- list("A Mid Summer Night's Dream" = "summer",
#               "The Merchant of Venice" = "merchant",
#               "Romeo and Juliet" = "romeo")
#
# Using "memoise" to automatically cache the results
# getTermMatrix <- memoise(function(text) {
#   # Careful not to let just any name slip in here; a
#   # malicious user could manipulate this value.
#   # if text comes from a txt file:
#   # text <- readLines(sprintf("./%s.txt.gz", book),
#   #   encoding="UTF-8")
#
#   myCorpus = Corpus(VectorSource(text))
#   myCorpus = tm_map(myCorpus, content_transformer(tolower))
#   myCorpus = tm_map(myCorpus, removePunctuation)
#   myCorpus = tm_map(myCorpus, removeNumbers)
#   myCorpus = tm_map(myCorpus, removeWords,
#          c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
#
#   myDTM = TermDocumentMatrix(myCorpus,
#               control = list(minWordLength = 1))
#
#   m = as.matrix(myDTM)
#
#   sort(rowSums(m), decreasing = TRUE)
# })
