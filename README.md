# <img src="https://i.imgur.com/lLufdBo.png" align="right" width="150" height="150" />  Barcelona Summer School of Demography 2021 week 3 Dataviz – the Art/Skill Cocktail

In the ever-growing universe of dry academic texts, impressive and efficient graphics are quite rare. Driven by widespread software legacy issues and mostly outdated limitations imposed by traditional scientific publishers, researchers often consider producing high quality graphics as a peripheral optional task – “if time allows” (spoiler: it won’t). Yet, modern tools place data visualization in the focus of research workflows when it comes to conveying the results. Hence, the ability to turn a large dataset into an insightful visualization is an increasingly valuable skill in academia.

The course aims to empower the participants with the flexibility that the R+tidyverse framework gives to visualize data (the practical examples mostly use demographic data). The course covers some aspects of data visualization theory and best/worst practice examples, but it's primarily practice oriented including live coding sessions and short lecture/showcase parts.

Practical coding sessions start from basic introduction to tidy data manipulation and ggplot2 basics. Next, practical examples cover the creation of certain most useful types of plots. Important data visualization choices and caveats are discussed along the way. Special attention is devoted to producing geographical maps, which are no longer the luxury of professional cartographers but have turned, with the help of R, into yet another data visualization type. Going beyond ggplot2, the course presents an introduction to interactive data visualization.

# Course Twitter account: [@DatavizArtSkill](https://twitter.com/DatavizArtSkill)

# [CED BSSD course announcement][link]

[link]: https://ced.uab.cat/en/courses/barcelona-summer-school-of-demography/


# Prerequisites
- [R](https://cloud.r-project.org)  
- [Rstudio](https://www.rstudio.com/products/rstudio/download/#download)  
- [Git](https://git-scm.com/downloads) ([help page](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN))
- [R {packages}](/day1/install-pkg.R)
- Basic familiarity with R, consider [RStudio Primers](https://rstudio.cloud/learn/primers)


# Alternative [GDrive folder with materials](https://bit.ly/bssd21-gdrive)


# Outline

### Day 1, Monday, July 12: BASICS
- Basic dataviz principles ([slides][slides-gg])
- Impressive dataviz showcases
- Tidy approach to data

### Day 2, Tuesday, July 13: TUNE-UP
- {ggplot2} basics
- Colors in dataviz
- Themes and fonts

### Day 3, Wednesday, July 14: TOOLBOX
- Useful types of plots
- Dotplots – the most neglected and powerful type of dataviz
- Heatmaps, equality-line, ggridges, treemap

### Day 4, Thursday, July 15: MAPS
- The basics of map projections ([slides][slides-map] *to be shared after the lecture*)
- {sf} – the game changer in #rspatial, `geom_sf`
- Useful spatial processing tricks

### Day 5, Friday, July 16: ROCK
- Creative legends: {biscale}, {tricolore}
- Interactivity: {plotly}, {gganimate}
- Intro to {shiny}

[slides-gg]: https://ikashnitsky.github.io/dataviz-bssd/slides/slides-dataviz-bssd.html
[slides-map]: https://

# Links to submit in-class assignments
- Ugly `ggplot2` theme -- https://bit.ly/bssd21-ugly (day 2)


# Various cool stuff I promissed to share (in order of taking notes)

- John Burn-Murdoch's [RStudio 2021 talk](https://youtu.be/L5_4kuoiiKU)
- Nathaniel Smith's [talk on the proinicples of viridis palettes](https://youtu.be/xAoljeRJ3lU)
- Hans Rosling: [sample talk](https://youtu.be/BZoKfap4g4w); [Factfulness](https://www.amazon.com/Factfulness-Reasons-World-Things-Better/dp/1250107814); [gapminder.org](https://www.gapminder.org/tools/#$chart-type=bubbles&url=v1)
- [Thread on excess death plots](https://twitter.com/ikashnitsky/status/1409472083965349892) 
- [Post on efficient RStudio layout](https://ikashnitsky.github.io/2018/perfect-rstudio-layout/)
- Jonas Schoeley's [HMD explorer app](https://jschoeley.shinyapps.io/hmdexp/)
- Hadley Wickham's [R For Data Science](https://r4ds.had.co.nz)
- Neal Grantham's [TidyTuesday Rocks app](https://nsgrantham.shinyapps.io/tidytuesdayrocks/)
- **BONUS** Oscar Baruffa's [Big Book of R](https://www.bigbookofr.com)
- [Replication materials](https://github.com/ikashnitsky/sex-gap-e0-pnas) for our recent PNAS paper
- [Thread](https://twitter.com/ikashnitsky/status/1380247006170509312) on log transformation of the ratios
