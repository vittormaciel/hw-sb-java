pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: maven
            image: maven:3.8.4-openjdk-17-slim
            imagePullPolicy: IfNotPresent
            command:
            - sleep
            args:
            - 99d
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
          - name: kubectl
            image: bitnami/kubectl
            imagePullPolicy: IfNotPresent
            command:
            - cat
            tty: true
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
              stage('Maven') {
                steps {
                  container('maven') {
                    sh 'mvn install -DskipTests'
                    sh 'mvn package -DskipTests'
                  }
                }
              }
              stage('Kaniko') {
                steps {
                    container('kaniko') {
                      sh '/kaniko/executor --context `pwd` --destination $REGISTRY/$PROJETO:latest --force'
                  }
                }
              }
              stage('Deploy') {
                steps {
                    container('maven') {
                      withCredentials([file(credentialsId: 'kubeconfigjenkins', variable: 'config')]) {
                      sh 'curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'
                      sh 'chmod +x ./kubectl'
                      sh 'export KUBECONFIG=$config'
                      sh './kubectl apply -f deployment.yaml'
                  }
                }
                }
              }
  }
}