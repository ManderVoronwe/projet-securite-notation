# projet-securite-notation


## Création du Docker
```bash
docker build -t notation .
```

## Lancement du Docker
i le numéro du groupe
```bash
docker run -it -d -p 8080:1234 -e "ENV_SERVER_IP=192.168.7.173" --name=notation_Gi notation
```

## Check les logs
```bash
docker logs notation_Gi
```

## Arrêt et suppression du Docker
```bash
docker stop notation_Gi && docker rm notation_Gi
```
