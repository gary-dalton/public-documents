---
title: Pandoc and Reveal
subtitle: Slideshows from Markdown
author: Gary Dalton
date: 10 July 2015
license: Apache License, Version 2.0
github:
  user: gary-dalton
  repo: gary-dalton.github.io
  branch: "master"
pandoc: pandoc -t html5 --standalone --section-divs --template=template_revealjs.html pandoc_reveal.md -o pandoc_reveal.html
tags: pandoc, revealjs, markdown, howto
draft: true
---

#

##

1. This slideshow is written in Markdown, a plain text format.
    - [view the slideshow in markdown](https://raw.githubusercontent.com/gary-dalton/gary-dalton.github.io/master/pandoc_reveal.md)
2. Converted into an HTML5, revealjs document using Pandoc.

Yes, it really is that easy.

## Aren't some steps missing?

Everything else just happens once you have it set up.

- Pandoc uses a template to convert the Markdown to HTML5.
- The HTML5 document is automatically formatted for use with and linked to reveal.js by the template.
- Reveal is a feature-rich javascript library that displays the slideshow.

# Advantages

1. Plain text files are universally editable, easy to version control, and flexible for many uses.
2. The slideshow is in HTML5 using javascript for usage anywhere with a browser. No special software is needed.
3. Widely used technology allows one to focus on the content and less on the formatting

# Markdown

## Plain text, formatted

Markdown is plain text with formatting syntax designed so that it can be converted to HTML and many other formats. Markdown is often used to format readme files, for writing messages in online discussion forums, and to create rich text using a plain text editor.

## Learn more

- [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
- [Markdown Basics](https://help.github.com/articles/markdown-basics/)
- [Markdown Tutorial](http://markdowntutorial.com/)

## What software is needed?

- Markdown may be created using any plain text editor. If you are doing a lot a plain text work, a good text editor is a must.
- My favorite is the free and open source [Atom](https://atom.io/).

# Pandoc

## What is it?

- Universal document converter
- Convert markdown documents (and others) to many other formats
- [Pandoc](http://pandoc.org/)

## Installation

There is a download file just for you at:
[Pandoc Install](http://pandoc.org/installing.html)

- Windows
- OSX
- Linux
- BSD
- Source

## Output to PDF
Output to PDF requires LaTeX.

- Windows: [MiKTeX](http://miktex.org/download)
- OSX: [Basic TeX](http://www.tug.org/mactex/morepackages.html)
- Linux: [TeX Live](http://www.tug.org/texlive/)
    - `apt-get install texlive`

# Run Pandoc

## Command line

Pandoc is run from the command line. This is not a tutorial on how to use the command line. If you are unsure of your command line skills, try one of the many excellent tutorials available though a [Google search](https://www.google.com/search?q=comand%20line%20tutorial).

I happen to be running this via Windows PowerShell but the commands are identical to a Linux BASH.

## Commands to create this slideshow are:

    cd my_working_directory
    pandoc -t html5 --template=templatecdn_revealjs.html --standalone --section-divs  pandoc_reveal.md -o pandoc_reveal.html

Pandoc has many options, see `pandoc --help`.

## Let's break it down

- **cd my_working_directory**: Change directory to my_working_directory. my_working_directory is where my files and templates are stored.

- **pandoc arguments**: Calls Pandoc with the specified arguments

## Arguments

- **-t FORMAT**: Specify the output FORMAT as HTML5
- **--template=FILE**: Selects the conversion template as templatecdn_revealjs.html. (More on this later)
- **--standalone**: Produce output with an appropriate header and footer and not just a snippet

## More arguments

- **--section-divs**: For HTML5 it wraps sections in `<section>` tags
- **pandoc_reveal.md**: This is the input file. Its format is automatically determined from the file extension
- **-o FILE**: Write output to the FILE pandoc_reveal.html

# Reveal.js

## Display HTML slideshows

Create excellent presentation slides using HTML. The easiest way to understand what it does is to see the demonstration.

[REVEAL.JS demonstration](http://lab.hakim.se/reveal-js/)

## How to use?

- Fork it from GitHub to have a locally run version
- Use content delivery network (CDN) files for Internet version
    - I typically use CDN
    - [CDN links](https://cdnjs.com/libraries/reveal.js)
- Set your template to either local or CDN files

# The Template

## Default

Pandoc comes with a default reveal.js template, called with the output FORMAT set to revealjs. Example:

    pandoc -t revealjs --standalone input.md -o output.html

## Custom

I prefer to use my own custom template. This template is available in the repository as [template_revealjs.html](https://raw.githubusercontent.com/gary-dalton/gary-dalton.github.io/master/template_revealjs.html).

Why? The custom template adds many new variables, i.e. the GitHub variables, outputs HTML5, and increases the configuration coverage for reveal.js.

    pandoc -t html5 --standalone --section-divs --template=template_revealjs.html pandoc_reveal.md -o pandoc_reveal.html

## Usage

The custom template is intended for use with an appropriate markdown file that includes YAML variables.

Fork [template_md_reveal.md](https://raw.githubusercontent.com/gary-dalton/gary-dalton.github.io/master/template_md_reveal.md) as your starting point markdown file.

# YAML

##

YAML is basically a variable: value format that may be used to set configuration values for pandoc and reveal.js.

~~~
---
# THIS IS YAML
title: Main Title
subtitle: Subtitle
author: Author Name
date: 10 July 2015
license: Apache License, Version 2.0
---
~~~

##

There may be more than one YAML block in a document. Each YAML block must start and end with 3 dashes. See [Extension: yaml_metadata_block](http://pandoc.org/README.html#metadata-blocks). Each variable that you set in YAML is available for use in the template.

## Usage

My *template_md_reveal.md* uses 2 YAML blocks, one at the top and one at the bottom of the file. The top YAML sets some generic variables. The bottom YAML sets configuration values for reveal.js.

# Conclusion

Create easy to maintain, share, and edit markdown files and turn them into feature-rich slideshows using pandoc and reveal.js.

---
# OPTIONS FOR REVEAL.JS TEMPLATE
# see https://github.com/hakimel/reveal.js#configuration
reveal:
    # REQUIRED
    path: https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.1.0

    # RECOMMENDED
    # beige/black/blood/league/moon/night/serif/simple/sky/solarized/white
    theme: night
    # none/fade/slide/convex/concave/zoom
    transition: concave
    # Use minified js and css. Make certain minified versions are available
    minified: true

    # OPTIONAL
    controls: true
    progress: true
    slideNumber: true
    history: false
    keyboard: true
    overview: true
    center: false
    touch: true
    loop: false
    rtl: false
    fragments: false
    embedded: false
    help: true
    autoSlide: false
    autoSlideSpeed: '2000'
    autoSlideStoppable: true
    mouseWheel: false
    hideAddressBar: true
    previewLinks: false
    transitionSpeed: 'default' # default/fast/slow
    backgroundTransition: 'none' # none/fade/slide/convex/concave/zoom
    viewDistance: '3'
    parallaxBackgroundImage: 'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg' # false or image path
    parallaxBackgroundSize: '2100px 900px'
    parallaxBackgroundHorizontal: '200'
    parallaxBackgroundVertical: '50'

---
