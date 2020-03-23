# README

This repo contain the source of the "DTP authorization code Flow" specification in markdown.

## How to use it?

The repo contain the specification in markdown file, to generate the xml/html file use the toll [markdown2rfc](https://github.com/oauthstuff/markdown2rfc) as follow:

```
docker run -v "`pwd`:/data" danielfett/markdown2rfc dtp-authorization-code-flow.md
```

This command should be executed in the root folder of this repo, the instruction `-v "``pwd``:/data"` will get the current path and mount as volume in a data folder in the image.

## Diagram image

The source code of the PlantUML diagram can be found in [Diagram Source](http://www.plantuml.com/plantuml/uml/XLFHRjiw37ttL_0n1b8aj_Tbo9QXGHPi7OhPQBBrCL0bDXPgIvb4T-s-nj_YBnlbHe6zP9kV3F6SG_AGlF8a7DLLcNWfIeHAFCERwHH-Q4L58YHP1ylQawtG9SdAaAONkCsFlrcUy3UVynlSuRtNX9F5VW_pUPBmqyNx8tisY0l_gCqE7bXU2H994c5COQqPoC9QZv0x-wGLkfZZ5h_Nw2dglsDqnkYL9t5VQbz0LLCjIjZSh6C176-RjicpzGOcscZIWl12r5HOftyYZ6IfqH18XmeDHqi_1dV8y_bkdIP9bhVD8TCtKMh50h1W0LXsrBE0A74-k9PsZnxi0r1nXC98UAY4OOHrBoai2vIFeMifJCG4l4TGI4ANVY2-TDZBkwsTXj7Nsoyfi29ubiJGJg2mBMqJNFwqsUHmEVslJngt3JxljKE_rQRp_JYRXPIu9n-dS7RA_qyluSPAGTgQ6KoEFh-DHb-hSJzTEfnzblT9V-PaUKHdzoIqwKyCQi_BrIT4_606hzAQfNsOHiYWj4CPNUWfjaslojUbWrct0a511hNHZTrfavxWPWVNG5hZ6GqJM6F9MK0RNl-gCmh8WY-4mmaib88FWiHnzVkrTrECIXpuc_V3TfWg2CVCLGYZQ727l0XlwUa9VbnjO03S1k11AGm-0jlcANhQnUAnRkmZ6hWsX4uMmkpmjxDjct_SBRmUBGMTitTwjhvXtpid3BtiSNOA7Lxsqvd3ZHrgjJqK4TRBEjw9LJfc7wL4xoSE7npw8askqAYwAdy1)

To generate the SVG image just click on link "View as SVG" and in the new page right click and "Save as ..." to save in your local machine.

RFC needs a very specific RFC format described in [RFC7996](https://tools.ietf.org/html/rfc7996), to transform our SVG to this format we can use the tool [svgcheck](https://pypi.org/project/svgcheck/).

An easy way to use it is using a docker image with python, so we can avoid install python in our local mahcine. To run the image use:

```
docker run -t -v "`pwd`:/data" python:3
```

This command will mount you current path to a volume called data in the docker. Now install the tool using:

```
pip install svgcheck
```

and now transform the SVG using this command:

```
svgcheck -r -g -o DiagramRFC.svg Diagram.svg
```

You can see that in the markdown specification file we are referencing the RFC svg in as `![svg](DiagramRFC.svg "Diagram")` if you change the name of the generated SVG you need to change the md file also.