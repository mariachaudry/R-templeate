#FROM rocker/tidyverse:latest

#ARG RSTUDIO_VERSION


## Install system packages
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends git zlib1g-dev libxml2-dev && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

#WORKDIR /work

#COPY ./dockerconfig/requirements.txt /work/requirements.txt

#COPY ./template_r_project /home/rstudio/
#COPY ./template_r_project /work/template_r_project

#RUN chown -R rstudio /work
#RUN chown -R rstudio /home/rstudio/kitematic

#CMD ["Rscript" , "/home/rstudio/src/tests/model/run_tests.R"]
#CMD ["Rscript" , "/home/rstudio/packages/model_package.R"]
#CMD ["Rscript" ,"/home/rstudio/src/packages/model_package1.R"]
#CMD ["/init"]
#CMD ["R"]
#CMD R -e "source('/home/rstudio/packages/model_package.R')"

FROM mariachaudry/rtemplate_v7
ARG RSTUDIO_VERSION
#RUN apt-get update && \ 
#    apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev
RUN R -e "install.packages('roxygen2')"

WORKDIR /work
COPY ./template_r_project /work/template_r_project/
COPY ./template_r_project /home/rstudio/
#USER rstudio
#RUN chown -R rstudio /work
#RUN chown -R rstudio /home/rstudio/kitematic

