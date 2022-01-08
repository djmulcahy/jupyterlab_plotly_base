FROM jupyter/base-notebook

USER $NB_UID

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter labextension install plotlywidget --no-build && \
    jupyter labextension install jupyterlab-plotly --no-build && \
    jupyter lab build && \
    npm cache clean --force && \
    unset NODE_OPTIONS && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV JUPYTER_ENABLE_LAB=yes
USER $NB_UID

RUN mkdir -p ~/data
RUN mkdir -p ~/notebooks

# Set dark theme in jupyter lab 
Run sed -i 's/JupyterLab Light/JupyterLab Dark/' /opt/conda/share/jupyter/lab/schemas/@jupyterlab/apputils-extension/themes.json
RUN pip install jupyterlab_vim

# Install required Python packages
COPY requirements.txt .

RUN pip install -r requirements.txt	--no-cache-dir

ENTRYPOINT jupyter lab
