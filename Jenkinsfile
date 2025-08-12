pipeline {
    agent any

    parameters {
        booleanParam(name: 'Re_init', defaultValue: false, description: 'Run terraform init if new module/provider added')
    }

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', credentialsId: 'Git_cred', url: 'https://github.com/Rakshitsen/EKS-Infra.git'
            }
        }

        stage('terraform init') {
            when {
                expression { params.Re_init }
            }
            steps {
                echo 'Re-initializing Terraform...'
                sh 'terraform init'
            }
        }

        stage('terraform formatting') {
            steps {
                sh 'terraform fmt -recursive'
            }
        }

        stage('terraform validate') {
            steps {
                sh 'terraform validate'
            }
        }
    }
}
