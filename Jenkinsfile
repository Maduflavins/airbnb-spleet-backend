pipeline{
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage("Clone Repo"){
            steps{
                git credentialsId: 'githubuser', url: 'https://github.com/Maduflavins/airbnb-spleet-backend.git'
            }
        }
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t maduflavins/airbn-spleet-backend:${DOCKER_TAG}"
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerHubPwd')]) {
                    sh "docker login -u maduflavins -p ${dockerHubPwd}"
                    sh "docker push maduflavins/airbn-spleet-backend:${DOCKER_TAG}"
                }

            }
        }
        stage('Deploy to k8s'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sshagent(['airbnb-spleet']) {
                    sh "scp -o StrictHostKeyChecking=no service.yaml backend.yaml ubuntu@54.87.24.18:/home/ubuntu/"
                    script{
                        try{
                            sh "ssh ubuntu@54.87.24.18 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ubuntu@54.87.24.18 kubectl create -f ."
                        }
                    }             
}
            }
 }

}

}


def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}

