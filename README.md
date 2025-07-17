<!-- badges: start -->
<!-- https://shields.io/badges -->
<!-- https://simpleicons.org -->
[![R-version](https://img.shields.io/badge/4.5.1-0678b9?label=version&logo=R)][cran] 
[![bsky](https://img.shields.io/badge/@ikashnitsky.phd-0285FF?label=bsky&logo=bluesky)][bsky]
[![doi](https://img.shields.io/badge/10.5281/zenodo.16014438-269292?logo=DOI)][doi]
[![orcid](https://img.shields.io/badge/0000.0003.1835.8687-004444?logo=ORCID)][orcid]

[cran]: https://cran.r-project.org
[bsky]: https://bsky.app/profile/ikashnitsky.phd
[doi]: https://doi.org/10.5281/zenodo.16014438
[orcid]: https://orcid.org/0000-0003-1835-8687
<!-- badges: end -->


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

# Links to submit in-class assignments
- Ugly `ggplot2` theme -- https://wr.do/s/bssd25-ugly (day 3)
- Any plot with own data -- https://wr.do/s/bssd25-own (day 3)
- Geocoding -- https://wr.do/s/bssd25-geocoding (day 4, in class)
- Maps -- https://wr.do/s/bssd25-maps (day 4)



***

# USEFUL LINKS

## Learn 
- Hadley Wickham's [R For Data Science, 2nd edition](https://r4ds.hadley.nz) 
ggplot2 
- Jonas Schoeley's [2025 PHDS dataviz course](https://github.com/jschoeley/phds25-datavizdesign) + [2017 IDEM edition](https://github.com/jschoeley/idem_viz)
- Andrew Heiss's [Data Visualization](https://datavizf24.classes.andrewheiss.com)
- Winston Chang's [R Graphics Cookbook, 2nd edition](https://r-graphics.org/index.html)
- Garrick Aden-Buie's [Gentle Guide to the Grammar of Graphics](https://pkg.garrickadenbuie.com/gentle-ggplot2) 


## Get inspiration
- Yan Holtz's [Dataviz Inspiration](https://www.dataviz-inspiration.com/)
- Neal Grantham's [TidyTuesday Rocks app](https://nsgrantham.shinyapps.io/tidytuesdayrocks/)
- Andy Kirk's [The little of visualisation design](https://visualisingdata.com/the-little-of-visualisation-design/) 
- Yan Holtz's [R Graph Gallery](https://r-graph-gallery.com/)
- Jonas Schoeley's [HMD explorer app](https://jschoeley.shinyapps.io/hmdexp/)


## Watch 
- Hans Rosling: [sample talk](https://youtu.be/BZoKfap4g4w); [Factfulness](https://www.amazon.com/Factfulness-Reasons-World-Things-Better/dp/1250107814); [gapminder.org](https://www.gapminder.org/tools/#$chart-type=bubbles&url=v1)
- Nathaniel Smith's [talk on the principles of viridis palettes](https://youtu.be/xAoljeRJ3lU)
- David Robinson's [RStudio Conference 2019 talk](https://posit.co/resources/videos/the-unreasonable-effectiveness-of-public-work/) on the immense benefits of being open and sharing stuff freely 
- John Burn-Murdoch's [RStudio 2021 talk](https://youtu.be/L5_4kuoiiKU)
- [Thread on excess deaths plots](https://twitter.com/ikashnitsky/status/1409472083965349892) 
- Jim Vaupel's [brilliant talk](https://twitter.com/ikashnitsky/status/1512700871968186379) on the unique central positioning of demography in science  


## Quarto closeread format aka scrollytelling
- https://closeread.dev
- Winners of the [Closeread Prize - Data-Driven Scrollytelling with Quarto - Posit](https://posit.co/blog/closeread-prize-winners/)
- Óscar Bartolomé Pato's [EURO 2024 Final Scrollytelling Analysis](https://data-kicks.github.io/euro_final_scrollytelling_analysis/euro_final_scrollytelling_analysis.html)
- Ansgar Wolsing's [World Population Flags](https://bydata.github.io/population-flags)   
*DO EXPLORE ALL OF THE WINNERS*


## Tools to explore
- Posit's [ggplot2 extensions gallery](https://exts.ggplot2.tidyverse.org/gallery/)
- Jan Broder Engler's [{tidyplots}](https://tidyplots.org/)
- Grant McDermott's [{tinyplot}](https://grantmcdermott.com/tinyplot/) -- this is a supercharged ggplot2 base R alternative 
- Luis D. Verde Arregoitia's [Large Language Model tools for R](https://luisdva.github.io/llmsr-book/)
- Oli Hawkins's [pilot - an attractive, minimal, general purpose ggplot2 theme with an accessible discrete color palette](https://github.com/olihawkins/pilot)
- Kyle Walker's [{mapgl}](https://walker-data.com/mapgl/)
- Teun van den Brand's [{legendry}](https://teunbrand.github.io/legendry/) -- to add dataviz elements in you legends

## Various cool dataviz and other unclassified links
- Years of life stolen by gun shooting in the US -- [dataviz by Periscopic](https://guns.periscopic.com) 
- NYT Giorgia Lupi's [Long COVID data storytelling](https://www.nytimes.com/interactive/2023/12/14/opinion/my-life-with-long-covid.html?unlocked_article_code=1.F00.435C.ojkN6YhWx43Q) 
- Miguel HG's [US Baby Boom on a Lexis plot](https://www.reddit.com/r/dataisbeautiful/comments/1lgrd8x)
- [30 Charts That Show How Covid Changed Everything in March 2020 - The New York Times](https://www.nytimes.com/interactive/2025/03/09/upshot/covid-lockdown-five-year-charts.html?unlocked_article_code=1.204.6Wc6.m8TgWsSu9897\&smid=url-share)
- John Burn-Murdoch's [Excess c19 death's plot](https://www.ft.com/content/a2901ce8-5eb7-4633-b89c-cbdf5b386938)
- Yan Holtz's [If only your chart could talk](https://prodigious-trailblazer-3628.kit.com/posts/if-only-your-chart-could-talk)
- NYT (Motoko Rich, Amanda Cox, Matthew Bloch) [US districts school kids performance against parent's wealthiness](https://www.nytimes.com/interactive/2016/04/29/upshot/money-race-and-success-how-your-school-district-compares.html)
- Eye-bleedingly ugly [dataviz that succeeds in grabbing attention](https://bsky.app/profile/ikashnitsky.phd/post/3lfpais3h4c2x) 
- Yan Holtz's [post on dual axes](https://www.linkedin.com/posts/yan-holtz-2477534a_dataviz-activity-7289613046396727297-NOTk)
- Josef Fruehwald's [Light vs Dark](https://jofrhwld.github.io/blog/posts/2025/07/2025-07-14_light-color/)

## My links and materials 
- [Thread](https://twitter.com/ikashnitsky/status/1380247006170509312) on log transformation of the ratios
- [Post on efficient RStudio layout](https://ikashnitsky.github.io/2018/perfect-rstudio-layout/)
- [Replication materials](https://github.com/ikashnitsky/sex-gap-e0-pnas) for Zarulli etal 2021 PNAS paper
- Boxplot + jitter example: [tweet](https://twitter.com/ikashnitsky/status/1403645553637011461)  
- US names shiny app: [repository](https://github.com/ikashnitsky/us-names-app); [tweet](https://twitter.com/ikashnitsky/status/1203840297911889920); [shiny app](https://ikashnitsky.shinyapps.io/us-names/)  

## Other curated collections of resources
- Oscar Baruffa's [Big Book of R](https://www.bigbookofr.com)
- Andrew Heiss's [Helpful Resources](https://datavizf24.classes.andrewheiss.com/resource/)
- Nicola Rennie's [Data Science Resources](https://nrennie.rbind.io/data-science-resources)
- Antti Rask's [ggplot2 Extended book, Resources chapter](https://ggplot2-extended-book.com/introduction#sec-further-resources)
- Erik Gahner Larsen's [Awesome ggplot2](https://github.com/erikgahner/awesome-ggplot2)
- Joscelin Rocha-Hidalgo's [Resources database](https://www.resourcesdatabase.com)
- Michigan Alzheimer’s Disease Center’s [Resource Library](https://michiganadc.github.io/dmsc-madc/resources.html#category=R)
