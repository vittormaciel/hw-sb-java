pipeline {
  agent { docker { image 'maven:3.9.0-eclipse-temurin-11' } }
    stages {
      stage('build') {
        steps {
          sh 'mvn --version'
        }
    }
}
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: kaniko
            image: gcr.io/kaniko-project/executor:v1.6.0-debug
            imagePullPolicy: IfNotPresent
            command:
            - sleep
            args:
            - 99d
            volumeMounts:
              - name: jenkins-docker-cfg
                mountPath: /kaniko/.docker
          volumes:
          - name: jenkins-docker-cfg
            projected:
              sources:
              - secret:
                  name: regcred
                  items:
                    - key: .dockerconfigjson
                      path: config.json
        '''
    }
  }

    environment {
      PROJETO = 'helloworld-java'
      NOME = 'Vittor'
      EMAIL = 'contato@vittormaciel.com.br'
      NAMESPACE = 'jenkins-sandbox'
      PORTA = '8080'
      REGISTRY = 'vittormaciel'


    }
    
        stages {
            
              stage('Checkout sources') {
                steps {
                  checkout scm
                }
              }
              
              stage('Kaniko') {
                steps {
                    container('kaniko') {
                      sh '/kaniko/executor --context `pwd` --destination $REGISTRY/$PROJETO:$BUILD_NUMBER --force'
                  }
                }
              }
              
  }
}