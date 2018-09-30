library(shiny)
library(shinycssloaders)
library(tm)
library(wordcloud)
library(memoise)
library(htm2txt)

# The list of valid graphs

# graphs <<- list("word cloud" = "wc",
#                 "t-sne" = "tsne")

# text_wikihuman <- gettxt("https://en.wikipedia.org/wiki/Human")
# save(text_wikihuman, file = "~/GoogleDrive/personal_knowledge/data/text_wikihuman.RData")
load(file = "~/GoogleDrive/personal_knowledge/data/text_wikihuman.RData")
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
