FROM adham/conda-base:latest

USER root

RUN conda install --quiet --yes \
    pandas \
    matplotlib \
    scikit-learn \
    nodejs \
    conda-forge::jupyterlab \
    conda-forge::tqdm \
    conda-forge::ipympl \
    conda-forge::conda-pack

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager \
    && jupyter labextension install jupyter-matplotlib \
    && jupyter nbextension enable --py widgetsnbextension

RUN jupyter lab build \
    && conda update --all --yes \
    && conda clean --all -f -y

EXPOSE 8888
ENTRYPOINT [ "jupyter", "lab", "--ip=0.0.0.0" ]

USER jovyan
