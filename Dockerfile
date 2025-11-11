FROM rocker/r-ver:4.3.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libglpk-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages('BiocManager', repos = 'http://cran.us.r-project.org')"
RUN R -e "BiocManager::install('phyloseq', force = TRUE)"
RUN R -e "install.packages(c('ggplot2', 'dplyr', 'tidyr', 'ggsignif', 'patchwork', 'readr'), repos = 'http://cran.us.r-project.org')"

# Set up the working directory
WORKDIR /app

# Copy the R scripts and data
COPY . .
