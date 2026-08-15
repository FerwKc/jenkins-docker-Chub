# 🚀 Pipeline CI/CD con Jenkins, Docker y GitHub

Este proyecto documenta la configuración y despliegue automatizado de una aplicación web estática dentro de un entorno de Integración y Despliegue Continuo (CI/CD) utilizando **Git**, **GitHub**, **Jenkins** y **Docker**.

---

## 📁 Estructura del Proyecto

```text
jenkins-docker-Chub/
│
├── index.html        # Página web principal con la interfaz del estudiante
├── Dockerfile        # Definición de la imagen Nginx para el servidor web
├── Jenkinsfile       # Declaración de las etapas del pipeline en Jenkins
└── README.md         # Documentación del procedimiento realizado
🛠️ Tecnologías y Requisitos Previos
Control de Versiones: Git & GitHub

Orquestador CI/CD: Jenkins (Servicio en Windows)

Contenedores: Docker Desktop (Windows)

Servidor Web: Nginx (Imagen oficial nginx:alpine)

Puerto de despliegue: 8085

📝 Procedimiento Realizado
1. Inicialización y Vinculación del Repositorio Local
Se inicializó el repositorio local en la carpeta del proyecto:

PowerShell
git init
Se agregaron los archivos base y se crearon los commits iniciales organizados por características (feat).

Se renombró la rama principal a main y se vinculó al repositorio remoto de GitHub:

PowerShell
git branch -M main
git remote add origin [https://github.com/FerwKc/jenkins-docker-Chub.git](https://github.com/FerwKc/jenkins-docker-Chub.git)
Se realizó el primer push autenticando mediante un Personal Access Token (PAT) de GitHub.

2. Configuración del Entorno de Contenedores (Dockerfile)
Se creó un Dockerfile liviano basado en Nginx para servir la aplicación web en el puerto 80:

Dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
3. Declaración del Pipeline (Jenkinsfile)
Se implementó un pipeline declarativo estructurado en 4 etapas principales:

Clonación: Descarga del código fuente desde el repositorio en GitHub.

Verificación: Validación de existencia de archivos indispensables (index.html y Dockerfile).

Construcción: Creación de la imagen Docker etiquetada dinámicamente con el número de ejecución (BUILD_NUMBER).

Despliegue: Detención/eliminación automática de contenedores previos e inicio del nuevo contenedor mapeado en el puerto 8085.

Nota técnica: Debido a que Jenkins corre como servicio del sistema en Windows, se especificó la ruta absoluta del ejecutable de Docker Desktop (AppData/Local/Programs/DockerDesktop/resources/bin/docker.exe) para garantizar el acceso al binario desde los bloques bat.

4. Creación y Configuración del Job en Jenkins
En Jenkins (http://localhost:8080), se creó un nuevo item de tipo Pipeline llamado primerpipeline.

En la sección Pipeline, se seleccionó Pipeline script from SCM.

Se configuró el origen en Git con la URL del repositorio https://github.com/FerwKc/jenkins-docker-Chub.git.

Se especificó la rama de trabajo */main y el archivo Jenkinsfile.

5. Pruebas de Ejecución y Redespliegue Automático
Primera Ejecución (Build #5):

Se lanzó el pipeline manualmente desde Jenkins.

Las 4 etapas se completaron en verde de forma satisfactoria.

La aplicación se desplegó correctamente y fue accesible desde http://localhost:8085.

Prueba de Actualización de Código (Build #8):

Se modificó el archivo index.html simulando un cambio en producción.

Se enviaron los cambios al repositorio remoto (git commit + git push).

Se volvió a ejecutar el pipeline, reemplazando el contenedor anterior con la nueva versión de manera transparente y sin interrupciones.

💻 Comandos Útiles de Verificación
Verificar estado de contenedores:

PowerShell
docker ps -a
Verificar imágenes construidas por Jenkins:

PowerShell
docker images
Acceso a la aplicación web desplegada:
http://localhost:8085