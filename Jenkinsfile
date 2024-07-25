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
                script{
                    def containerName = "cognyte-app"
                    def command = "docker ps -f name=${containerName} -a"
                    def commandOutput = sh(script: command, returnStdout: true).trim()

                    echo "Command: ${command}"
                    echo "Output: ${commandOutput}"

                    def isRunning = sh(script: "docker ps -q -f name=${containerName}", returnStdout: true).trim()
                    if (isRunning) {
                        echo "Container ${containerName} is running."
                    } else {
                        echo "Container ${containerName} is not running."
                    }

                        if (isRunning) {
                    // Stop the running container
                            sh "docker stop ${containerName}"
                            sh "docker rm ${containerName}"
                            }
                }
                sh '''
                    docker run -d -p 5000:5000 --name cognyte-app -e FLASK_APP=main.py -e FLASK_RUN_HOST=0.0.0.0 -e FLASK_RUN_PORT=5000 cognyte-app
                '''
            }
        }
        stage('Test Container'){
            steps{
                script
                 {
                    try
                    {
                        sh '''
                        docker exec cognyte-app python test_app
                         '''
                    }
                    catch (Exception e)
                    {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
            }}
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

