# personal_knowledge
This repo contains the shiny app developed for volhacks2018 MyTime project.

To run it ofrom your computer:
1. Download this repo
2. Open R 
3. Install some needed packages by typing:
```
install.packages(c("devtools", "shiny", "shinycssloaders", "tm", "wordcloud", "memoise", "htm2txt", "RColorBrewer", "ggplot2")
```
4. Now run the shiny app with:
```
library(shiny)
runApp(appDir = "replace_by_your_dir/personal_knowledge/"
```
