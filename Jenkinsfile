pipeline {
    agent any

    parameters {
        booleanParam(name: 'Re_init', defaultValue: false, description: 'Run terraform init if new module/provider added')
        booleanParam(name: 'Destroy', defaultValue: false, description: 'Run terraform destroy to clean up resources')
        booleanParam(name: 'Apply', defaultValue: false, description: 'Run terraform apply to create/update resources')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Git_cred', url: 'https://github.com/Rakshitsen/EKS-Infra.git'
            }
        }

        stage('Terraform Init') {
            when { expression { params.Re_init } }
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                     credentialsId: 'Aws_cred',
                                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Formatting') {
            steps {
                sh 'terraform fmt -recursive'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                     credentialsId: 'Aws_cred',
                                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when { expression { params.Apply } }
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                     credentialsId: 'Aws_cred',
                                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform apply --auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when { expression { params.Destroy } }
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                     credentialsId: 'Aws_cred',
                                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform destroy --auto-approve'
                }
            }
        }
    }
}
