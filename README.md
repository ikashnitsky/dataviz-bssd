# <img src="https://i.imgur.com/g258HfB.png" align="right" width="333" height="333" />  Barcelona Summer School of Demography 2025 week 3 Dataviz – the Art/Skill Cocktail

In the ever-growing universe of dry academic texts, impressive and efficient graphics are quite rare. Driven by widespread software legacy issues and mostly outdated limitations imposed by traditional scientific publishers, researchers often consider producing high quality graphics as a peripheral optional task – “if time allows” (spoiler: it won’t). Yet, modern tools place data visualization in the focus of research workflows when it comes to conveying the results. Hence, the ability to turn a large dataset into an insightful visualization is an increasingly valuable skill in academia.

The course aims to empower the participants with the flexibility that the R+tidyverse framework gives to visualize data (the practical examples mostly use demographic data). The course covers some aspects of data visualization theory and best/worst practice examples, but it's primarily practice oriented including live coding sessions and short lecture/showcase parts.

Practical coding sessions start from basic introduction to tidy data manipulation and ggplot2 basics. Next, practical examples cover the creation of certain most useful types of plots. Important data visualization choices and caveats are discussed along the way. Special attention is devoted to producing geographical maps, which are no longer the luxury of professional cartographers but have turned, with the help of R, into yet another data visualization type. Going beyond ggplot2, the course presents an introduction to interactive data visualization.

### Course BlueSky account: [@datavizartskill.ikashnitsky.phd](https://bsky.app/profile/datavizartskill.ikashnitsky.phd)

# [CED BSSD course announcement][link]

[link]: https://ced.cat/en/bcn4seasons/bssd-module-3-data-visualization-with-r/


# Prerequisites
- [R](https://cloud.r-project.org)  
- [Rstudio](https://www.rstudio.com/products/rstudio/download/#download)  
- [Git](https://git-scm.com/downloads) ([help page](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN))
- [R {packages}](/day1/install-pkg.R)
- Basic familiarity with R, consider [RStudio Primers](https://rstudio.cloud/learn/primers)


# Outline

### Day 1, Monday, July 14: BASICS
- Basic dataviz principles ([slides][slides-gg])
- Impressive dataviz showcases
- `tidtverse`: Tidy approach to data

### Day 2, Tuesday, July 15: TUNE-UP
- `ggplot2` basics
- Colors in dataviz
- Themes and fonts

### Day 3, Wednesday, July 16: TOOLBOX
- Useful types of plots
- Dotplot – the most neglected and powerful type of dataviz
- Heatmap, equality-line, ggridges, treemap
- Interactivity: `plotly`, `gganimate`

### Day 4, Thursday, July 17: MAPS
- The basics of map projections ([slides][slides-maps])
- With `geom_sf` maps become yet another type of dataviz
- Useful spatial processing tricks with `rmapshaper`
- `biscale` maps

### Day 5, Friday, July 18: ROCK
- dataviz challenge in teams
- brief presentations by teams and discussion
- course wrap-up

[slides-gg]: https://ikashnitsky.github.io/dataviz-bssd/slides/slides-dataviz-bssd.html
[slides-maps]: https://ikashnitsky.github.io/dataviz-bssd/slides/slides-maps-bssd.html



# Useful links

- Oscar Baruffa's [Big Book of R](https://www.bigbookofr.com)
- Hadley Wickham's [R For Data Science](https://r4ds.had.co.nz)
- Neal Grantham's [TidyTuesday Rocks app](https://nsgrantham.shinyapps.io/tidytuesdayrocks/)
- Andy Kirk's [The little of visualisation design](https://visualisingdata.com/the-little-of-visualisation-design/) 
- Jonas Schoeley's [2017 IDEM dataviz course](https://github.com/jschoeley/idem_viz)
- Garrick Aden-Buie's [Gentle Guide to the Grammar of Graphics](https://pkg.garrickadenbuie.com/gentle-ggplot2)   
- [R Graph Gallery](https://r-graph-gallery.com/)
- Yan Holtz's [tool for selecting color palletes](https://python-graph-gallery.com/color-palette-finder/)
- Hans Rosling: [sample talk](https://youtu.be/BZoKfap4g4w); [Factfulness](https://www.amazon.com/Factfulness-Reasons-World-Things-Better/dp/1250107814); [gapminder.org](https://www.gapminder.org/tools/#$chart-type=bubbles&url=v1)
- Nathaniel Smith's [talk on the principles of viridis palettes](https://youtu.be/xAoljeRJ3lU)
- David Robinson's [RStudio Conference 2019 talk](https://posit.co/resources/videos/the-unreasonable-effectiveness-of-public-work/) on the immense benefits of being open and sharing stuff freely 
- John Burn-Murdoch's [RStudio 2021 talk](https://youtu.be/L5_4kuoiiKU)
- [Thread on excess deaths plots](https://twitter.com/ikashnitsky/status/1409472083965349892) 
- [Thread](https://twitter.com/ikashnitsky/status/1380247006170509312) on log transformation of the ratios
- [Post on efficient RStudio layout](https://ikashnitsky.github.io/2018/perfect-rstudio-layout/)
- [Replication materials](https://github.com/ikashnitsky/sex-gap-e0-pnas) for Zarulli etal 2021 PNAS paper
- Boxplot + jitter example: [tweet](https://twitter.com/ikashnitsky/status/1403645553637011461)  
- Jonas Schoeley's [HMD explorer app](https://jschoeley.shinyapps.io/hmdexp/)
- US names shiny app: [repository](https://github.com/ikashnitsky/us-names-app); [tweet](https://twitter.com/ikashnitsky/status/1203840297911889920); [shiny app](https://ikashnitsky.shinyapps.io/us-names/)  
- Jim Vaupel's [brilliant talk](https://twitter.com/ikashnitsky/status/1512700871968186379) on the unique central positioning of demography in science  
- Years of life stolen by gun shooting in the US -- [dataviz by Periscopic](https://guns.periscopic.com) 
- NYT Giorgia Lupi's [Long COVID data storytelling](https://www.nytimes.com/interactive/2023/12/14/opinion/my-life-with-long-covid.html?unlocked_article_code=1.F00.435C.ojkN6YhWx43Q) 
- NYT (Motoko Rich, Amanda Cox, Matthew Bloch) [US districts school kids performance against parent's wealthiness](https://www.nytimes.com/interactive/2016/04/29/upshot/money-race-and-success-how-your-school-district-compares.html)