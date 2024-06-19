pipeline {
    agent any

    environment {
        NODEJS_HOME = tool name: 'NodeJS 14', type: 'NodeJSInstallation'
        PATH = "${env.NODEJS_HOME}/bin:${env.PATH}"
        PYTHON_HOME = tool name: 'Python 3.9', type: 'hudson.plugins.python.PythonInstallation'
        VENV = "${WORKSPACE}/venv"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Ishanphogat17/react-django-app.git'
            }
        }

        stage('Install Frontend Dependencies') {
            steps {
                dir('client') {
                    sh 'npm install'
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
                    sh "python3 -m venv ${VENV}"
                    sh ". ${VENV}/bin/activate && pip install -r requirements.txt"
                }
            }
        }

        stage('Run Backend Tests') {
            steps {
                dir('server') {
                    sh ". ${VENV}/bin/activate && pytest"
                }
            }
        }

        stage('Run Django Migrations') {
            steps {
                dir('server') {
                    sh ". ${VENV}/bin/activate && python manage.py migrate"
                }
            }
        }

        stage('Collect Static Files') {
            steps {
                dir('server') {
                    sh ". ${VENV}/bin/activate && python manage.py collectstatic --noinput"
                }
            }
        }

        stage('Run Django Server') {
            steps {
                dir('server') {
                    sh ". ${VENV}/bin/activate && python manage.py runserver"
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
