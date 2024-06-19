pipeline {
    agent any

    environment {
        NODEJS_HOME = tool name: 'NodeJS 14', type: 'NodeJSInstallation'
        PATH = "${env.NODEJS_HOME}/bin:${env.PATH}"
        VENV = "venv"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: https://github.com/Ishanphogat17/react-django-app
            }
        }

        stage('Install Frontend Dependencies') {
            steps {
                dir('client') {
                    sh 'npm install'
                }
            }
        }

        stage('Run Frontend Tests') {
            steps {
                dir('client') {
                    sh 'npm test'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('client') {
                    sh 'npm run build'
                }
            }
        }

        stage('Set Up Python Environment') {
            steps {
                dir('server') {
                    sh 'python3 -m venv ${env.VENV}'
                    sh '. ${env.VENV}/bin/activate && pip
                }
            }
        }

        stage('Run Backend Tests') {
            steps {
                dir('server') {
                    sh '. ${env.VENV}/bin/activate && pytest'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}