pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git(url: 'https://github.com/EduardUsatchev/codnyte-ci-cd.git', branch: 'main')
            }
        }
        stage('Artifact Build'){
            steps{
                sh '''
                    pwd
                    ls -la
                    docker build -t cognyte-app .
                '''
            }
        }
        stage('Run Container'){
            steps{
                sh '''
                    docker stop cognyte-app
                    docker rm cognyte-app
                    docker run -d -p 5000:5000 --name cognyte-app -e FLASK_APP=main.py -e FLASK_RUN_HOST=0.0.0.0 -e FLASK_RUN_PORT=5000 cognyte-app
                '''
            }
        }
        stage('Test Container'){
            steps{
                sh '''
                    docker exec cognyte-app python test_app.py
                '''
            }
        }
        stage('Publish Docker'){
            steps{
                sh '''
                    docker tag cognyte-app a18ab77c4b90/cognyte-app:latest
                    docker push a18ab77c4b90/cognyte-app:latest
                '''
            }
        }
    }
}

