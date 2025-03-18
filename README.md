# Dependencies
Para hacer este proyecto he utilizado algunas tecnologías que suelo utilizar en mi dia a dia.

[kompose](https://kompose.io/) sirve para generar un primer ejemplo de como deberian ser tus archivos de kubernetes a partir de tu compose.yml.

[uv](https://github.com/astral-sh/uv) es una herramienta genial para gestionar las dependencias en un proyecto de python.


# GIT
[convention](https://www.conventionalcommits.org/en/v1.0.0/)
## BRANCHES
Template: `<type>/<issue>/<description>`

## COMMITS
Template: `<type>(scope): <description>`

### TYPES:
- build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- docs: Documentation and repository configuration only changes
- feat: A new feature
- fix: A bug fix
- perf: A code change that improves performance
- refactor: A code change that neither fixes a bug nor adds a feature
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- test: Adding missing tests or correcting existing tests


# Makefile
| Command     | Description                                         |
|-------------|-----------------------------------------------------|
| init        | This command is used to initialize the project.     |
| setup       | Downloads and updates the backend submodule.        |
| venv        | Updates the local virtual environment.              |
| build       | Builds the Docker containers.                       |
| up          | Starts the Docker containers.                       |
| down        | Stops the Docker containers.                        |
| requirements| Installs required dependencies inside the container.|


# Pasos para Desplegar en AWS EKS
1. **Configurar el Registro de Imágenes**
Para poder subir imágenes de Docker, primero es necesario crear un repositorio en AWS Elastic Container Registry (ECR).

2. **Definir Configuración de Kubernetes**
Se deben definir los contenedores, servicios y configmaps para asegurar el correcto funcionamiento del servicio.

3. **Crear un Clúster en AWS EKS**
Se necesita un clúster de Amazon EKS donde se desplegarán los contenedores de Docker.

## Proceso de Subida y Despliegue
1. **Iniciar sesión en AWS**
Asegúrate de contar con las credenciales de acceso en la configuración de AWS:

Archivo: `~/.aws/credentials`

```ini
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

2. **Iniciar sesión en el Docker Registry y conectar con el Clúster**
```sh
aws eks --region <REGION> update-kubeconfig --name <CLUSTER-NAME>
aws ecr get-login-password --region <REGION> | docker login --username AWS --password-stdin <REGISTRY-ADDRESS>
```

3. **Construcción y subida de imágenes al registro**
```sh
# Hacer build de la imagen con las tags latest y el nombre de la tag que se va a subir.
docker build -t <REGISTRY-ADDRESS>/<REGISTRY-PATH>:latest -t <REGISTRY-ADDRESS>/<REGISTRY-PATH>:<TAG> ./backend
# Hacer push de todas las tags creadas previamente.
docker push <REGISTRY-ADDRESS>/<REGISTRY-PATH> --all-tags
```

### Despliegue en Kubernetes
#### Si la imagen ya ha sido desplegada antes:
```sh
# Configurar el context a utilizar.
kubectl config use-context <CLUSTER-ARN>
# Reiniciar el deploy del contenedor de la imagen subida.
kubectl rollout restart deploy/<CONTAINER-NAME>
```

#### Si es la primera vez que se despliega:
```sh
# Configurar el context a utilizar.
kubectl config use-context <CLUSTER-ARN>
# Aplicar todos los yaml configurados.
kubectl apply -f ./kube/
```

# Preguntas prueba tecnica
Imagina que en esta aplicación adicionalmente se quiere tener métricas de
lectura basadas en eventos y está siendo utilizada por un millón de usuarios
simultáneos.

1. **¿Cómo gestionarías esta cantidad de datos a nivel técnico?**

En experiencias previas, he trabajado con bases de datos NoSQL como MongoDB. Para casos concretos, este tipo de base de datos ofrece un buen rendimiento. En el caso de MongoDB, si trabajas con Atlas, también tienes la oportunidad de utilizar filtros avanzados que siguen el mismo esquema que Elasticsearch, ya que está construido sobre el mismo motor.

Como tecnología que puede aportar mucho valor en este tipo de escenarios, me gustaría mencionar ClickHouse. Es una base de datos tabular con un rendimiento excepcional. He realizado pruebas sobre tablas con más de 2.6 billones de filas y, al aplicar filtros, he obtenido resultados impresionantes en tan solo unos milisegundos.


3. **¿Qué tipo de base de datos utilizarías para almacenar las métricas de lectura de los usuarios? ¿Por qué?**

En el caso de MongoDB, se utiliza BSON. Sin embargo, volviendo a la tecnología que mencioné anteriormente, los datos se almacenan en formato Parquet.

Personalmente, cada vez me convence menos el almacenamiento de información en JSON o BSON, ya que considero que no es una forma óptima de almacenar los datos.

5. **¿Has trabajado con alguna base de datos o infraestructura que soporte un volumen alto de usuarios y datos? Si es así, cuéntanos tu experiencia y qué tecnologías utilizaste.**

He tenido la oportunidad de trabajar con una base de datos que almacenaba información de más de 4.5 millones de usuarios, incluyendo todos los datos de sus interacciones.
En nuestro caso, trabajábamos con dos bases de datos. Una de ellas estaba construida en MongoDB y en ella almacenábamos una gran cantidad de información sobre los usuarios, como sus intereses dentro de nuestra plataforma.

También guardábamos datos de ciertos escenarios para realizar búsquedas personalizadas muy específicas. Un ejemplo de esto era nuestro buscador de ciudades, que tenía en cuenta la ubicación del usuario, las ciudades más cercanas y sus principales intereses. Para ello, utilizábamos un esquema en MongoDB con toda la información de las ciudades. Luego, pasábamos la geolocalización del usuario y, además, las ubicaciones de los conciertos a los que había asistido. Con toda esta información, realizábamos búsquedas a través de MongoDB Atlas utilizando el motor de Lucene.

## Tecnologías nombradas
[lucene](https://lucene.apache.org/core/)

[parquet](https://parquet.apache.org/)

[clickhouse](https://clickhouse.com/)
