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
          - name: alpinekubectl
            image: vittormaciel/alpine-kubectl:latest
            imagePullPolicy: Always
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
                    script {
                    sh 'mvn install -DskipTests'
                    sh 'mvn package -DskipTests'
                    if (env.BRANCH_NAME == 'master') {
                      echo 'Hello from master'
                  } else {
                      sh "echo 'Hello from ${env.BRANCH_NAME}!'"
                  }
                  }
                  }
                }
              }
              stage('Kaniko') {
                steps {
                    container('kaniko') {
                    //   if (env.BRANCH_NAME == 'dev') {
                    //     sh '/kaniko/executor --context `pwd` --destination $REGISTRY/$PROJETO:dev-$BUILD_NUMBER --force'
                    // } else {
                    //     sh '/kaniko/executor --context `pwd` --destination $REGISTRY/$PROJETO:latest --force'
                    //   }
                    // sh 'echo ${env.BRANCH_NAME}'
                  }
                }
              } 
              stage('Deploy') {
                steps {
                    container('alpinekubectl') {
                      withKubeConfig([credentialsId: 'kubeconfigjenkins']) {
                      sh 'kubectl apply -f deployment.yaml'
                  }
                }
               }
            }
        }
}