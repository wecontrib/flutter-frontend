FROM ubuntu:latest

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Création et passage à un utilisateur non-root
RUN useradd -ms /bin/bash newuser
USER newuser
WORKDIR /home/newuser

# Téléchargement et installation de Flutter sous le répertoire de l'utilisateur
RUN git clone https://github.com/flutter/flutter.git /home/newuser/flutter
ENV PATH="/home/newuser/flutter/bin:${PATH}"

# Copie du projet Flutter dans le conteneur
COPY --chown=newuser:newuser ./wecontrib/ /home/newuser/app
WORKDIR /home/newuser/app

# Exécution de Flutter doctor
RUN flutter doctor -v

# Obtention des dépendances Flutter
RUN flutter pub get

CMD ["flutter", "test"]
