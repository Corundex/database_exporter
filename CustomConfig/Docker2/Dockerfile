FROM corundex/database_exporter:latest

WORKDIR     /exporter/

COPY        config/ ./config/
COPY        database_exporter.yml .

EXPOSE      9285

ENTRYPOINT  [ "/exporter/database_exporter", "-logtostderr=true" ]

