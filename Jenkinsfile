pipeline {
    agent any

    parameters {
        booleanParam(name: 'Re_init', defaultValue: false, description: 'Run terraform init if new module/provider added')
        booleanParam(name: 'Destroy', defaultValue: false, description: 'Run terraform destroy to clean up resources')
        booleanParam(name: 'Checkov', defaultValue: false, description: 'Run Checkov to scan for security issues')
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

        stage('terraform checkov') {
            when {
                expression { params.Checkov }
            }
            steps {
                // The multiline script was not properly closed with '''
                sh '''
                python3 -m venv venv
                source venv/bin/activate
                pip install --upgrade pip
                pip install checkov
                checkov -d . --framework terraform --quiet
                '''
            }
        }

        // It's a good practice to include plan and apply stages
        // stage('terraform plan') {
        //     steps {
        //         sh 'terraform plan -out=tfplan'
        //     }
        // }

        // stage('terraform apply') {
        //     steps {
        //         sh 'terraform apply -auto-approve tfplan'
        //     }
        // }

        stage('terraform destroy') {
            when {
                expression { params.Destroy }
            }
            steps {
                sh 'terraform destroy --auto-approve'
            }
        }
    }
}
