pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-web-app'
        CONTAINER_NAME = 'web-app-container'
        PORT = '8080'
    }

    stages {
        stage('Clonación') {
            steps {
                echo 'Repositorio clonado correctamente desde GitHub.'
            }
        }

        stage('Verificación') {
            steps {
                script {
                    if (!fileExists('index.html') || !fileExists('Dockerfile')) {
                        error('Faltan archivos obligatorios (index.html o Dockerfile).')
                    }
                    echo 'Archivos obligatorios verificados correctamente.'
                }
            }
        }

        stage('Construcción') {
            steps {
                bat "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            }
        }

        stage('Despliegue') {
            steps {
                bat """
                    docker stop ${CONTAINER_NAME} 2>nul || exit 0
                    docker rm ${CONTAINER_NAME} 2>nul || exit 0
                    docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${BUILD_NUMBER}
                """
            }
        }
    }

    post {
        success {
            echo '¡El proceso de construcción y despliegue fue EXITOSO!'
        }
        failure {
            echo 'El proceso ha FALLADO. Revisa los logs para más detalles.'
        }
    }
}