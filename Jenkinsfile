pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: 'ce2661ac-2d76-4adf-b80a-c373f31728d2', 
                url: 'https://github.com/Aman-0308/Python-CICD.git',
                branch: 'main'
           }
        }

        stage('Build Docker Image'){
            steps{
                script{
                    sh '''
                    echo 'Build Docker Image'
                    docker build -t your_dockerhub_username/python-cicd:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push Docker Image to Repo'){
            steps{
                script{
                    sh '''
                    echo 'Push Docker Image to DockerHub'
                    docker push your_dockerhub_username/python-cicd:${BUILD_NUMBER}
                    '''
                }
            }
        }
        
        stage('Checkout K8S manifest SCM'){
            steps {
                git credentialsId: 'ce2661ac-2d76-4adf-b80a-c373f31728d2', 
                url: 'https://github.com/iam-veeramalla/cicd-demo-manifests-repo.git',
                branch: 'main'
            }
        }
        
        stage('Update K8S manifest & push to Repo'){
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: 'ce2661ac-2d76-4adf-b80a-c373f31728d2', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        cat deploy.yaml
                        sed -i '' "s/32/${BUILD_NUMBER}/g" deploy.yaml
                        cat deploy.yaml
                        git add deploy.yaml
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push https://github.com/iam-veeramalla/cicd-demo-manifests-repo.git HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}

