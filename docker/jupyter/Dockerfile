ARG PYTHON_VERSION=python-3.10.6
ARG BASE_IMAGE=jupyter/datascience-notebook
FROM $BASE_IMAGE:$PYTHON_VERSION
LABEL authors="madpin@gmail.com"
# LABEL org.opencontainers.image.source="https://github.com/MaastrichtU-IDS/jupyterlab"

ENV TZ=Europe/Dublin \
    JUPYTER_ENABLE_LAB=yes \
    GRANT_SUDO=yes \
    CHOWN_HOME=yes \
    CHOWN_HOME_OPTS=-R \
    RESTARTABLE=yes

# Change to root user to install things
USER root

RUN apt-get update && \
    apt-get install -y tzdata curl wget unzip zsh vim htop gfortran \
    python3-dev libpq-dev libclang-dev

#https://www.python-ldap.org/en/python-ldap-3.3.0/installing.html#installing-from-source
RUN apt-get install -y build-essential \
    libldap2-dev libsasl2-dev slapd ldap-utils tox \
    lcov valgrind

# ZSH >>
USER ${NB_UID}
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN mkdir -p ~/.oh-my-zsh/plugins/virtualenv/
RUN touch ~/.oh-my-zsh/plugins/virtualenv/virtualenv.plugin.zsh
RUN echo "\`conda config --set changeps1 false\`" >> ~/.oh-my-zsh/plugins/virtualenv/virtualenv.plugin.zsh
RUN echo 'setopt NO_HUP' >> ~/.zshrc
ENV SHELL=/bin/zsh
# << ZSH

# GOLANG >>
USER root
RUN sudo apt install -y golang-go

USER ${NB_UID}
RUN go install github.com/gopherdata/gophernotes@v0.7.5
RUN mkdir -p ~/.local/share/jupyter/kernels/gophernotes/
RUN cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/* \
    ~/.local/share/jupyter/kernels/gophernotes/
RUN chmod +w ~/.local/share/jupyter/kernels/gophernotes/kernel.json
RUN sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < \
    ~/.local/share/jupyter/kernels/gophernotes/kernel.json.in > \
    ~/.local/share/jupyter/kernels/gophernotes/kernel.json
# << GOLANG

# Jupyter Lab Extensions >>
USER ${NB_UID}

# Install yarn for handling npm packages
RUN npm install --global yarn
# Enable yarn global add:
ENV PATH="$PATH:$HOME/.yarn/bin"

# Jupyter Lab Extensions <<

# Other Python Kernels >>
USER ${NB_UID}

RUN mamba create --quiet -y -p "${CONDA_DIR}/envs/python36" python=3.6 ipykernel && \
    mamba create --quiet -y -p "${CONDA_DIR}/envs/python37" python=3.7 ipykernel && \
    mamba create --quiet -y -p "${CONDA_DIR}/envs/python38" python=3.8 ipykernel && \
    mamba create --quiet -y -p "${CONDA_DIR}/envs/python39" python=3.9 ipykernel && \
    mamba create --quiet -y -p "${CONDA_DIR}/envs/python310" python=3.10 ipykernel && \
    mamba create --quiet -y -p "${CONDA_DIR}/envs/python311" python=3.11 ipykernel

RUN mamba clean --all -f -y

USER root
RUN pip install ipykernel 
RUN python -m ipykernel install --name="Python"
RUN "${CONDA_DIR}/envs/python36/bin/python" -m ipykernel install --name="Python_v3.6" && \
    "${CONDA_DIR}/envs/python37/bin/python" -m ipykernel install --name="Python_v3.7"  && \
    "${CONDA_DIR}/envs/python37/bin/python" -m ipykernel install --name="Python_v3.8"  && \
    "${CONDA_DIR}/envs/python39/bin/python" -m ipykernel install --name="Python_v3.9" && \
    "${CONDA_DIR}/envs/python310/bin/python" -m ipykernel install --name="Python_v3.10" && \
    "${CONDA_DIR}/envs/python311/bin/python" -m ipykernel install --name="Python_v3.11"

RUN echo "conda activate ${conda_env}" >> "${HOME}/.bashrc"
# Other Python Kernels <<


# Fix Permissions >>
USER root
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    fix-permissions /opt && \
    fix-permissions /etc/jupyter && \
    fix-permissions /home/$NB_USER/.local
# Fix Permissions <<

# Pip >>
USER root
COPY pip.conf /opt/pip.conf
ENV PIP_CONFIG_FILE=/opt/pip.conf

COPY requirements.frozen requirements.frozen
RUN pip install -r requirements.frozen
# Pip <<

USER root
RUN chmod g-w,o-w /home/${NB_USER}/.oh-my-zsh/plugins/git && \
    chmod g-w,o-w /home/${NB_USER}/.oh-my-zsh/plugins && \
    chmod g-w,o-w /home/${NB_USER}/.oh-my-zsh && \
    chmod g-w,o-w /home/${NB_USER}/.oh-my-zsh && \
    chmod g-w,o-w /home/${NB_USER}/.oh-my-zsh/cache

# VS Code >>
USER root

RUN mamba install --quiet -y jupyter-server-proxy

# Install VS Code server and extensions
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server \
    --install-extension redhat.vscode-yaml \
    --install-extension ms-python.python \
    --install-extension vscjava.vscode-java-pack \
    --install-extension ginfuru.ginfuru-better-solarized-dark-theme \
    --install-extension oderwat.indent-rainbow \
    --install-extension mechatroner.rainbow-csv \
    --install-extension GrapeCity.gc-excelviewer \
    --install-extension redhat.vscode-xml \
    --install-extension ms-mssql.mssql \
    --install-extension eamodio.gitlens \
    --install-extension ms-toolsai.jupyter

# VS Code <<
COPY jupyter_config.py /etc/jupyter/jupyter_notebook_config.py
COPY code_settings.json /home/$NB_USER/.local/share/code-server/User/settings.json

CMD start-notebook.sh --no-browser --ip=* \
    --notebook-dir=/ipynbs \
    --NotebookApp.password='sha1:2bcbc05d66e2:d086dc4eb369ff248bbf8753e6b0c47c7059e4fa' \
    --SchedulerApp.db_url=sqlite:////ipynb/SchedulerApp.db
