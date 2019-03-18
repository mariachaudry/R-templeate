FROM rocker/rstudio

ARG RSTUDIO_VERSION

WORKDIR /work

COPY ./dockerconfig/requirements.txt /work/requirements.txt
COPY ./template_r_project /work/template_r_project

CMD Rscript /work/template_r_project/tests/model/run_tests.R
