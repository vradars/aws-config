FROM ubuntu:18.04
ARG UNAMEX=ubuntu

RUN echo "'UNAMEX=${UNAMEX}'"

RUN apt-get update -y
RUN apt-get install -y git
RUN apt-get install -y python
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y pkg-config
RUN apt-get install -y cmake
RUN apt-get install -y build-essential
RUN apt-get install -y git apt-utils
RUN apt-get install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install nodejs -yq

# Setup home environment
RUN useradd ${UNAMEX}
ARG VTK_ROOT=/home/${UNAMEX}/VTK
ARG LD_LIBRARY_PATH=/usr/local/lib

# below does not need to be done since on AWS ubuntu instances
# ubuntu user is added by default
# it could be useful if we change user name
#RUN mkdir /home/${UNAMEX} && chown -R ${UNAMEX}: /home/${UNAMEX}

WORKDIR /home/${UNAMEX}
ENV HOME /home/${UNAMEX}
RUN touch /home/${UNAMEX}/.bash_profile
RUN chown -R ${UNAMEX} /home/${UNAMEX}

RUN cd /home/${UNAMEX}
RUN pwd
COPY bash_scripts /home/${UNAMEX}/bash_scripts
COPY TestingProcedures.md /home/${UNAMEX}
RUN /bin/bash bash_scripts/inital-setup.sh
RUN /bin/bash bash_scripts/install-swig.sh
RUN /bin/bash bash_scripts/install-tcl.sh
# RUN /bin/bash bash_scripts/install-qt5.sh
RUN /bin/bash bash_scripts/install-oce.sh
RUN /bin/bash bash_scripts/install-occ.sh
RUN /bin/bash bash_scripts/install-pip-vtk.sh
RUN /bin/bash bash_scripts/install-pygem.sh
RUN /bin/bash bash_scripts/install-rbf.sh
RUN /bin/bash bash_scripts/install-python-image-write.sh
RUN /bin/bash bash_scripts/install-vtk-src.sh
RUN /bin/bash bash_scripts/install-femtech.sh
RUN /bin/bash bash_scripts/install-MergePolyData.sh
RUN /bin/bash bash_scripts/install-projectedtexture.sh
RUN /bin/bash bash_scripts/install-paraview.sh
RUN /bin/bash bash_scripts/install-paraview-image-write.sh
RUN /bin/bash bash_scripts/install-google-drive.sh
RUN /bin/bash bash_scripts/install-complete.sh
RUN /bin/bash bash_scripts/install-rbf-brain-nodejs-service.sh 

# Adding Dependencies for RBF-BRAIN-NODEJS_SERVICE
RUN apt-get update --fix-missing
RUN apt install zip -y
RUN apt install python-pip -y
RUN pip install requests
RUN pip install pillow


# clean up and setup
COPY bash_scripts/bashrc /home/${UNAMEX}/.bashrc
RUN /bin/bash -c "source .bashrc"
RUN chown -R ${UNAMEX} /home/${UNAMEX}
