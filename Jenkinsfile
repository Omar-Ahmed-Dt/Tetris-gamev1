pipeline {
    agent {
        label "Jenkins-agent"
    }
    tools {
        jdk 'jdk17'
        nodejs 'node'
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        GIT_REPO_NAME = "Tetris-deployment-file"
        GIT_USER_NAME = "Omar-Ahmed-Dt"  
    }
    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage("Checkout from SCM"){
            steps {
                git 'https://github.com/Omar-Ahmed-Dt/Tetris-gamev1.git'
            }
        }
        stage("Sonarqube Analysis") {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=tetrisv1 \
                    -Dsonar.projectKey=tetrisv1'''
                }
            }
        }
        stage("Quality Gate") {
            steps {
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        // stage('OWASP FS SCAN') {
        //     steps {
        //         dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
        //         dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
        //     }
        // }

        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
         stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){   
                       sh "docker build -t tetrisv1 ."
                       sh "docker tag tetrisv1 omar9289/tetrisv1:latest "
                       sh "docker push omar9289/tetrisv1:latest "
                    }
                }
            }
        }
        stage("TRIVY") {
            steps {
                sh "trivy image omar9289/tetrisv1:latest > trivyimage.txt"
            }
        }
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Omar-Ahmed-Dt/Tetris-deployment-file.git'
            }
        }
        stage('Update Deployment File') {
            steps {
                 script {
                    withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                         NEW_IMAGE_NAME = "omar9289/tetrisv1:latest"  
                         sh "sed -i 's|image: .*|image: $NEW_IMAGE_NAME|' deployment.yml"
                         sh 'git add deployment.yml'
                         sh "git commit -m 'Update deployment image to $NEW_IMAGE_NAME'"
                         sh "git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:master"
            }
        }
      }
     }
    }
}