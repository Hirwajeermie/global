pipeline {
  agent any

  environment {
    IMAGE_NAME = 'global-app'
    CONTAINER_NAME = 'global-container'
    PORT = '8080'
  }

  stages {
    stage('Clone Repository') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh "docker rm -f $CONTAINER_NAME || true"
          sh "docker rmi $IMAGE_NAME || true"
          docker.build(IMAGE_NAME)
        }
      }
    }

    stage('Run Tests') {
      steps {
        script {
          Replace with real test commands, e.g.:
          sh 'docker run --rm $IMAGE_NAME vendor/bin/phpunit'
        }
      }
    }

    stage('Run Container') {
      steps {
        script {
          sh "docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME"
          For multi-service, use docker-compose:
          sh 'docker-compose up -d --build'
        }
      }
    }
  }

  post {
    always {
      echo 'Cleaning up...'
      sh "docker rm -f $CONTAINER_NAME || true"
      sh "docker rmi $IMAGE_NAME || true"
      For docker-compose:
      sh 'docker-compose down -v || true'
    }
  }
}